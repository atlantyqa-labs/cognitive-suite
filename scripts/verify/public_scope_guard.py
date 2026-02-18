#!/usr/bin/env python3
"""Guardrail for public-scope safety on PRs to main.

Checks only changed files between base/head to avoid false positives
from historical files that might already exist in the repository.
"""

from __future__ import annotations

import argparse
import os
import subprocess
import sys
from pathlib import Path


BLOCKED_PATH_PREFIXES = (
    "docs/internal/",
    "ops/",
    "governance/",
    "evidence/",
    "credentials/",
    "inputs/",
    "outputs/",
    "bash/GitDevSecDataAIOps/",
    "gitops/repo-governance/",
)

ALLOWLIST_PATH_PREFIXES = (
    "metrics/engagement/",
    "outputs/ci-evidence/",
)

BLOCKED_KEYWORDS = (
    "AOA-EOM",
    "Annual Operating Agreement",
    "Evidence Operating Model",
    "FTE Digital Framework v1.0",
)

TEXT_SUFFIXES = {
    ".md",
    ".txt",
    ".json",
    ".jsonl",
    ".csv",
    ".yml",
    ".yaml",
    ".toml",
    ".ini",
    ".py",
    ".sh",
    ".js",
    ".jsx",
    ".ts",
    ".tsx",
}


def _run_git(*args: str) -> str:
    return subprocess.check_output(["git", *args], text=True).strip()


def _exists_ref(ref: str) -> bool:
    try:
        _run_git("rev-parse", "--verify", "--quiet", ref)
        return True
    except subprocess.CalledProcessError:
        return False


def _resolve_base_ref(user_base_ref: str | None) -> str:
    if user_base_ref:
        return user_base_ref
    env_base = os.getenv("GITHUB_BASE_REF")
    if env_base:
        return f"origin/{env_base}"
    return "HEAD~1"


def _resolve_changed_files(base_ref: str, head_ref: str) -> list[str]:
    if not _exists_ref(base_ref):
        # If base is unavailable, inspect only the last commit changes.
        base_ref = "HEAD~1" if _exists_ref("HEAD~1") else "HEAD"
    if not _exists_ref(head_ref):
        raise RuntimeError(f"Head ref '{head_ref}' does not exist.")
    if base_ref == head_ref:
        return []
    if base_ref == "HEAD":
        raw = _run_git("diff-tree", "--no-commit-id", "--name-only", "-r", head_ref)
    else:
        raw = _run_git("diff", "--name-only", "--diff-filter=ACMR", f"{base_ref}...{head_ref}")
    return [line.strip() for line in raw.splitlines() if line.strip()]


def _is_allowed(path: str) -> bool:
    return any(path.startswith(prefix) for prefix in ALLOWLIST_PATH_PREFIXES)


def _check_blocked_paths(changed_files: list[str]) -> list[str]:
    violations: list[str] = []
    for path in changed_files:
        if _is_allowed(path):
            continue
        if any(path.startswith(prefix) for prefix in BLOCKED_PATH_PREFIXES):
            violations.append(path)
    return violations


def _check_blocked_keywords(changed_files: list[str]) -> list[str]:
    violations: list[str] = []
    for path in changed_files:
        if _is_allowed(path):
            continue
        if not path.startswith("docs/"):
            continue
        suffix = Path(path).suffix.lower()
        if suffix not in TEXT_SUFFIXES:
            continue
        file_path = Path(path)
        if not file_path.exists() or not file_path.is_file():
            continue
        try:
            content = file_path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        lower_content = content.casefold()
        for keyword in BLOCKED_KEYWORDS:
            if keyword.casefold() in lower_content:
                violations.append(f"{path} -> '{keyword}'")
    return violations


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Validate PR diff against public-scope guardrails."
    )
    parser.add_argument(
        "--base-ref",
        default=None,
        help="Base git ref (default: origin/$GITHUB_BASE_REF, else HEAD~1).",
    )
    parser.add_argument(
        "--head-ref",
        default="HEAD",
        help="Head git ref to validate (default: HEAD).",
    )
    args = parser.parse_args()

    base_ref = _resolve_base_ref(args.base_ref)
    changed_files = _resolve_changed_files(base_ref, args.head_ref)
    print(f"[public-scope-guard] base={base_ref} head={args.head_ref}")
    print(f"[public-scope-guard] changed_files={len(changed_files)}")

    path_violations = _check_blocked_paths(changed_files)
    keyword_violations = _check_blocked_keywords(changed_files)

    if not path_violations and not keyword_violations:
        print("[public-scope-guard] OK")
        return 0

    print("[public-scope-guard] FAILED")
    if path_violations:
        print("Blocked path changes detected:")
        for item in path_violations:
            print(f"  - {item}")
    if keyword_violations:
        print("Blocked keywords detected in docs:")
        for item in keyword_violations:
            print(f"  - {item}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
