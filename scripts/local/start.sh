#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

PREFIX="${PREFIX:-$HOME/.local/bin}"
RUNNER_BIN="${PREFIX}/gitlab-runner"
[[ -x "$RUNNER_BIN" ]] || RUNNER_BIN="$(command -v gitlab-runner || true)"
[[ -n "${RUNNER_BIN:-}" && -x "$RUNNER_BIN" ]] || die "gitlab-runner not found. Run: ./setup.sh install --mode local"

CONFIG_FILE="${HOME}/.gitlab-runner/config.toml"
[[ -f "$CONFIG_FILE" ]] || die "No config found at $CONFIG_FILE. Run: ./setup.sh register --mode local ..."

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/gitlab-stack"
ensure_dir "$STATE_DIR"
PID_FILE="$STATE_DIR/gitlab-runner.pid"
LOG_FILE="$STATE_DIR/runner.log"
WORK_DIR="$STATE_DIR/work"
ensure_dir "$WORK_DIR"

if [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE")" >/dev/null 2>&1; then
  info "Runner already running (pid $(cat "$PID_FILE"))."
  exit 0
fi

if [[ "${BACKGROUND:-0}" -eq 1 ]]; then
  info "Starting runner in background..."
  nohup "$RUNNER_BIN" run --working-directory "$WORK_DIR" --config "$CONFIG_FILE" >"$LOG_FILE" 2>&1 &
  echo $! > "$PID_FILE"
  info "Started. pid=$(cat "$PID_FILE")"
  info "Logs: $LOG_FILE"
else
  info "Starting runner in foreground (Ctrl+C to stop)..."
  exec "$RUNNER_BIN" run --working-directory "$WORK_DIR" --config "$CONFIG_FILE"
fi
