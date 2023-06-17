
# Examples with specific design must be included one by one.
include(${AREG_DEMO_SOURCES}/01_hello/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/04_trace/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/05_timer/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/10_locsvc/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/12_pubsvc/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/16_pubfsm/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/19_pubwatchdog/CMakeLists.txt)
include(${AREG_DEMO_SOURCES}/21_pubunblock/CMakeLists.txt)

if (AREG_DEVELOP_ENV MATCHES "Win32")
    # This projects are based either on MFC (Microsoft Foundation Classes)
    # or are compiled only under Windows. So that, they are available
    # only when compile with Microsoft Visual Studio.

    find_package(MFC)
    if (MFC_FOUND)
        # MFC specific projects. Can be compiled only if target machine has installed MFC.
        # Otherwise, output warning message and exclude from the build.
        include(${AREG_DEMO_SOURCES}/17_winchat/CMakeLists.txt)
    else(MFC_FOUND)
        message(NOTICE " >>> NOTE: due to missing installed MFC library, escaping compile projects:")
        message(NOTICE " >>>		${AREG_DEMO_SOURCES}/17_winchat")
    endif(MFC_FOUND)

endif()
