:: File Name  : logbuilder-year.cmd
:: Description: Build yearly apache log files.
:: Version    : 1.1.0
:: Date       : 2017-06-28
:: Author     : Olivier Jullien
:: Website    : https://github.com/ojullien
:: Requires   : Microsoft Windows [version 6.1.7601]
:: License    : MIT (https://github.com/ojullien/Cmd/blob/master/LICENSE).
@ECHO off
@VERIFY OTHER 2>nul
SETLOCAL ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
IF ERRORLEVEL 1 ( ECHO extension not enabled ) ELSE ( ECHO extension enabled )
TITLE Building yearly log files in progress ...

:: Script variables
SET _me=%~n0
SET _parent=%~dp0
SET _server=D:\<server's name>
SET _output=%_server%\output\year
SET _input=%_server%\input
SET _domains=<domain1.com> <domain2.com>
SET _year=2017

ECHO -----------------------------------------------------
ECHO App configuration:
ECHO    input folder is:        %_input%
ECHO    output folder is:       %_output%
ECHO    domains are:            %_domains%
ECHO    year to process is:     %_year%
PAUSE

ECHO -----------------------------------------------------
ECHO Cleaning old log files ...
CALL :deletesFiles "%_output%\*.log"

ECHO Creating new yearly log files ...
FOR %%D IN ( %_domains% ) DO (
    CALL :createsEmptyFile  %_output%\%%D_%_year%.log
)

ECHO -----------------------------------------------------
ECHO Building logs ...

FOR %%M in ( 01 02 03 04 05 06 07 08 09 10 11 12 ) DO (
    ECHO Processing: %_year%/%%M ...
    FOR %%D in ( %_domains% ) DO (
        SET _yearlyFile=%%D_%_year%.log
        SET _monthlyFile=%_input%\%%D_%%M.log
        IF NOT EXIST "!_monthlyFile!" (
            ECHO Month %%M for domain "%%D" is missing
        ) ELSE ( CALL :concatsFiles %_output%\!_yearlyFile! !_monthlyFile! )
    )
)

TITLE Building done
ECHO on
@PAUSE
@EXIT /B %ERRORLEVEL%

:: concats to files
:concatsFiles
IF NOT EXIST "%1" (
     ECHO %1 does not exist !!!
     EXIT /B 2
)
IF NOT EXIST "%2" (
    ECHO %2 does not exist !!!
    EXIT /B 2
)
COPY /B %1 + %2 %1 /V >NUL
EXIT /B 0

:: Deletes files in directory
:deletesFiles
DEL /F /S /Q %1 > NUL
EXIT /B 0

:: creates an empty file
:createsEmptyFile
TYPE NUL >%1
EXIT /B 0
