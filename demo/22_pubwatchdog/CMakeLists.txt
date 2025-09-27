
# add service interface
addServiceInterface(22_generated demo/22_pubwatchdog/services/HelloWatchdog.siml)

# add projects
macro_declare_executable(22_pubclient   22_generated
    pubclient/src/main.cpp
    pubclient/src/ServiceClient.cpp
)

macro_declare_executable(22_pubservice   22_generated
    pubservice/src/main.cpp
    pubservice/src/ServicingComponent.cpp
)
