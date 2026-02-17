#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT_DIR"

echo "[test-bootstrap] Checking bootstrap scripts exist..."
for file in \
  scripts/bootstrap.sh \
  scripts/bootstrap-android.sh \
  scripts/bootstrap-stakeholder.sh \
  scripts/build-deb.sh \
  scripts/export-release.sh; do
  if [[ ! -f "$file" ]]; then
    echo "Missing required file: $file" >&2
    exit 1
  fi
done

echo "[test-bootstrap] Checking shell syntax..."
bash -n \
  scripts/bootstrap.sh \
  scripts/bootstrap-android.sh \
  scripts/bootstrap-stakeholder.sh \
  scripts/build-deb.sh \
  scripts/export-release.sh

echo "[test-bootstrap] Running dry-run smoke tests..."
bash scripts/bootstrap.sh --dry-run --skip-system --skip-python --role developer --profile lite
bash scripts/bootstrap-stakeholder.sh --dry-run --skip-system --lang es
bash scripts/bootstrap-android.sh --dry-run --allow-non-termux --role devsecops --profile lite

echo "[test-bootstrap] OK"
