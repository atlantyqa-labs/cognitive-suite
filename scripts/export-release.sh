#!/usr/bin/env bash
set -euo pipefail

out_dir="${1:-dist/source}"
mkdir -p "${out_dir}"

repo_root="$(git rev-parse --show-toplevel)"
repo_name="$(basename "${repo_root}")"
short_sha="$(git rev-parse --short=12 HEAD)"
archive_prefix="${repo_name}-${short_sha}"

git -C "${repo_root}" archive \
  --format=zip \
  --prefix="${archive_prefix}/" \
  --output="${out_dir}/${archive_prefix}.zip" \
  HEAD

git -C "${repo_root}" archive \
  --format=tar.gz \
  --prefix="${archive_prefix}/" \
  --output="${out_dir}/${archive_prefix}.tar.gz" \
  HEAD
