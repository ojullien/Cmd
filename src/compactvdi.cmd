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
@echo OFF
setlocal enableextensions disabledelayedexpansion

:init
set _BIN="C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"
if not exist %_BIN% call :exitOnError %_BIN% is missing !!!

if [%1] EQU [/?] call :exitOnError Usage: %~nx0 "virtual machine directory"

if [%1] EQU [] (set /p "_Source=Enter source: ") else (set _Source=%1)
if not exist %_Source% call :exitOnError "%_Source%" does not exist !!!

:main
echo ----------------------------------------------------------------------
call :vmdir %_Source%
echo ----------------------------------------------------------------------
call :snapshots %_Source%
pause
goto:EOF

:vmdir
set folder=%~f1\*.vdi
title Compact all vdi located in "%~n1" ...
echo Compact all vdi located in "%~n1" ...
for %%A in ("%folder%") do call :compactVDI "%%A"
goto:EOF

:snapshots
set subfolder=%~f1\snapshots\*.vdi
title Compact all vdi located in "%~n1\Snapshots" ...
echo Compact all vdi located in "%~n1\Snapshots" ...
for %%B in ("%subfolder%") do call :compactVDI "%%B"
goto:EOF

:exitOnError
echo:
echo %*
echo:
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
if not exist %_File% call :exitOnError %_File% does not exist !!!
set /a _SizeIn=((%~z1/1024)/1024)+0
echo Compact: %_File%
%_BIN% modifyhd %_File% --compact
set /a _SizeOut=((%~z1/1024)/1024)+0
call :getSize %_SizeIn% %_SizeOut%
goto:EOF
