# ##################################################################
# This file can be used as an example to integrate areg-sdk into
# the existing project. Use your paths of your project strucure
#
# ##################################################################

cmake_minimum_required(VERSION 3.16.0)

set(AREG_SDK_DEMO_ROOT  "${CMAKE_SOURCE_DIR}")
set(AREG_SDK_SOURCES    "${AREG_SDK_DEMO_ROOT}/thirdparty/areg-sdk")

# Set the root path to output compiled binaries.
set(AREG_BUILD_ROOT     "${AREG_SDK_DEMO_ROOT}/product")

# include areg-sdk file. This will initialize the options and compilers.
# You may include after you project(s), but make sure that areg-sdk
# is properly configured.
include(${AREG_SDK_SOURCES}/CMakeLists.txt)

set(PROJECT_NAME "areg-sdk-demo")
set(PROJECT_VERSION "1.0.0")
project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)

# at the moment, it is an empty project that compiles only areg-sdk
