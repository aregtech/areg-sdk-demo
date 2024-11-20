# This toolchain builds 32-bit binaries with GNU compiler for Linux on 32-bit ARM processor
# Run example:
# cmake -B ./product/cache/gnu-linux-arm32 -DCMAKE_TOOLCHAIN_FILE=/path/to/areg-sdk-demo/toolchains/gnu-linux-arm32.cmake
# cmake --build ./product/cache/gnu-linux-arm32 -j20

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR ARM)
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
set(CMAKE_FIND_ROOT_PATH /usr/bin)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
