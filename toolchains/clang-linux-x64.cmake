# This toolchain builds 64-bit binaries with Clang compiler for Linux on x64 processor
# Run example:
# cmake -B ./product/cache/clang-linux-x64 -DCMAKE_TOOLCHAIN_FILE=/path/to/areg-sdk-demo/toolchains/clang-linux-x64.cmake
# cmake --build ./product/cache/clang-linux-x64 -j20

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x64)
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_FIND_ROOT_PATH /usr/bin)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
