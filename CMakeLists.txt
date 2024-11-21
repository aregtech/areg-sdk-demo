# ##################################################################
# Demo CMake script to integrate AREG SDK into an existing project.
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
            set(AREG_PACKAGES "${CMAKE_BINARY_DIR}/packages")
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

macro(macro_normalize_architecture arc_processor var_processor var_found)
    set(${var_found} FALSE)
    string(TOLOWER "${arc_processor}" arc_processor)
    foreach(_entry "x64;x64" "x86_64;x64" "x86-64;x64" "amd64;x64" "x86;x86" "i386;x86" "arm64;arm64" "aarch64;arm64" "arm32;arm32" "armv7;arm32" "arm;arm32")
        list(GET _entry 0 _arch)
        list(GET _entry 1 _norm)
        string(FIND "${arc_processor}" ${_arch} _arch_pos)
        if (_arch_pos GREATER -1)
            set(${var_found} TRUE)
            set(${var_processor} _norm)
            break()
        endif()
    endforeach()
    unset(_arch)
    unset(_norm)
    unset(_entry)
endmacro()

macro(macro_test_find_package package_name package_architecture package_found)
    set(${package_found} FALSE)
    macro_normalize_architecture("${package_architecture}" _arch _found)
    if ("${_arch}" STREQUAL "x64")
        set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB64_PATHS ON)
        set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB32_PATHS OFF)
    elseif("${_arch}" STREQUAL "x86")
        set_property(GLOBAL PROPERTY FIND_LIBRARY_USE_LIB32_PATHS ON)
    endif()

    if (${package_name} STREQUAL "SQLite3")
        include(FindSQLite3)
    elseif(${package_name} STREQUAL "GTest")
        include(FindGTest)
    else()
        find_package(${package_name} CONFIG)
    endif()

    message(STATUS "Demo: >>> ${package_name}_FOUND = ${${package_name}_FOUND}")
    if (NOT ${package_name}_FOUND)
        
        find_library(_lib_path NAMES "sqlite3")
        message(STATUS "Demo: <<<<< _lib_path = ${_lib_path}")
        set(_str_arch)
        set(_found_pos -1)

        if ("${_arch}" STREQUAL "arm64")
            execute_process(COMMAND "aarch64-linux-gnu-objdump -f ${_lib_path} | grep ^architecture  | cut -d' ' -f-2 | sort -u" OUTPUT_VARIABLE _arch_data)
            string(FIND "${_arch_data}" "aarch64" _found_pos)
        elseif("${_arch}" STREQUAL "arm32")
            if (EXISTS "arm-linux-gnueabi-objdump")
                execute_process(COMMAND "arm-linux-gnueabi-objdump -f ${_lib_path} | grep ^architecture  | cut -d' ' -f-2 | sort -u" OUTPUT_VARIABLE _arch_data)
                string(FIND "${_arch_data}" "aarch64" _found_pos)
            elseif(EXISTS "arm-linux-gnueabihf-objdump")
                execute_process(COMMAND "arm-linux-gnueabihf-objdump -f ${_lib_path} | grep ^architecture  | cut -d' ' -f-2 | sort -u" OUTPUT_VARIABLE _arch_data)
                string(FIND "${_arch_data}" "aarch64" _found_pos)
            endif()
        elseif ("${_arch}" STREQUAL "x64")
            execute_process(COMMAND "x86_64-linux-gnu-objdump  -f ${_lib_path} | grep ^architecture  | cut -d' ' -f-2 | sort -u" OUTPUT_VARIABLE _arch_data)
            string(FIND "${_arch_data}" "64" _found_pos)
        elseif ("${_arch}" STREQUAL "x86")
            execute_process(COMMAND "x86_64-linux-gnu-objdump  -f ${_lib_path} | grep ^architecture  | cut -d' ' -f-2 | sort -u" OUTPUT_VARIABLE _arch_data)
            string(FIND "${_arch_data}" "i386" _found_pos)
        else()
            execute_process(COMMAND "objdump  -f ${_lib_path} | grep ^architecture  | cut -d' ' -f-2 | sort -u" OUTPUT_VARIABLE _arch_data)
            string(FIND "${_arch_data}" "${_arch}" _found_pos)
        endif()

        if (_found_pos GREATER -1)
            set(${package_found} TRUE)
        endif()

    endif()

endmacro()


cmake_minimum_required(VERSION 3.20.0)

set(PROJECT_DEMO_NAME    "areg-sdk-demo")
set(PROJECT_DEMO_VERSION "2.0.0")

# Set the root of the demo project and its sources
set(AREG_SDK_DEMO_ROOT "${CMAKE_SOURCE_DIR}")
set(AREG_DEMO_SOURCES "${AREG_SDK_DEMO_ROOT}/demo")

# Control whether to integrate AREG SDK before or after the project declaration
if (NOT DEFINED INTEGRATE_AREG_BEFORE_PROJECT)
    set(INTEGRATE_AREG_BEFORE_PROJECT TRUE)  # Default is TRUE (integrate before `project()`)
endif()
set(CMAKE_LIBRARY_ARCHITECTURE "x86_64")
macro_test_find_package("SQLite3" "${CMAKE_SYSTEM_PROCESSOR}" AREG_USE_PACKAGES)

# Integration logic based on INTEGRATE_AREG_BEFORE_PROJECT flag
if (INTEGRATE_AREG_BEFORE_PROJECT)
    message(STATUS "Demo: >>> Integrating AREG SDK before declaring project()")
    # Integrate AREG SDK before calling project()
    macro_load_areg_sdk()
    # Define the project after integrating AREG SDK
    project(${PROJECT_DEMO_NAME} VERSION ${PROJECT_DEMO_VERSION} LANGUAGES C CXX)
else()
    # Integrate AREG SDK after calling project()
    message(STATUS "Demo: >>> Integrating AREG SDK after declaring project()")
    # Reset compiler settings to avoid potential warnings
    set(AREG_COMPILER "")
    set(AREG_COMPILER_FAMILY "")

    if (WIN32)
        if (DEFINED CMAKE_CXX_COMPILER)
            string(FIND "${CMAKE_CXX_COMPILER}" "clang-cl" _is_llvm REVERSE)
            if (_is_llvm GREATER -1)
                set(CMAKE_GENERATOR_TOOLSET ClangCL CACHE INTERNAL "Force ClangCL tool-set")
            endif()
        endif()

        if (DEFINED CMAKE_SYSTEM_PROCESSOR)
            string(FIND "${CMAKE_CXX_COMPILER}" "64" _is_64bit)
            if (_is_64bit GREATER -1)
                set(CMAKE_GENERATOR_PLATFORM x64    CACHE INTERNAL "Force 64-bit compilation")
            else()
                set(CMAKE_GENERATOR_PLATFORM Win32  CACHE INTERNAL "Force 32-bit compilation")
            endif()
        endif()
    endif()

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
#   2. Include '${AREG_SDK_ROOT}/areg.cmake'.
#   3. Include and build your projects (e.g., Demo).
# ##################################################################

# Step 1: AREG_SDK_ROOT is already set in macro_load_areg_sdk()

# Step 2: Include areg.cmake from AREG SDK
include(${AREG_SDK_ROOT}/areg.cmake)

# Step 3: Include the demo project and start building
include("${AREG_DEMO_SOURCES}/CMakeLists.txt")

# Print the configuration status
printAregConfigStatus(
    areg_FOUND
    "Demo"
    "------------------> AREG SDK Demo project CMake Status Report Begin <------------------"
    "-------------------> AREG SDK Demo project CMake Status Report End <-------------------"
)
