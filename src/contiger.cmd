:: File Name  : contiger.cmd
:: Description: Defragments a specified file or files.
::              Contig is a single-file defragmenter that attempts to make files contiguous on disk. Its perfect for
::              quickly optimizing files that are continuously becoming fragmented, or that you want to ensure are in as
::              few fragments as possible.
:: Version    : 1.0.0
:: Date       : 2015-11-25
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601], Contig from Microsoft Sysinternals
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).
@echo OFF
setlocal enableextensions disabledelayedexpansion

:init
set _BIN="C:\Program Files\SysinternalsSuite\contig.exe"
if not exist %_BIN% call :exitOnError %_BIN% is missing !!!

if [%1] EQU [/?] call :exitOnError Usage: %~nx0 "directory path"

if [%1] EQU [] (set /p "_Source=Enter source:") else (set _Source=%1)
if not exist %_Source% call :exitOnError %_Source% does not exist !!!

:main
echo ----------------------------------------------------------------------
call :cont %_Source%
pause
goto:EOF

:cont
title Defragments recursively all files located in "%~n1" ...
echo Defragments recursively all files located in "%~n1" ...
%_BIN% -s -q "%~f1"
goto:EOF

:exitOnError
echo:
echo %*
echo:
pause
EXIT
