@echo OFF
setlocal enableextensions enabledelayedexpansion
:: File Name  : robocopyer.cmd
:: Description: Command-line directory replication command.
:: Version    : 1.0.0
:: Date       : 2015-11-25
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601], Robocopy from Microsoft Sysinternals
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).

:init
if [%1]==[""] (set /p _Source="Enter source: ") else set _Source=%1
if [%2]==[""] (set /p _Destination="Enter destination: ") else set _Destination=%2
if [%3]==[""] (set _LOG="C:\Temp") else set _LOG=%3
echo ----------------------------------------------------------------------
set _BIN="C:\Windows\System32\robocopy.exe"
title Robocopy %_Source% to %_Destination% ...
if not exist %_BIN% call :exitOnMissingError %_BIN%
if not exist %_LOG% call :exitOnMissingError %_LOG%
if not exist %_Source% call :exitOnMissingError %_Source%
echo Robocopy %_Source% to %_Destination% with log file in: %_LOG% ...
echo ----------------------------------------------------------------------

:main
pause
goto:EOF

:exitOnMissingError
echo ERROR: %1 does not exist !!! Aborting ...
pause
EXIT /B 0
