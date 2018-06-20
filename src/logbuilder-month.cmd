:: File Name  : logbuilder-month.cmd
:: Description: Build monthly apache log files.
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
TITLE Building monthly log files in progress ...

:: User Input
:readInput
SET /P _userinput="Month ?:"
IF %_userinput% EQU 0 GOTO readInput
SET /a _month="%_userinput%"*1
IF %_month% EQU 0 GOTO readInput

:: Script variables
SET _me=%~n0
SET _parent=%~dp0
SET _year=2017
IF /i %_month% LSS 10 SET _sMonth=0
IF /i %_month% GEQ 10 SET _sMonth=
SET _server=D:\<server's name>
SET _output=%_server%\output\month
SET _input=%_server%\input\log-
SET _domains=<domain1.com> <domain2.com>

ECHO -----------------------------------------------------
ECHO App configuration:
ECHO    input folder is:        %_input%*
ECHO    output folder is:       %_output%
ECHO    domains are:            %_domains%
ECHO    year to process is:     %_year%
ECHO    month to process is:    %_sMonth%%_month%
PAUSE

ECHO -----------------------------------------------------
ECHO Cleaning old log files ...
CALL :deletesFiles "%_output%\*.log"

ECHO Creating new monthly log files ...
FOR %%S IN ( %_domains% ) DO (
    CALL :createsEmptyFile  %_output%\%%S_%_sMonth%%_month%.log
)

ECHO -----------------------------------------------------
ECHO Building monthly logs ...

FOR /l %%D in (%_month%02,1,%_month%31) DO (
    ECHO Processing: %_year%%_sMonth%%%D ...
    FOR %%S in ( %_domains% ) DO (
        SET _monthlyFile=%%S_%_sMonth%%_month%.log
        SET _dailyFile=%_input%%_year%%_sMonth%%%D_0625\var\log\apache2\%%S\access.log
        IF NOT EXIST "!_dailyFile!" (
            ECHO Day %_year%%_sMonth%%%D for domain "%%S" is missing
        ) ELSE ( CALL :concatsFiles %_output%\!_monthlyFile! !_dailyFile! )
    )
)

SET /a _monthnext=%_month%+1
IF /i %_monthnext% GEQ 13 SET /a _year+=1
IF /i %_monthnext% GEQ 13 SET _monthnext=1
IF /i %_monthnext% LSS 10 SET _sMonthNext=0
IF /i %_monthnext% GEQ 10 SET _sMonthNext=
ECHO Processing: %_year%%_sMonthNext%%_monthnext%01 ...
FOR %%S IN ( %_domains% ) DO (
    SET _monthlyFile=%%S_%_sMonth%%_month%.log
    SET _dailyFile=%_input%%_year%%_sMonthNext%%_monthnext%01_0625\var\log\apache2\%%S\access.log
    IF NOT EXIST "!_dailyFile!" (
        ECHO Day %_year%%_sMonthNext%%_monthnext%01 for domain "%%S" is missing
    ) ELSE ( CALL :concatsFiles %_output%\!_monthlyFile! !_dailyFile! )
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
