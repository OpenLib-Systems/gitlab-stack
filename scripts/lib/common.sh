#!/usr/bin/env bash
set -euo pipefail

info() { echo "INFO  $*"; }
warn() { echo "WARN  $*" >&2; }
die()  { echo "ERROR $*" >&2; exit 1; }

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing command: $1"
}

detect_os() {
  local u
  u="$(uname -s | tr '[:upper:]' '[:lower:]')"
  case "$u" in
    linux*) echo "linux";;
    darwin*) echo "darwin";;
    *) die "Unsupported OS: $u";;
  esac
}

detect_arch() {
  local m
  m="$(uname -m)"
  case "$m" in
    x86_64|amd64) echo "amd64";;
    arm64|aarch64) echo "arm64";;
    *) die "Unsupported arch: $m";;
  esac
}

download_file() {
  local url="$1" out="$2"
  if command -v curl >/dev/null 2>&1; then
    curl -fsSL "$url" -o "$out"
  elif command -v wget >/dev/null 2>&1; then
    wget -qO "$out" "$url"
  else
    die "Need curl or wget to download files."
  fi
}

ensure_dir() {
  mkdir -p "$1"
}
