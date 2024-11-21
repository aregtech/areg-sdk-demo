# This toolchain builds 64-bit binaries with MSVC compiler for Windows on x64 processor
# Run example:
# cmake -B ./product/cache/msvc-win-x64 -DCMAKE_TOOLCHAIN_FILE=C:/path/to/areg-sdk-demo/toolchains/msvc-win-x64.cmake
# cmake --build ./product/cache/msvc-win-x64 -j20 --config=Release

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR AMD64)
set(CMAKE_C_COMPILER cl)
set(CMAKE_CXX_COMPILER cl)
set(CMAKE_FIND_ROOT_PATH /)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_GENERATOR_PLATFORM x64  CACHE INTERNAL "Force 64-bit compilation")
