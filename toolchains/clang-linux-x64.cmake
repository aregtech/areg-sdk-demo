# This toolchain builds 64-bit binaries with Clang compiler for Linux on x86-64 processor
# Run example:
# cmake -B ./product/cache/clang-linux-x64 -DCMAKE_TOOLCHAIN_FILE=/path/to/areg-sdk-demo/toolchains/clang-linux-x64.cmake
# cmake --build ./product/cache/clang-linux-x64 -j20

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

set(CMAKE_C_COMPILER clang)
set(CMAKE_C_COMPILER_TARGET x86_64-linux-gnu)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_CXX_COMPILER_TARGET x86_64-linux-gnu)

set(CMAKE_FIND_ROOT_PATH "/usr")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_LIBRARY_ARCHITECTURE x86_64-linux-gnu)
