# ##################################################################
# This file can be used as an example to integrate areg-sdk into
# the existing project. Use your paths of your project structure.
#
# Description:  In this example, AREG SDK is integrated as a package or
#               as sources fetched from https://github.com/aregtech/areg-sdk.git.
#               In addition, AREG SDK can be integrated as before
#               declaring 'project()' or after. To see the difference,
#               pass 'INTEGRATE_AREG_BEFORE_PROJECT' option when calling 'cmake'.
#               If 'INTEGRATE_AREG_BEFORE_PROJECT' is 'TRUE' (or 'ON'), AREG SDK is integrated
#               before the 'project()' is called and the develop may benefit 
#               all advantages of 'areg-sdk' project sources or binaries.
#               If 'INTEGRATE_AREG_BEFORE_PROJECT' is 'FALSE' (or 'OFF'), the developer may
#               manually set own options before integrating 'areg-sdk' in the project.
# ##################################################################

cmake_minimum_required(VERSION 3.20.0)

macro(macro_load_areg_sdk)
    find_package(areg CONFIG)
    if (NOT areg_FOUND)
        # ##################################################################
        # Prepare AREG SDK configuration before fetching from GitHub
        # ##################################################################

        # Specify where should AREG SDK output built binary directory
        set(AREG_BUILD_ROOT         "${AREG_SDK_DEMO_ROOT}/product")

        # Specify where should fetch the thirdparty source codes, including AREG SDK sources
        set(AREG_PACKAGES           "${AREG_BUILD_ROOT}/packages")

        # Disable building AREG SDK Examples
        option(AREG_BUILD_EXAMPLES  "Disable areg-sdk examples for Demo"   OFF)

        # Disable building AreG SDK unit tests.
        option(AREG_BUILD_TESTS "Disable areg-sdk unit tests for Demo" OFF)

        include(FetchContent)
        set(FETCHCONTENT_BASE_DIR   "${AREG_PACKAGES}")
        message(STATUS "Demo: >>> Fetching areg-sdk from https://github.com/aregtech/areg-sdk.git repo to ${FETCHCONTENT_BASE_DIR} directory")
        FetchContent_Declare(areg-sdk
                             GIT_REPOSITORY https://github.com/aregtech/areg-sdk.git
                             GIT_TAG        "bugfix/396-demo-build-fails")

        message(STATUS "Demo: >>> Fetched 'areg-sdk', configuring to make it available...")
        FetchContent_MakeAvailable(areg-sdk)

        # Specify the location of 'areg-sdk' root directory.
        set(AREG_SDK_ROOT           "${areg-sdk_SOURCE_DIR}")
        # Optionally, specify the location of cmake configuration files.
        set(AREG_CMAKE_CONFIG_DIR   "${AREG_SDK_ROOT}/conf/cmake")
        message(STATUS "Demo: >>> AREG_SDK_ROOT = \'${AREG_SDK_ROOT}\', going to configure...")
    else()
        message(STATUS "Demo: >>> Found areg package in \'${areg_DIR}\',\
                        configuration file \'${areg_CONFIG}\',\
                        library \'${areg_LIBRARY}\',\
                        package root is \'${areg_ROOT}\'.")
        message(STATUS "Demo: >>> The SDK root \'${AREG_SDK_ROOT}\',\
                        configuration files are \'${AREG_CMAKE_CONFIG_DIR}\' directory,\
                        tools are in \'${AREG_SDK_TOOLS}\' directory.")
    endif()
endmacro(macro_load_areg_sdk)

# Set Demo project root and sources
set(AREG_SDK_DEMO_ROOT  "${CMAKE_SOURCE_DIR}")
set(AREG_DEMO_SOURCES   "${AREG_SDK_DEMO_ROOT}/demo")
# By default, INTEGRATE_AREG_BEFORE_PROJECT is integrated in the project before 'project()'
if (NOT DEFINED INTEGRATE_AREG_BEFORE_PROJECT)
    set(INTEGRATE_AREG_BEFORE_PROJECT TRUE)
endif()


if (INTEGRATE_AREG_BEFORE_PROJECT)
    # if 'INTEGRATE_AREG_BEFORE_PROJECT' is 'TRUE', integrate either 'areg' package or fetch the sources from official repository
    macro_load_areg_sdk()
    # Declare 'areg-sdk-demo' project after integrating 'areg-sdk'
    set(PROJECT_NAME "areg-sdk-demo")
    set(PROJECT_VERSION "2.0.0")
    project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)
else()
    # integrate 'areg-sdk' after 'project()' call

    # Reset compiler settings, because they are not use and they may cause warnings
    set(AREG_COMPILER           "")
    set(AREG_COMPILER_FAMILY    "")
    # Declare AREG SDK Demo project
    set(PROJECT_NAME "areg-sdk-demo")
    set(PROJECT_VERSION "1.0.0")
    project(${PROJECT_NAME} VERSION ${PROJECT_VERSION} LANGUAGES C CXX)
    # integrate areg package or sources
    macro_load_areg_sdk()
endif()


# ##################################################################
# We are ready to develop AREG SDK base applications.
# We can as well use AREG SDK settings to create new projects
# In order to compile projects based on AREG SDK settings,
# we should perform these 5 steps, where steps 1-4 are preparations:
#   1. Set 'AREG_SDK_ROOT' variable --> see above. It is either '${areg-sdk_SOURCE_DIR}' or '${areg-sdk_DIR}'
#   2. Include '${AREG_SDK_ROOT}conf/cmake/setup.cmake'
#   3. Include '${AREG_SDK_ROOT}conf/cmake/common.cmake'
#   4. Set '${AREG_FRAMEWORK}' path in the includes
#   5. Include your projects to compile project
# ##################################################################

# Step 1: Set 'AREG_SDK_ROOT' variable --> see above. `AREG_SDK_ROOT` is either '${areg-sdk_SOURCE_DIR}' or '${areg-sdk_DIR}'

# Step 2: include '${AREG_SDK_ROOT}/conf/cmake/setup.cmake'
include(${AREG_CMAKE_CONFIG_DIR}/setup.cmake)

# Step 3: include '${AREG_SDK_ROOT}/conf/cmake/common.cmake'
include(${AREG_CMAKE_CONFIG_DIR}/common.cmake)

# Step 4: Set '${AREG_FRAMEWORK}' path in the includes 
include_directories(${AREG_FRAMEWORK})

# Step 5: Include your projects
# Start building Demo applications
include("${AREG_DEMO_SOURCES}/CMakeLists.txt")

printAregConfigStatus(
    areg_FOUND
    "Demo"
    "------------------> AREG SDK Demo project CMake Status Report Begin <------------------"
    "------------------>  AREG SDK Demo project CMake Status Report End <-------------------"
)
