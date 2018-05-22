@echo OFF
setlocal enableextensions disabledelayedexpansion
title Compact all vdi located in %~n1 and %~n1\Snapshots ...
:: File Name  : compactvdi.cmd
:: Description: compact disk images, i.e. remove blocks that only contains zeroes.
::              This will shrink a dynamically allocated image again; it will reduce the physical size of the image
::              without affecting the logical size of the virtual disk.
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
echo Compact all vdi located in %~n1 and %~n1\Snapshots ...
echo ----------------------------------------------------------------------

:main
set "folder=%~f1\*.vdi"
for %%A in ("%folder%") do call :compactVDI "%%A"

:snapshots
set "subfolder=%~f1\snapshots\*.vdi"
for %%B in ("%subfolder%") do call :compactVDI "%%B"
pause
goto:EOF

:exitOnMissingError
echo ERROR: %1 does not exist !!! Aborting ...
pause
EXIT

:getSize
set _SizeIn=%~1
set _SizeOut=%~2
set /a _SizeDiff=%_SizeIn%-%_SizeOut%
echo Gain %_SizeDiff% Mo ( from: %_SizeIn%Mo to: %_SizeOut%Mo)
goto:EOF

:compactVDI
set _File=%1
if not exist %_File% call :exitOnMissingError %_File%
set /a _SizeIn=((%~z1/1024)/1024)+0
echo Compact: %_File%
%_BIN% modifyhd %_File% --compact
set /a _SizeOut=((%~z1/1024)/1024)+0
call :getSize %_SizeIn% %_SizeOut%
goto:EOF
