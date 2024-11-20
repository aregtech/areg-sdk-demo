# This toolchain builds 32-bit binaries with Clang compiler for Linux on x86 processor
# Run example:
# cmake -B ./product/cache/clang-linux-x86 -DCMAKE_TOOLCHAIN_FILE=/path/to/areg-sdk-demo/toolchains/clang-linux-x86.cmake
# cmake --build ./product/cache/clang-linux-x86 -j20

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86)
set(CMAKE_C_COMPILER clang)
set(CMAKE_CXX_COMPILER clang++)
set(CMAKE_FIND_ROOT_PATH /usr/bin)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
