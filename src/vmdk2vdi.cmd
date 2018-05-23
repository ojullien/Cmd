:: File Name  : vmdk2vdi.cmd
:: Description: duplicates a virtual vmdk disk medium to a new VDI image file with a new unique identifier (UUID).
:: Version    : 1.0.0
:: Date       : 2015-11-25
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601], VirtualBox
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).
@echo OFF
setlocal enableextensions disabledelayedexpansion

:init
set _BIN="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
if not exist %_BIN% call :exitOnError %_BIN% is missing !!!

if [%1] EQU [/?] call :exitOnError Usage: %~nx0 "virtual machine directory"

if [%1] EQU [] (set /p _"Source=Enter source:") else (set _Source=%1)
if not exist %_Source% call :exitOnError %_Source% does not exist !!!

:main
echo ----------------------------------------------------------------------
call :vmdir %_Source%
pause
goto:EOF

:vmdir
set folder=%~f1\*.vmdk
title Convert to vdi all vmdk located in "%~n1" ...
echo Convert to vdi all vmdk located in "%~n1" ...
for %%A in ("%folder%") do call :convertToVDI "%%A"
goto:EOF

:exitOnError
echo:
echo %*
echo:
pause
EXIT

:convertToVDI
set _Source=%1
if not exist %_Source% call :exitOnError %_Source% does not exist !!!
set _Destination="%~dpn1.vdi"
echo Convert: %_Source% to %_Destination%
%_BIN% clonehd --format VDI %_Source% %_Destination%
goto:EOF
