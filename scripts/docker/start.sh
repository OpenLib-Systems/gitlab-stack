#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="${ROOT_DIR:?}"
source "$ROOT_DIR/scripts/lib/common.sh"

STACK="${1:-runner}" # runner | local-gitlab

require_cmd docker

if docker compose version >/dev/null 2>&1; then
  DC=(docker compose)
else
  require_cmd docker-compose
  DC=(docker-compose)
fi

ensure_dir "$ROOT_DIR/.runner/config"
ensure_dir "$ROOT_DIR/.runner/cache"

if [[ "$STACK" == "local-gitlab" ]]; then
  info "Starting local GitLab + runner..."
  "${DC[@]}" -f "$ROOT_DIR/scripts/docker/compose.local-gitlab.yaml" up -d
else
  info "Starting runner..."
  "${DC[@]}" -f "$ROOT_DIR/scripts/docker/compose.runner.yaml" up -d
fi

info "Done."
