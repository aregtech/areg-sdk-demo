# ###########################################################################
# List of demo projects to build
# ###########################################################################

set(AREG_OPT_DISABLE_WARN_DEMO)
if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # disable warnings of generated codes.
    list(APPEND AREG_OPT_DISABLE_WARN_DEMO
            -Wno-cast-function-type 
            -Wno-cast-qual
            -Wno-disabled-macro-expansion
            -Wno-extra-semi-stmt
            -Wno-keyword-macro
            -Wno-sign-conversion 
            -Wno-unused-local-typedef
            -Wno-unused-macros
            -Wno-unused-parameter
    )
endif()

# Demo projects with specific design must be included one by one.
include(${AREG_DEMO_SOURCES}/01_minimalrpc/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/02_minimalipc/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/03_helloservice/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/07_logging/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/08_timer/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/13_locsvc/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/15_pubsvc/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/19_pubfsm/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/22_pubwatchdog/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/24_pubunblock/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/26_pubsubmix/CMakeLists.txt)

if (AREG_DEVELOP_ENV MATCHES "Win32")
    # This projects are based either on MFC (Microsoft Foundation Classes)
    # or are compiled only under Windows. So that, they are available
    # only when compile with Microsoft Visual Studio.

    find_package(MFC)
    if (MFC_FOUND)
        # MFC specific projects. Can be compiled only if target machine has installed MFC.
        # Otherwise, output warning message and exclude from the build.
        include(${AREG_DEMO_SOURCES}/20_winchat/CMakeLists.txt)
    else(MFC_FOUND)
        message(NOTICE " AREG Demo: >>> Due to missing installed MFC library, escaping compile projects:")
        message(NOTICE " AREG Demo: >>> ${AREG_DEMO_SOURCES}/17_winchat")
    endif(MFC_FOUND)

endif()
