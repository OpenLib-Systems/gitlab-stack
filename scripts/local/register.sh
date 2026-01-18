#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

PREFIX="${PREFIX:-$HOME/.local/bin}"
RUNNER_BIN="${PREFIX}/gitlab-runner"
[[ -x "$RUNNER_BIN" ]] || RUNNER_BIN="$(command -v gitlab-runner || true)"
[[ -n "${RUNNER_BIN:-}" && -x "$RUNNER_BIN" ]] || die "gitlab-runner not found. Run: ./setup.sh install --mode local"

URL="${URL:-}"
TOKEN="${TOKEN:-}"
NAME="${NAME:-my-runner}"
TAGS="${TAGS:-}"
EXECUTOR="${EXECUTOR:-shell}"
DOCKER_IMAGE="${DOCKER_IMAGE:-alpine:latest}"

if [[ -z "$URL" || -z "$TOKEN" ]]; then
  info "Interactive registration (missing --url or --token)."
  exec "$RUNNER_BIN" register
fi

# New workflow: auth tokens often start with glrt-
TOKEN_FLAG="--token"
if [[ "$TOKEN" != glrt-* ]]; then
  TOKEN_FLAG="--registration-token"
fi

ARGS=(register --non-interactive --url "$URL" "$TOKEN_FLAG" "$TOKEN" --name "$NAME" --executor "$EXECUTOR")
if [[ -n "$TAGS" ]]; then
  ARGS+=(--tag-list "$TAGS")
fi
if [[ "$EXECUTOR" == "docker" ]]; then
  ARGS+=(--docker-image "$DOCKER_IMAGE")
fi

info "Registering runner '$NAME'..."
"$RUNNER_BIN" "${ARGS[@]}"
info "Done. Config is usually at: ~/.gitlab-runner/config.toml"
