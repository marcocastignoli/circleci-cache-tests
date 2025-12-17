cmake_minimum_required(VERSION 3.16)
project(ccache_minimal CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(USE_CCACHE "Use ccache (if available) to speed up rebuilds" ON)
if(USE_CCACHE)
  find_program(CCACHE_PROGRAM ccache)
  if(CCACHE_PROGRAM)
    message(STATUS "Using ccache: ${CCACHE_PROGRAM}")
    # Setting these is the recommended CMake integration for ccache.
    set(CMAKE_C_COMPILER_LAUNCHER "${CCACHE_PROGRAM}" CACHE STRING "" FORCE)
    set(CMAKE_CXX_COMPILER_LAUNCHER "${CCACHE_PROGRAM}" CACHE STRING "" FORCE)
  else()
    message(STATUS "ccache not found; continuing without it (USE_CCACHE=ON).")
  endif()
endif()

add_executable(app
  src/main.cpp
  src/hello.cpp
)

target_include_directories(app PRIVATE include)
