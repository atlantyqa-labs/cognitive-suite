#!/usr/bin/env bash
set -euo pipefail

ROLE="developer"
PROFILE="full"
SKIP_SYSTEM=0
SKIP_PYTHON=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Usage: scripts/bootstrap.sh [options]

Bootstrap local Ubuntu/Debian environment for early adopters in developer/devsecops roles.

Options:
  --role <developer|devsecops>   Target role (default: developer)
  --profile <full|lite>          Dependency profile (default: full)
  --skip-system                  Skip apt/system package installation
  --skip-python                  Skip virtualenv + pip installation
  --dry-run                      Print actions without executing
  -h, --help                     Show this help
EOF
}

log() {
  printf '[bootstrap] %s\n' "$*"
}

warn() {
  printf '[bootstrap][warn] %s\n' "$*" >&2
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
    --skip-system)
      SKIP_SYSTEM=1
      shift
      ;;
    --skip-python)
      SKIP_PYTHON=1
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

if [[ "$PROFILE" != "full" && "$PROFILE" != "lite" ]]; then
  warn "Invalid profile: $PROFILE"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SUDO=()
if ((SKIP_SYSTEM == 0)) && [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO=(sudo)
  else
    warn "sudo not found. Re-run as root or install sudo."
    exit 1
  fi
fi

if ((SKIP_SYSTEM == 0)); then
  if [[ -r /etc/os-release ]]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    if [[ "${ID:-}" != "ubuntu" && "${ID_LIKE:-}" != *"debian"* ]]; then
      warn "Detected distro '${ID:-unknown}'. Script is optimized for Ubuntu/Debian."
    fi
  fi

  log "Installing system prerequisites (apt)..."
  run_cmd "${SUDO[@]}" apt-get update -y

  common_pkgs=(
    bash
    ca-certificates
    curl
    git
    jq
    make
    python3
    python3-pip
    python3-venv
    shellcheck
  )

  if [[ "$ROLE" == "devsecops" ]]; then
    common_pkgs+=(gnupg lsb-release)
  fi

  run_cmd "${SUDO[@]}" apt-get install -y "${common_pkgs[@]}"

  if ! command -v docker >/dev/null 2>&1; then
    log "Installing Docker engine..."
    run_cmd "${SUDO[@]}" apt-get install -y docker.io
  fi

  if ! docker compose version >/dev/null 2>&1; then
    log "Installing Docker Compose plugin..."
    if ! run_cmd "${SUDO[@]}" apt-get install -y docker-compose-v2; then
      run_cmd "${SUDO[@]}" apt-get install -y docker-compose-plugin
    fi
  fi

  if getent group docker >/dev/null 2>&1 && [[ " $(id -nG) " != *" docker "* ]]; then
    log "Adding user '${USER:-unknown}' to docker group..."
    run_cmd "${SUDO[@]}" usermod -aG docker "${USER:-}"
    warn "You may need to log out and back in to apply docker group membership."
  fi
fi

log "Preparing repository directories..."
run_cmd mkdir -p \
  "$REPO_ROOT/data/input" \
  "$REPO_ROOT/outputs/raw" \
  "$REPO_ROOT/outputs/insights" \
  "$REPO_ROOT/qdrant_storage"

if [[ ! -f "$REPO_ROOT/.env.local" ]]; then
  log "Creating .env.local"
  if ((DRY_RUN)); then
    printf '[dry-run] create %s\n' "$REPO_ROOT/.env.local"
  else
    cat > "$REPO_ROOT/.env.local" <<EOF
COGNITIVE_UID=$(id -u)
COGNITIVE_GID=$(id -g)
COGNITIVE_ENV=dev
COGNITIVE_REDACT=0
COGNITIVE_VERBOSE=0
EOF
  fi
fi

if ((SKIP_PYTHON == 0)); then
  log "Preparing Python virtual environment..."
  if [[ ! -d "$REPO_ROOT/.venv" ]]; then
    run_cmd python3 -m venv "$REPO_ROOT/.venv"
  fi

  if ((DRY_RUN)); then
    printf '[dry-run] %q %q %q %q\n' "$REPO_ROOT/.venv/bin/pip" install --upgrade pip
  else
    "$REPO_ROOT/.venv/bin/pip" install --upgrade pip
  fi

  requirements=()
  if [[ "$PROFILE" == "lite" ]]; then
    requirements=(
      "$REPO_ROOT/requirements-ci.txt"
      "$REPO_ROOT/requirements-docs.txt"
    )
  else
    requirements=(
      "$REPO_ROOT/requirements.txt"
      "$REPO_ROOT/requirements-docs.txt"
      "$REPO_ROOT/requirements-ci.txt"
    )
  fi

  for req in "${requirements[@]}"; do
    if [[ -f "$req" ]]; then
      if ((DRY_RUN)); then
        printf '[dry-run] %q %q %q %q\n' "$REPO_ROOT/.venv/bin/pip" install -r "$req"
      else
        "$REPO_ROOT/.venv/bin/pip" install -r "$req"
      fi
    fi
  done

  if [[ "$ROLE" == "devsecops" ]]; then
    log "Installing DevSecOps Python utilities..."
    if ((DRY_RUN)); then
      printf '[dry-run] %q %q %q %q %q\n' \
        "$REPO_ROOT/.venv/bin/pip" install pip-audit detect-secrets bandit
    else
      "$REPO_ROOT/.venv/bin/pip" install pip-audit detect-secrets bandit
    fi
  fi

  if ((DRY_RUN)); then
    printf '[dry-run] %q %q %q\n' "$REPO_ROOT/.venv/bin/python" "$REPO_ROOT/cogctl.py" init
  else
    "$REPO_ROOT/.venv/bin/python" "$REPO_ROOT/cogctl.py" init
  fi
fi

log "Bootstrap finished."
cat <<EOF

Next steps:
  1. source .venv/bin/activate
  2. make build
  3. make run

Alternative demo mode:
  docker compose -f docker-compose.local-demo.yml --env-file .env.local up -d
EOF
