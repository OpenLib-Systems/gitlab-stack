#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$ROOT_DIR/scripts/lib/common.sh"

ACTION="${1:-help}"
shift || true

MODE="local"          # local | docker | local-gitlab
URL=""
TOKEN=""
NAME=""
TAGS=""
EXECUTOR="shell"      # shell | docker | ...
DOCKER_IMAGE="alpine:latest"
PREFIX=""
BACKGROUND=0

usage() {
  cat <<'EOF'
Usage:
  ./setup.sh <action> [options]

Actions:
  install | register | start | stop | status | uninstall | help

Options:
  --mode local|docker|local-gitlab
  --url <gitlab_url>
  --token <glrt-... or legacy token>
  --name <runner_name>
  --tags <comma,separated,tags>
  --executor shell|docker
  --docker-image <image:tag>   (docker executor)
  --prefix <path>              (local install prefix; default: ~/.local/bin)
  --background                 (start local runner in background)

Examples:
  ./setup.sh install --mode local
  ./setup.sh register --mode local --url "https://gitlab.com" --token "glrt-..." --name "my-runner" --tags "linux" --executor shell
  ./setup.sh start --mode local --background
  ./setup.sh install --mode docker
  ./setup.sh register --mode docker --url "https://gitlab.com" --token "glrt-..." --name "docker-runner" --tags "docker" --executor docker --docker-image "alpine:latest"
  ./setup.sh start --mode docker
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --mode) MODE="${2:-}"; shift 2;;
    --url) URL="${2:-}"; shift 2;;
    --token) TOKEN="${2:-}"; shift 2;;
    --name) NAME="${2:-}"; shift 2;;
    --tags) TAGS="${2:-}"; shift 2;;
    --executor) EXECUTOR="${2:-}"; shift 2;;
    --docker-image) DOCKER_IMAGE="${2:-}"; shift 2;;
    --prefix) PREFIX="${2:-}"; shift 2;;
    --background) BACKGROUND=1; shift 1;;
    -h|--help|help) ACTION="help"; shift 1;;
    *) die "Unknown argument: $1";;
  esac
done

export ROOT_DIR MODE URL TOKEN NAME TAGS EXECUTOR DOCKER_IMAGE PREFIX BACKGROUND

case "$ACTION" in
  help|-h|--help)
    usage
    ;;
  install|register|start|stop|status|uninstall)
    case "$MODE" in
      local)
        bash "$ROOT_DIR/scripts/local/${ACTION}.sh"
        ;;
      docker)
        bash "$ROOT_DIR/scripts/docker/${ACTION}.sh"
        ;;
      local-gitlab)
        if [[ "$ACTION" == "install" ]]; then
          info "No install needed for local-gitlab. Use: start/stop/status (Docker required)."
        else
          bash "$ROOT_DIR/scripts/docker/${ACTION}.sh" "local-gitlab"
        fi
        ;;
      *)
        die "Invalid --mode: $MODE"
        ;;
    esac
    ;;
  *)
    usage
    exit 1
    ;;
esac
