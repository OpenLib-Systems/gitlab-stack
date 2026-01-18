#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

OS="$(detect_os)"
ARCH="$(detect_arch)"

# Default user-space prefix
PREFIX="${PREFIX:-$HOME/.local/bin}"
ensure_dir "$PREFIX"

RUNNER_PATH="$PREFIX/gitlab-runner"

BASE_URL="https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries"
BINARY_NAME="gitlab-runner-${OS}-${ARCH}"
URL="${BASE_URL}/${BINARY_NAME}"

TMP="$(mktemp)"
info "Downloading GitLab Runner: $URL"
download_file "$URL" "$TMP"

chmod +x "$TMP"
mv "$TMP" "$RUNNER_PATH"

info "Installed: $RUNNER_PATH"
info "Tip: ensure '$PREFIX' is in your PATH."
"$RUNNER_PATH" --version || true
