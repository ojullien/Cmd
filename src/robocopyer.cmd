:: File Name  : robocopyer.cmd
:: Description: Command-line directory replication command.
:: Version    : 1.1.0
:: Date       : 2017-06-28
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601], Robocopy from Microsoft Sysinternals
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).
@echo OFF
setlocal enableextensions disabledelayedexpansion

:init
set _BIN="C:\Windows\System32\robocopy.exe"
if not exist %_BIN% call :exitOnError %_BIN% is missing !!!

if [%1] EQU [/?] call :exitOnError Usage: %~nx0 "source directory" "destination directory" "log directory" (default c:\temp)

if [%1] EQU [] (set /p "_Source=Enter source:") else (set _Source=%1)
if not exist %_Source% call :exitOnError %_Source% does not exist !!!

if [%2] EQU [] (set /p "_Destination=Enter destination:") else (set _Destination=%2)
if not exist %_Destination% mkdir %_Destination%

if [%3] EQU [] (set "_LogDir=C:\Temp") else (set _LogDir=%3)
if not exist "%_LogDir%" mkdir %_LogDir%

:main
echo ----------------------------------------------------------------------
call :rob %_Source% %_Destination% %_LogDir%
ENDLOCAL
pause
goto:EOF

:rob
title Robocopy "%~n1" to "%~2" ...
echo Robocopy "%~n1" to "%~2" with log file in: "%~3" ...
set _LogFile=%~3\robocopy-%~n1.log
del /F /S /Q "%_LogFile%"
%_BIN% "%~1" "%~2" /Z /MIR /DST /R:3 /W:5 /X /V /FP /NS /NP /TEE /log:"%_LogFile%"
goto:EOF

:exitOnError
echo:
echo %*
echo:
ENDLOCAL
pause
EXIT
