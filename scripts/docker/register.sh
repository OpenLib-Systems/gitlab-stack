#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

require_cmd docker
if docker compose version >/dev/null 2>&1; then
  DC=(docker compose)
else
  require_cmd docker-compose
  DC=(docker-compose)
fi

URL="${URL:-}"
TOKEN="${TOKEN:-}"
NAME="${NAME:-docker-runner}"
TAGS="${TAGS:-}"
EXECUTOR="${EXECUTOR:-docker}"
DOCKER_IMAGE="${DOCKER_IMAGE:-alpine:latest}"

[[ -n "$URL" && -n "$TOKEN" ]] || die "Need --url and --token (or run interactive register inside container)."

TOKEN_FLAG="--token"
if [[ "$TOKEN" != glrt-* ]]; then
  TOKEN_FLAG="--registration-token"
fi

ARGS=(register --non-interactive --url "$URL" "$TOKEN_FLAG" "$TOKEN" --name "$NAME" --executor "$EXECUTOR" --docker-image "$DOCKER_IMAGE")
if [[ -n "$TAGS" ]]; then
  ARGS+=(--tag-list "$TAGS")
fi

info "Registering runner inside container..."
"${DC[@]}" -f "$ROOT_DIR/scripts/docker/compose.runner.yaml" up -d
"${DC[@]}" -f "$ROOT_DIR/scripts/docker/compose.runner.yaml" exec -T gitlab-runner gitlab-runner "${ARGS[@]}"
info "Done."
