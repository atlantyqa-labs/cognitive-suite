#!/usr/bin/env bash
set -euo pipefail

ROLE="developer"
PROFILE="lite"
DRY_RUN=0
ALLOW_NON_TERMUX=0

usage() {
  cat <<'EOF'
Usage: scripts/bootstrap-android.sh [options]

Bootstrap Android (Termux) early-adopter environment for developer/devsecops workflows.

Options:
  --role <developer|devsecops>   Target role (default: developer)
  --profile <lite|full>          Install profile (default: lite)
  --allow-non-termux             Allow execution outside Termux (for CI dry-runs)
  --dry-run                      Print actions without executing
  -h, --help                     Show this help
EOF
}

log() {
  printf '[bootstrap-android] %s\n' "$*"
}

warn() {
  printf '[bootstrap-android][warn] %s\n' "$*" >&2
}

run_cmd() {
  if ((DRY_RUN)); then
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
    return 0
  fi
  "$@"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --role)
      ROLE="${2:-}"
      shift 2
      ;;
    --profile)
      PROFILE="${2:-}"
      shift 2
      ;;
    --allow-non-termux)
      ALLOW_NON_TERMUX=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      warn "Unknown argument: $1"
      usage
      exit 1
      ;;
  esac
done

if [[ "$ROLE" != "developer" && "$ROLE" != "devsecops" ]]; then
  warn "Invalid role: $ROLE"
  exit 1
fi

if [[ "$PROFILE" != "lite" && "$PROFILE" != "full" ]]; then
  warn "Invalid profile: $PROFILE"
  exit 1
fi

if [[ -z "${PREFIX:-}" || "${PREFIX:-}" != *"com.termux"* ]]; then
  if ((ALLOW_NON_TERMUX == 0)); then
    warn "This script is intended for Termux on Android."
    warn "Use --allow-non-termux only for dry-runs or CI checks."
    exit 1
  fi
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

log "Installing Termux prerequisites..."
run_cmd pkg update -y

pkgs=(
  curl
  git
  jq
  make
  nodejs-lts
  openssh
  proot-distro
  python
)

if [[ "$ROLE" == "devsecops" ]]; then
  pkgs+=(docker)
fi

run_cmd pkg install -y "${pkgs[@]}"

log "Preparing project directories..."
run_cmd mkdir -p \
  "$REPO_ROOT/data/input" \
  "$REPO_ROOT/outputs/raw" \
  "$REPO_ROOT/outputs/insights"

if [[ ! -f "$REPO_ROOT/.env.android" ]]; then
  log "Creating .env.android"
  if ((DRY_RUN)); then
    printf '[dry-run] create %s\n' "$REPO_ROOT/.env.android"
  else
    cat > "$REPO_ROOT/.env.android" <<'EOF'
COGNITIVE_ENV=mobile
COGNITIVE_REDACT=0
COGNITIVE_VERBOSE=0
# Optional remote Docker endpoint for full stack execution from Android:
# DOCKER_HOST=ssh://user@your-linux-host
EOF
  fi
fi

if [[ ! -d "$REPO_ROOT/.venv-android" ]]; then
  run_cmd python -m venv "$REPO_ROOT/.venv-android"
fi

if ((DRY_RUN)); then
  printf '[dry-run] %q %q %q %q\n' "$REPO_ROOT/.venv-android/bin/pip" install --upgrade pip
else
  "$REPO_ROOT/.venv-android/bin/pip" install --upgrade pip
fi

lite_reqs=(
  "$REPO_ROOT/requirements-ci.txt"
  "$REPO_ROOT/requirements-docs.txt"
)

for req in "${lite_reqs[@]}"; do
  if [[ -f "$req" ]]; then
    if ((DRY_RUN)); then
      printf '[dry-run] %q %q %q %q\n' "$REPO_ROOT/.venv-android/bin/pip" install -r "$req"
    else
      "$REPO_ROOT/.venv-android/bin/pip" install -r "$req"
    fi
  fi
done

if [[ "$PROFILE" == "full" && -f "$REPO_ROOT/requirements.txt" ]]; then
  warn "Attempting full Python stack on Android. Some wheels may be unavailable."
  if ((DRY_RUN)); then
    printf '[dry-run] %q %q %q %q\n' "$REPO_ROOT/.venv-android/bin/pip" install -r "$REPO_ROOT/requirements.txt"
  else
    if ! "$REPO_ROOT/.venv-android/bin/pip" install -r "$REPO_ROOT/requirements.txt"; then
      warn "Full local stack failed on Android. Use remote Docker host from .env.android."
    fi
  fi
fi

if ((DRY_RUN)); then
  printf '[dry-run] %q %q %q\n' "$REPO_ROOT/.venv-android/bin/python" "$REPO_ROOT/cogctl.py" init
else
  "$REPO_ROOT/.venv-android/bin/python" "$REPO_ROOT/cogctl.py" init
fi

run_cmd mkdir -p "${HOME}/.config/cognitive-suite"
if [[ ! -f "${HOME}/.config/cognitive-suite/android-remote.env" ]]; then
  if ((DRY_RUN)); then
    printf '[dry-run] create %s\n' "${HOME}/.config/cognitive-suite/android-remote.env"
  else
    cat > "${HOME}/.config/cognitive-suite/android-remote.env" <<'EOF'
# Optional remote Linux host for heavy Docker workloads:
# export DOCKER_HOST=ssh://devsecops@ubuntu-lab
# export COGNITIVE_IMAGE_TAG=latest
EOF
  fi
fi

log "Android bootstrap finished."
cat <<EOF

Next steps (Android / Termux):
  1. source .venv-android/bin/activate
  2. python cogctl.py --help
  3. (Optional) source ~/.config/cognitive-suite/android-remote.env
EOF
