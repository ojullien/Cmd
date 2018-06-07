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

set "_Filename=%_CurrentDate%%_CurrentTime%"
if [%2] EQU [] ( call :getPathAndFilename %_Source% _Filename ) else ( call :getParentPath %_Source% _Filename )

:main
echo ----------------------------------------------------------------------
set _Destination=%_Filename%.%_CurrentDate%%_CurrentTime%.zip
title Zipping to "%_Destination%" ...
echo Zipping to "%_Destination%" ...
%_BIN% a "%_Destination%" %* -mx9
pause
goto:EOF

:getParentPath
set "_ParentDir=%~dp1"
set _ParentDir=%_ParentDir:~0,-1%
call :getPathAndFilename "%_ParentDir%" _ParentDir
set "%~2=%_ParentDir%"
goto:EOF

:getPathAndFilename
set "%~2=%~dp1%~n1"
goto:EOF

:exitOnError
echo:
echo %*
echo:
pause
EXIT
