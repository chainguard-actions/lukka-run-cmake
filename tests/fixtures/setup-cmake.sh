#!/usr/bin/env bash
# Ensure a recent CMake (presets v6 support) plus a C toolchain are available.
set -euo pipefail

SUDO=""
if [ "$(id -u)" != "0" ] && command -v sudo >/dev/null 2>&1; then
  SUDO="sudo"
fi

if ! command -v cc >/dev/null 2>&1 || ! command -v make >/dev/null 2>&1; then
  $SUDO apt-get update
  DEBIAN_FRONTEND=noninteractive $SUDO apt-get install -y build-essential
fi

ARCH="$(uname -m)"
case "$ARCH" in
  x86_64|amd64) CM_ARCH="x86_64" ;;
  aarch64|arm64) CM_ARCH="aarch64" ;;
  *) echo "unsupported arch $ARCH"; exit 1 ;;
esac

VER="3.28.3"
DEST="${RUNNER_TEMP:-/tmp}/cmake-${VER}"
if [ ! -x "$DEST/bin/cmake" ]; then
  mkdir -p "$DEST"
  curl -fsSL "https://github.com/Kitware/CMake/releases/download/v${VER}/cmake-${VER}-linux-${CM_ARCH}.tar.gz" -o /tmp/cmake.tgz
  tar -xzf /tmp/cmake.tgz -C "$DEST" --strip-components=1
fi
echo "$DEST/bin" >> "$GITHUB_PATH"
"$DEST/bin/cmake" --version
