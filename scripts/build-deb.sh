#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: scripts/build-deb.sh <version>" >&2
  echo "Example: scripts/build-deb.sh 0.1.0" >&2
  exit 1
fi

VERSION="$1"
if [[ ! "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+([.-][A-Za-z0-9]+)?$ ]]; then
  echo "Invalid version: $VERSION" >&2
  exit 1
fi

if ! command -v dpkg-deb >/dev/null 2>&1; then
  echo "dpkg-deb is required. Install with: sudo apt install dpkg-dev" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

BUILD_ROOT="$REPO_ROOT/tmp/deb/cognitive-suite_${VERSION}"
PKG_ROOT="$BUILD_ROOT/pkgroot"
INSTALL_ROOT="$PKG_ROOT/usr/local/lib/cognitive-suite"
BIN_ROOT="$PKG_ROOT/usr/local/bin"
DEBIAN_DIR="$PKG_ROOT/DEBIAN"
DIST_DIR="$REPO_ROOT/dist"
OUTPUT_DEB="$DIST_DIR/cognitive-suite_${VERSION}_all.deb"

rm -rf "$BUILD_ROOT"
mkdir -p "$INSTALL_ROOT" "$BIN_ROOT" "$DEBIAN_DIR" "$DIST_DIR"

rsync -a --delete \
  --exclude '.git' \
  --exclude '.github' \
  --exclude '.vscode' \
  --exclude 'venv' \
  --exclude '.venv' \
  --exclude '.venv-android' \
  --exclude 'tmp' \
  --exclude 'dist' \
  --exclude 'outputs' \
  --exclude 'data/input' \
  "$REPO_ROOT/" "$INSTALL_ROOT/"

cat > "$BIN_ROOT/cogctl" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
exec python3 /usr/local/lib/cognitive-suite/cogctl.py "$@"
EOF
chmod +x "$BIN_ROOT/cogctl"

cat > "$DEBIAN_DIR/control" <<EOF
Package: cognitive-suite
Version: ${VERSION}
Section: utils
Priority: optional
Architecture: all
Maintainer: Atlantyqa Labs <opensource@atlantyqa.com>
Depends: python3, python3-venv
Description: Atlantyqa Cognitive Suite
 Local-first cognitive pipeline with ingestion, analysis and visualization tools.
EOF

chmod 0755 "$DEBIAN_DIR"

dpkg-deb --build "$PKG_ROOT" "$OUTPUT_DEB"
echo "Built package: $OUTPUT_DEB"
