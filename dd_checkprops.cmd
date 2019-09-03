@echo off
:askconnected
echo Is device connected and fully booted?
echo.
echo [Y] Yes, device is connected and fully booted on
echo [N] No, Device is not connected or fully booted
if errorlevel 2 goto connect
if errorlevel 1 goto askADB

:connect
cls
echo Please connect aircraft and once it has fully booted on
echo.
echo then proceed
echo.
pause
goto askconnected

:askADB
cls
echo has ADB been enabled on connected device?
echo.
echo [Y] Yes, ADB is enabled
echo [N] No, ADB is not enabled please pull up DUMLdore
if errorlevel 2 goto duml
if errorlevel 1 goto getprops

:duml
cd DUMLdore-3.20
start dumldorev3.exe
cd ..
pause
:getprops
Echo Checking Aircraft PROPERTIES please wait...
ECHO.
adb shell grep -i 'device id' /data/upgrade/*.cfg.sig > devicetmp.txt
for /f "tokens=1-3 delims==>" %%A in (devicetmp.txt) do (set device=%%B)
adb shell grep -i 'firmware formal' /data/upgrade/*.cfg.sig > firmwaretmp.txt
for /f "tokens=1-2 delims==>" %%A in (firmwaretmp.txt) do (set cfirmware=%%B)
adb shell grep -i '0306' /data/upgrade/*.cfg.sig > FCtmp.txt
for /f "tokens=4-5 delims== " %%A in (fctmp.txt) do (set curFC=%%B)
  :: Remove quotes
   SET device=###%device%###
   SET device=%device:"###=%
   SET device=%device:###"=%
   SET device=%device:###=%
echo %device%
 :: Remove quotes
   SET cfirmware=###%cfirmware%###
   SET cfirmware=%cfirmware:"###=%
   SET cfirmware=%cfirmware:###"=%
   SET cfirmware=%cfirmware:###=%
echo %cfirmware%
:: Remove quotes
   SET curFC=###%curFC%###
   SET curFC=%curFC:"###=%
   SET curFC=%curFC:###"=%
   SET curFC=%curFC:###=%
echo %curFC%
pause
del /f /q *tmp.txt
end
