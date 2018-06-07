:: File Name  : ziptimestamper.cmd
:: Description: Compress file or folder and add a timestamp to the name.
::              Use 7zip to compress. The archive is created in the same folder as the source.
:: Version    : 1.0.0
:: Date       : 2013-03-22
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601], Contig from Microsoft Sysinternals
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).
@echo OFF
setlocal enableextensions disabledelayedexpansion

:init
for /F "tokens=1-3 delims=/" %%a in ("%DATE%") do set _CurrentDate=%%c%%b%%a
for /F "tokens=1-3 delims=:," %%a in ('time /t') do set _CurrentTime=%%a%%b
set _BIN="D:\Program Files\7-Zip\7z.exe"
if not exist %_BIN% call :exitOnError %_BIN% is missing !!!

if [%1] EQU [/?] call :exitOnError Usage: %~nx0 "file to compress"

if [%1] EQU [] (set /p "_Source=Enter source:") else (set _Source=%1)
if not exist %_Source% call :exitOnError %_Source% does not exist !!!

if [%2] EQU [] (set _Destination=%~dp1\%~n1) else (set _Destination=%~dp1)

:main
echo ----------------------------------------------------------------------
echo %_Destination%
::call :cont %_Source%
pause
goto:EOF

:getDestination


:cont
::title Defragments recursively all files located in "%~n1" ...
echo Defragments recursively all files located in "%~n1" ...
::%_BIN% -s -q "%~f1"
goto:EOF

:exitOnError
echo:
echo %*
echo:
pause
EXIT
