#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

PREFIX="${PREFIX:-$HOME/.local/bin}"
RUNNER_PATH="$PREFIX/gitlab-runner"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/gitlab-stack"

if [[ -x "$RUNNER_PATH" ]]; then
  info "Removing $RUNNER_PATH"
  rm -f "$RUNNER_PATH"
else
  warn "No runner binary found at $RUNNER_PATH (maybe installed elsewhere)."
fi

info "Removing state dir: $STATE_DIR"
rm -rf "$STATE_DIR"

info "Note: Registration config (~/.gitlab-runner/config.toml) is not removed automatically."
info "If you want to remove it: rm -rf ~/.gitlab-runner"
