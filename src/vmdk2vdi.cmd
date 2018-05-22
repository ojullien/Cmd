@echo OFF
setlocal enableextensions disabledelayedexpansion
title Convert to vdi all vmdk located in %~n1 ...
:: File Name  : vmdk2vdi.cmd
:: Description: duplicates a virtual vmdk disk medium to a new VDI image file with a new unique identifier (UUID).
:: Version    : 1.0.0
:: Date       : 2015-11-25
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601], VirtualBox
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).

:init
echo ----------------------------------------------------------------------
set _BIN="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
if not exist %_BIN% call :exitOnMissingError %_BIN%
echo Convert to vdi all vmdk located in %~n1 ...
echo ----------------------------------------------------------------------

:main
set "folder=%~f1\*.vmdk"
for %%A in ("%folder%") do call :convertToVDI "%%A"
pause
goto:EOF

:exitOnMissingError
echo ERROR: %1 does not exist !!! Aborting ...
pause
EXIT

:convertToVDI
set _Source=%1
if not exist %_Source% call :exitOnMissingError %_Source%
set _Destination="%~dpn1.vdi"
echo Convert: %_Source% to %_Destination%
%_BIN% clonehd --format VDI %_Source% %_Destination%
goto:EOF
