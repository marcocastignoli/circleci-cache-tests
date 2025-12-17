#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

CXX="${CXX:-c++}"
CXXFLAGS=(
  -std=c++17
  -O2
  -g
  -Wall
  -Wextra
  -Wpedantic
  -Iinclude
)

BUILD_DIR="${BUILD_DIR:-build}"
mkdir -p "$BUILD_DIR"

CCACHE_BIN=""
if command -v ccache >/dev/null 2>&1; then
  CCACHE_BIN="ccache"
fi

run_cxx() {
  if [[ -n "$CCACHE_BIN" ]]; then
    "$CCACHE_BIN" "$CXX" "$@"
  else
    "$CXX" "$@"
  fi
}

run_cxx "${CXXFLAGS[@]}" -c src/hello.cpp -o "$BUILD_DIR/hello.o"
run_cxx "${CXXFLAGS[@]}" -c src/main.cpp -o "$BUILD_DIR/main.o"
run_cxx "$BUILD_DIR/hello.o" "$BUILD_DIR/main.o" -o "$BUILD_DIR/app"

echo "Built: $BUILD_DIR/app"
