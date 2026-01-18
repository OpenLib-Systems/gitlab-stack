#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/gitlab-stack"
PID_FILE="$STATE_DIR/gitlab-runner.pid"

if [[ ! -f "$PID_FILE" ]]; then
  info "No PID file found. Runner not running?"
  exit 0
fi

PID="$(cat "$PID_FILE")"
if kill -0 "$PID" >/dev/null 2>&1; then
  info "Stopping runner pid=$PID ..."
  kill "$PID"
else
  warn "PID $PID not running."
fi

rm -f "$PID_FILE"
info "Stopped."
