# Minimal C++ + ccache example

This repo is a tiny C++ project meant to demonstrate `ccache` usage (locally and in CI).

## Prerequisites

- A C++ compiler (`clang++` or `g++`)
- `ccache` (optional, but recommended)
 - `cmake` (>= 3.16) (optional, for the CMake build)

## Local build (with ccache, no CMake required)

```sh
ccache --version
ccache -z

./scripts/build.sh

ccache -s
./build/app
```

Run the build a second time (or touch a header) to see cache hits/misses change:

```sh
./scripts/build.sh
ccache -s
```

## Optional: CMake build

If you prefer CMake, `CMakeLists.txt` auto-enables `ccache` when it is found in `PATH`:

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build -j
```

## Notes

- `CMakeLists.txt` auto-enables `ccache` if it is found in `PATH` by setting
  `CMAKE_CXX_COMPILER_LAUNCHER`.

# test
