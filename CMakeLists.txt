# ##################################################################
# Example CMake script to integrate AREG SDK into an existing project.
#
# This script demonstrates how to integrate AREG SDK as a package or 
# fetch its sources from https://github.com/aregtech/areg-sdk.git.
#
# Integration can occur before or after the `project()` declaration:
#   - Set `INTEGRATE_AREG_BEFORE_PROJECT` to TRUE (or ON) to integrate 
#     AREG SDK before calling `project()`, enabling immediate use of 
#     AREG SDK configurations.
#   - Set `INTEGRATE_AREG_BEFORE_PROJECT` to FALSE (or OFF) to manually 
#     set project options before integrating AREG SDK.
# ##################################################################

cmake_minimum_required(VERSION 3.20.0)

set(PROJECT_DEMO_NAME    "areg-sdk-demo")
set(PROJECT_DEMO_VERSION "2.0.0")

# Macro to load and configure the AREG SDK package or source repository
macro(macro_load_areg_sdk)
    find_package(areg CONFIG)
    
    if (NOT areg_FOUND)
        # ##################################################################
        # AREG SDK not found as a package, fetching from GitHub.
        # ##################################################################

        # Specify the root directory for AREG SDK build outputs.
        if (NOT DEFINED AREG_BUILD_ROOT OR "${AREG_BUILD_ROOT}" STREQUAL "")
            set(AREG_BUILD_ROOT "${AREG_SDK_DEMO_ROOT}/product")
        endif()

        # Specify where to fetch third-party sources (including AREG SDK).
        if (NOT DEFINED AREG_PACKAGES OR "${AREG_PACKAGES}" STREQUAL "")
            set(AREG_PACKAGES "${AREG_BUILD_ROOT}/packages")
        endif()

        # Disable building AREG SDK examples and unit tests for this demo.
        option(AREG_BUILD_EXAMPLES  "Compile areg-sdk example in Demo"      OFF)
        option(AREG_BUILD_TESTS     "Compile areg-sdk unit tests in Demo"   OFF)

        include(FetchContent)
        set(FETCHCONTENT_BASE_DIR "${AREG_PACKAGES}")
        message(STATUS "Demo: >>> Fetching AREG SDK from GitHub to ${FETCHCONTENT_BASE_DIR}")
        
        FetchContent_Declare(
            areg-sdk
            GIT_REPOSITORY https://github.com/aregtech/areg-sdk.git
            GIT_TAG "master"
        )
        message(STATUS "Demo: >>> AREG SDK sources are fetched, setting up areg-sdk ...")
        FetchContent_MakeAvailable(areg-sdk)

        # Set the root directory of the fetched AREG SDK
        set(AREG_SDK_ROOT "${areg-sdk_SOURCE_DIR}")
        set(AREG_CMAKE_CONFIG_DIR "${AREG_SDK_ROOT}/conf/cmake")
        message(STATUS "Demo: >>> AREG_SDK_ROOT set to '${AREG_SDK_ROOT}', configuring AREG SDK...")
    
    else()
        # AREG SDK package found
        message(STATUS "Demo: >>> Found AREG package at '${areg_DIR}',")
        message(STATUS "      >>> Library: '${areg_LIBRARY}', Config: '${areg_CONFIG}', Package Root: '${areg_ROOT}'")
        message(STATUS "      >>> SDK Root: '${AREG_SDK_ROOT}', CMake Config: '${AREG_CMAKE_CONFIG_DIR}', Tools: '${AREG_SDK_TOOLS}'")
    endif()
endmacro(macro_load_areg_sdk)

# Set the root of the demo project and its sources
set(AREG_SDK_DEMO_ROOT "${CMAKE_SOURCE_DIR}")
set(AREG_DEMO_SOURCES "${AREG_SDK_DEMO_ROOT}/demo")

# Control whether to integrate AREG SDK before or after the project declaration
if (NOT DEFINED INTEGRATE_AREG_BEFORE_PROJECT)
    set(INTEGRATE_AREG_BEFORE_PROJECT TRUE)  # Default is TRUE (integrate before `project()`)
endif()

# Integration logic based on INTEGRATE_AREG_BEFORE_PROJECT flag
if (INTEGRATE_AREG_BEFORE_PROJECT)
    # Integrate AREG SDK before calling project()
    macro_load_areg_sdk()
    
    # Define the project after integrating AREG SDK
    project(${PROJECT_DEMO_NAME} VERSION ${PROJECT_DEMO_VERSION} LANGUAGES C CXX)
else()
    # Integrate AREG SDK after calling project()

    # Reset compiler settings to avoid potential warnings
    set(AREG_COMPILER "")
    set(AREG_COMPILER_FAMILY "")

    # Declare the project
    project(${PROJECT_DEMO_NAME} VERSION ${PROJECT_DEMO_VERSION} LANGUAGES C CXX)

    # Now integrate AREG SDK after project is defined
    macro_load_areg_sdk()
endif()

# ##################################################################
# Steps to prepare AREG SDK base applications:
#
#   1. Set the 'AREG_SDK_ROOT' variable (this is either '${areg-sdk_SOURCE_DIR}' 
#      when fetched, or '${areg-sdk_DIR}' when using the package).
#   2. Include '${AREG_SDK_ROOT}/conf/cmake/areg.cmake'.
#   3. Include and build your projects (e.g., Demo).
# ##################################################################

# Step 1: AREG_SDK_ROOT is already set in macro_load_areg_sdk()

# Step 2: Include areg.cmake from AREG SDK
include(${AREG_CMAKE_CONFIG_DIR}/areg.cmake)

# Step 3: Include the demo project and start building
include("${AREG_DEMO_SOURCES}/CMakeLists.txt")

# Print the configuration status
printAregConfigStatus(
    areg_FOUND
    "Demo"
    "------------------> AREG SDK Demo project CMake Status Report Begin <------------------"
    "-------------------> AREG SDK Demo project CMake Status Report End <-------------------"
)
