# This toolchain builds 64-bit binaries with GNU compiler for Linux on 64-bit ARM (AARCH64) processor.
# Run example:
# cmake -B ./product/cache/gnu-linux-arm64 -DCMAKE_TOOLCHAIN_FILE=/path/to/areg-sdk-demo/toolchains/gnu-linux-arm64.cmake
# cmake --build ./product/cache/gnu-linux-arm64 -j20

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR AARCH64)
set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)
set(CMAKE_FIND_ROOT_PATH /usr/bin)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
