# ##################################################################
# This file can be used as an example to integrate areg-sdk into
# the existing project. Use your paths of your project structure
#
# ##################################################################

cmake_minimum_required(VERSION 3.16.0)

set(AREG_SDK_DEMO_ROOT  "${CMAKE_SOURCE_DIR}")
set(AREG_DEMO_SOURCES   "${AREG_SDK_DEMO_ROOT}/demo")
set(AREG_SDK_SOURCES    "${AREG_SDK_DEMO_ROOT}/thirdparty/areg-sdk")

# Configure AREG SDK build
# Set the root path to output compiled binaries.
set(AREG_BUILD_ROOT     "${AREG_SDK_DEMO_ROOT}/product")
# Disable building examples, instead, demo applications should be compiled.
option(AREG_BUILD_EXAMPLES  "Build AREG SDK examples"   OFF)

# Include areg-sdk files. This will initialize the options and compilers.
# You may include it after your project(s), but make sure that areg-sdk
# is properly configured.
include(${AREG_SDK_SOURCES}/CMakeLists.txt)

set(PROJECT_NAME "areg-sdk-demo")
set(PROJECT_VERSION "1.0.0")
project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)

# Start building Demo applications
include("${AREG_DEMO_SOURCES}/CMakeLists.txt")
