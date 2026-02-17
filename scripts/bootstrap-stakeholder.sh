#!/usr/bin/env bash
set -euo pipefail

LANGUAGE="es"
RUN_DEMO=0
SKIP_SYSTEM=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Usage: scripts/bootstrap-stakeholder.sh [options]

Bootstrap a lightweight environment for end users and stakeholders.

Options:
  --lang <es|en>      Output language hint (default: es)
  --run-demo          Launch local demo stack after bootstrap
  --skip-system       Skip apt package installation
  --dry-run           Print actions without executing
  -h, --help          Show this help
EOF
}

log() {
  printf '[bootstrap-stakeholder] %s\n' "$*"
}

warn() {
  printf '[bootstrap-stakeholder][warn] %s\n' "$*" >&2
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
    --lang)
      LANGUAGE="${2:-}"
      shift 2
      ;;
    --run-demo)
      RUN_DEMO=1
      shift
      ;;
    --skip-system)
      SKIP_SYSTEM=1
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

if [[ "$LANGUAGE" != "es" && "$LANGUAGE" != "en" ]]; then
  warn "Invalid language: $LANGUAGE"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SUDO=()
if ((SKIP_SYSTEM == 0)) && [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
  if command -v sudo >/dev/null 2>&1; then
    SUDO=(sudo)
  else
    warn "sudo not found. Re-run as root or use --skip-system."
    exit 1
  fi
fi

if ((SKIP_SYSTEM == 0)); then
  log "Installing demo prerequisites (docker + compose)..."
  run_cmd "${SUDO[@]}" apt-get update -y
  run_cmd "${SUDO[@]}" apt-get install -y ca-certificates curl docker.io jq

  if ! docker compose version >/dev/null 2>&1; then
    if ! run_cmd "${SUDO[@]}" apt-get install -y docker-compose-v2; then
      run_cmd "${SUDO[@]}" apt-get install -y docker-compose-plugin
    fi
  fi
fi

log "Preparing local folders..."
run_cmd mkdir -p \
  "$REPO_ROOT/data/input" \
  "$REPO_ROOT/outputs/raw" \
  "$REPO_ROOT/outputs/insights"

if [[ ! -f "$REPO_ROOT/.env.stakeholder" ]]; then
  log "Creating .env.stakeholder"
  if ((DRY_RUN)); then
    printf '[dry-run] create %s\n' "$REPO_ROOT/.env.stakeholder"
  else
    cat > "$REPO_ROOT/.env.stakeholder" <<EOF
COGNITIVE_IMAGE_TAG=latest
COGNITIVE_ENV=local
COGNITIVE_SKIP_MODELS=1
COGNITIVE_FAST_MODE=1
TRANSFORMERS_OFFLINE=1
HF_HUB_OFFLINE=1
COGNITIVE_REDACT=0
COGNITIVE_VERBOSE=0
EOF
  fi
fi

if ((RUN_DEMO)); then
  log "Starting local stakeholder demo..."
  run_cmd docker compose -f "$REPO_ROOT/docker-compose.local-demo.yml" \
    --env-file "$REPO_ROOT/.env.stakeholder" up -d
fi

if [[ "$LANGUAGE" == "es" ]]; then
  cat <<'EOF'

Entorno listo para stakeholders.
Siguientes pasos:
  1. Copia documentos a data/input/
  2. Ejecuta: docker compose -f docker-compose.local-demo.yml --env-file .env.stakeholder up -d
  3. Abre: http://localhost:8501

EOF
else
  cat <<'EOF'

Stakeholder environment is ready.
Next steps:
  1. Copy files into data/input/
  2. Run: docker compose -f docker-compose.local-demo.yml --env-file .env.stakeholder up -d
  3. Open: http://localhost:8501

EOF
fi
