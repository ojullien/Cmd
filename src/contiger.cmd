@echo OFF
setlocal enableextensions disabledelayedexpansion
title Defragments recursively all files located in %~n1 ...
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

:init
echo ----------------------------------------------------------------------
set _BIN="C:\Program Files\SysinternalsSuite\contig.exe"
if not exist %_BIN% call :exitOnMissingError %_BIN%
echo Defragments recursively all files located in %~n1 ...
echo ----------------------------------------------------------------------

:main
%_BIN% -s -q "%~f1"
pause
goto:EOF

:exitOnMissingError
echo ERROR: %1 does not exist !!! Aborting ...
pause
EXIT
