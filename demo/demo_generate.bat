@echo off
cls

set DEMO_SOURCES=%~dp0

:: set the DEMO_ROOT directory here
set DEMO_ROOT=%DEMO_SOURCES%..
set AREG_ROOT=%DEMO_ROOT%\thirdparty\areg-sdk\
set DEMO_PRODUCT=%DEMO_ROOT%\product\generate

@echo "Generating service interface files of the AREG SDK demo projects"

:: Generate codes for demo 10_locsvc
@echo "Generating service interface files of 10_locsvc demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\10_locsvc\services\HelloWorld.siml --target=demo\10_locsvc\services

:: Generate codes for demo 12_pubsvc
@echo "Generating service interface files of 12_pubsvc demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\12_pubsvc\services\HelloWorld.siml --target=demo\12_pubsvc\services

:: Generate codes for demo 16_pubfsm
@echo "Generating service interface files of 16_pubfsm demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\16_pubfsm\services\PowerManager.siml --target=demo\16_pubfsm\services
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\16_pubfsm\services\TrafficController.siml --target=demo\16_pubfsm\services

:: Generate codes for demo 17_winchat
@echo "Generating service interface files of 17_winchat demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\17_winchat\services\CentralMessager.siml --target=demo\17_winchat\services
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\17_winchat\services\ConnectionManager.siml --target=demo\17_winchat\services
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\17_winchat\services\DirectMessager.siml --target=demo\17_winchat\services
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\17_winchat\services\DirectConnection.siml --target=demo\17_winchat\services

:: Generate codes for demo 19_pubwatchdog
@echo "Generating service interface files of 19_pubwatchdog demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\19_pubwatchdog\services\HelloWatchdog.siml --target=demo\19_pubwatchdog\services

:: Generate codes for demo 21_pubunblock
@echo "Generating service interface files of 21_pubunblock demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\21_pubunblock\services\HelloUnblock.siml --target=demo\21_pubunblock\services

:: Generate codes for demo 23_pubsubmix
@echo "Generating service interface files of 23_pubsubmix demo"
call java -jar %AREG_ROOT%/tools/codegen.jar --root=%DEMO_PRODUCT% --doc=%DEMO_SOURCES%\23_pubsubmix\services\PubSubMix.siml --target=demo\23_pubsubmix\services

@echo Completed to generate files...
