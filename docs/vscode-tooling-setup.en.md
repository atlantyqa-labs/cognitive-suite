---
title: VSCode for early adopters
---

# Canonical VSCode profile

This guide defines the **versioned VSCode baseline** for `cognitive-suite`
early adopters (developer and devsecops).

## What is canonized in the repository

The workspace is defined in:

- `.vscode/settings.json`
- `.vscode/extensions.json`
- `.vscode/tasks.json`

This gives every contributor the same operational baseline for linting,
formatting, terminal behavior, and repeatable project tasks.

## Key configuration

### Python

- Default interpreter: `${workspaceFolder}/.venv/bin/python`
- Auto-activation of the environment in terminal
- Ruff formatting on save
- Explicit Ruff code actions for fixes/import sorting

### Shell, YAML, and JSON

- Shell format-on-save (`shell-format`)
- YAML and JSON format-on-save
- Linux default terminal profile: `bash -l`

### Workspace hygiene

- Excludes caches and env folders (`.venv`, `.venv-android`, `node_modules`)
- Shared editor guardrails: 80/120 rulers, trimmed trailing spaces,
  final newline

## Recommended extensions

`.vscode/extensions.json` recommends the baseline stack:

- Python + Pylance + Ruff
- ShellCheck + Shell Format
- YAML
- Docker
- GitHub Actions
- GitLens
- Makefile Tools
- Remote SSH / Dev Containers

## Included tasks (Run Task)

`.vscode/tasks.json` ships repo-native tasks:

- `Bootstrap: Developer (full)`
- `Bootstrap: DevSecOps (full)`
- `Bootstrap: Stakeholder Demo (es)`
- `Checks: Bootstrap Smoke`
- `Docs: Build Public (strict)`
- `Docs: Build Internal (strict)`
- `Security: pip-audit core`
- `Docker: Build Stack`
- `Run: UI local`

## Recommended onboarding (Ubuntu/Debian)

1. Run role bootstrap:
   ```bash
   ./scripts/bootstrap.sh --role developer --profile full
   ```
2. Open the repository in VSCode.
3. Install recommended extensions when prompted.
4. Confirm interpreter: `.venv/bin/python`.
5. Run `Run Task` and start with `Checks: Bootstrap Smoke`.

## Android early adopter (Termux)

Android bootstrap creates `.venv-android`. When using VSCode through
remote/SSH workflows, use the remote interpreter and keep these tasks as the
canonical repo operating model.

## Security notes

- No secrets are stored in `.vscode/`.
- Credentials/tokens must stay in local non-versioned `.env*` files.
