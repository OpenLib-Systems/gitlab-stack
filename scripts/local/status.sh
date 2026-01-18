#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/gitlab-stack"
PID_FILE="$STATE_DIR/gitlab-runner.pid"

if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" >/dev/null 2>&1; then
  info "Runner is RUNNING (pid $(cat "$PID_FILE"))."
  exit 0
fi

info "Runner is NOT running."
exit 1
