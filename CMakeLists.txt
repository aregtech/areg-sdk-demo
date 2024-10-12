# ##################################################################
# This file can be used as an example to integrate areg-sdk into
# the existing project. Use your paths of your project structure
#
# ##################################################################

cmake_minimum_required(VERSION 3.20.0)

set(AREG_SDK_DEMO_ROOT  "${CMAKE_SOURCE_DIR}")
set(AREG_DEMO_SOURCES   "${AREG_SDK_DEMO_ROOT}/demo")

set(PROJECT_NAME "areg-sdk-demo")
set(PROJECT_VERSION "1.0.0")
project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)

find_package(areg CONFIG)

if (NOT areg_FOUND)

    # ##################################################################
    # Prepare AREG SDK configuration before fetching from GitHub
    # ##################################################################

    # Specify where should AREG SDK output built binary directory
    set(AREG_BUILD_ROOT         "${AREG_SDK_DEMO_ROOT}/product")

    # Specify where should fetch the thirdparty source codes, including AREG SDK sources
    set(AREG_PACKAGES           "${AREG_BUILD_ROOT}/packages")

    # Specify AREG Framework library type
    set(AREG_BINARY "shared")

    # Disable building AREG SDK Examples
    option(AREG_BUILD_EXAMPLES  "Disable building areg-sdk examples"   OFF)

    # Disable building AreG SDK unit tests.
    option(AREG_BUILD_TESTS "Disable building areg-sdk unit tests" OFF)

    include(FetchContent)
    set(FETCHCONTENT_BASE_DIR   "${AREG_PACKAGES}")
    message(STATUS "Demo: >>> Fetching areg-sdk from https://github.com/aregtech/areg-sdk.git repo to ${FETCHCONTENT_BASE_DIR} directory")
    FetchContent_Declare(areg-sdk
                         GIT_REPOSITORY https://github.com/aregtech/areg-sdk.git
                         GIT_TAG        "master")

    FetchContent_MakeAvailable(areg-sdk)

    set(AREG_SDK_ROOT           "${areg-sdk_SOURCE_DIR}")
    set(AREG_CMAKE_CONFIG_DIR   "${AREG_SDK_ROOT}/conf/cmake")

else(NOT areg_FOUND)

    message(STATUS "Demo: >>> Found areg package in \'${areg_DIR}\',\
                    configuration file \'${areg_CONFIG}\',\
                    library \'${areg_LIBRARY}\',\
                    package root is \'${areg_ROOT}\'.")
    message(STATUS "Demo: >>> The SDK root \'${AREG_SDK_ROOT}\',\
                    configuration files are \'${AREG_CMAKE_CONFIG_DIR}\' directory,\
                    tools are in \'${AREG_SDK_TOOLS}\' directory.")

endif(NOT areg_FOUND)

# ##################################################################
# We are ready to develop AREG SDK base applications.
# We can as well use AREG SDK settings to create new projects
# In order to compile projects based on AREG SDK settings,
# we should perform these 5 steps, where steps 1-4 are preparations:
#   1. Set 'AREG_SDK_ROOT' variable --> see above. It is either '${areg-sdk_SOURCE_DIR}' or '${areg-sdk_DIR}'
#   2. Include '${AREG_SDK_ROOT}conf/cmake/setup.cmake'
#   3. Include '${AREG_SDK_ROOT}conf/cmake/common.cmake'
#   4. Set '${AREG_BASE}' path in the includes
#   5. Include your projects to compile project
# ##################################################################

# Step 1: Set 'AREG_SDK_ROOT' variable --> see above. `AREG_SDK_ROOT` is either '${areg-sdk_SOURCE_DIR}' or '${areg-sdk_DIR}'

# Step 2: include '${AREG_SDK_ROOT}/conf/cmake/setup.cmake'
include(${AREG_CMAKE_CONFIG_DIR}/setup.cmake)

# Step 3: include '${AREG_SDK_ROOT}/conf/cmake/common.cmake'
include(${AREG_CMAKE_CONFIG_DIR}/common.cmake)

# Step 4: Set '${AREG_BASE}' path in the includes 
include_directories(${AREG_BASE})

# Step 5: Include your projects
# Start building Demo applications
include("${AREG_DEMO_SOURCES}/CMakeLists.txt")

message(STATUS ">>> Demo: After AREG_SDK_ROOT = ${AREG_SDK_ROOT}, AREG_BASE = ${AREG_BASE}")

# Print the configuration status
message(STATUS "=======================================================================================")
message(STATUS "------------------> AREG SDK Demo project CMake Status Report Begin <------------------")
message(STATUS "=======================================================================================")
message(STATUS "Demo: >>> CMAKE_SOURCE_DIR = \'${CMAKE_SOURCE_DIR}\', build type \'${CMAKE_BUILD_TYPE}\'")
message(STATUS "Demo: >>> Build ...........: \'${CMAKE_SYSTEM_NAME}\' system, \'${AREG_BITNESS}\'-bit platform, \'${AREG_PROCESSOR}\' CPU")
message(STATUS "Demo: >>> Compiler ........: \'${CMAKE_CXX_COMPILER}\'")
message(STATUS "Demo: >>> Compiler Version : C++ standard \'c++${CMAKE_CXX_STANDARD}\', compiler family \'${AREG_COMPILER_FAMILY}\'")
message(STATUS "Demo: >>> Binary output ...: \'${CMAKE_RUNTIME_OUTPUT_DIRECTORY}\', extension '${CMAKE_EXECUTABLE_SUFFIX}'")
message(STATUS "Demo: >>> Generated files .: \'${AREG_GENERATE_DIR}\' directory")
message(STATUS "Demo: >>> Packages ........: \'${FETCHCONTENT_BASE_DIR}\' directory")
message(STATUS "Demo: >>> Build libraries .: areg is \'${AREG_BINARY}\', aregextend is static, areglogger is \'${AREG_LOGGER_LIB}\' library")
message(STATUS "Demo: >>> Java version ....: \'${Java_VERSION_STRING}\' of version \'${Java_JAVA_EXECUTABLE}\'. Minimum should be 17")
message(STATUS "Demo: >>> Use of packages .: SQLite3 package use is \'${AREG_SQLITE_PACKAGE}\', GTest package use is \'${AREG_GTEST_PACKAGE}\' ")
message(STATUS "Demo: >>> Other options ...: Examples = \'${AREG_BUILD_EXAMPLES}\', Unit Tests = \'${AREG_BUILD_TESTS}\', Demo Extended = \'${AREG_EXTENDED}\', Logs = \'${AREG_LOGS}\'")
message(STATUS "Demo: >>> Installation ....: is '${AREG_INSTALL}', location \'${CMAKE_INSTALL_PREFIX}\'")
message(STATUS "=======================================================================================")
message(STATUS "------------------>  AREG SDK Demo project CMake Status Report End <-------------------")
message(STATUS "=======================================================================================")
