# This toolchain builds 64-bit binaries with GNU compiler for Linux on x64 processor
# Run example:
# cmake -B ./product/cache/gnu-linux-x64 -DCMAKE_TOOLCHAIN_FILE=/path/to/areg-sdk-demo/toolchains/gnu-linux-x64.cmake
# cmake --build ./product/cache/gnu-linux-x64 -j20

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)
set(CMAKE_FIND_ROOT_PATH /usr/bin)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)