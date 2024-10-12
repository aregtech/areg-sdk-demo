@echo off
cls

set DEMO_ROOT=%~dp0
:: set the AREG_SDK_ROOT directory here
set AREG_SDK_ROOT=%1
:: The build root defined
set BUILD_ROOT=%2

@echo "Generating service interface files of the AREG SDK Demo"

:: Generate codes for demo 10_locsvc
@echo "Generating service interface files of 10_locsvc demo"
call java -jar %AREG_SDK_ROOT%tools\codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\10_locsvc\res\HelloWorld.siml --target=generate\demo\10_locsvc

:: Generate codes for demo 12_pubsvc
@echo "Generating service interface files of 12_pubsvc demo"
call java -jar %AREG_SDK_ROOT%tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\12_pubsvc\res\HelloWorld.siml --target=generate\demo\12_pubsvc

:: Generate codes for demo 16_pubfsm
@echo "Generating service interface files of 16_pubfsm demo"
call java -jar %AREG_SDK_ROOT%tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\16_pubfsm\res\PowerManager.siml --target=generate\demo\16_pubfsm
call java -jar %AREG_SDK_ROOT%tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\16_pubfsm\res\TrafficController.siml --target=generate\demo\16_pubfsm

:: Generate codes for demo 17_winchat
@echo "Generating service interface files of 17_winchat demo"
call java -jar %AREG_SDK_ROOT%tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\17_winchat\res\CentralMessager.siml --target=generate\demo\17_winchat
call java -jar %AREG_SDK_ROOT%/tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\17_winchat\res\ConnectionManager.siml --target=generate\demo\17_winchat
call java -jar %AREG_SDK_ROOT%/tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\17_winchat\res\DirectMessager.siml --target=generate\demo\17_winchat
call java -jar %AREG_SDK_ROOT%/tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\17_winchat\res\DirectConnection.siml --target=generate\demo\17_winchat

:: Generate codes for demo 19_pubwatchdog
@echo "Generating service interface files of 19_pubwatchdog demo"
call java -jar %AREG_SDK_ROOT%/tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\19_pubwatchdog\res\HelloWatchdog.siml --target=generate\demo\19_pubwatchdog

:: Generate codes for demo 21_pubunblock
@echo "Generating service interface files of 21_pubunblock demo"
call java -jar %AREG_SDK_ROOT%/tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\21_pubunblock\res\HelloUnblock.siml --target=generate\demo\21_pubunblock

:: Generate codes for demo 23_pubsubmix
@echo "Generating service interface files of 23_pubsubmix demo"
call java -jar %AREG_SDK_ROOT%/tools/codegen.jar --root=%BUILD_ROOT% --doc=%DEMO_ROOT%\23_pubsubmix\res\PubSubMix.siml --target=generate\demo\23_pubsubmix

@echo Completed to generate files...
