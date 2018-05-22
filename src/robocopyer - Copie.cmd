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
echo hello
::set /p _Destination="Enter destination: "
::title Robocopy %~n1 to %_Destination% ...
::echo ----------------------------------------------------------------------
::set _BIN="C:\Windows\System32\robocopy.exe"
::set LOG="C:\Temp\%~n1.log"
::echo %~dpLOG
::echo %~dp%LOG%
exit
::if not exist %_BIN% call :exitOnMissingError %_BIN%
::if not exist %~dp_LOG% call :exitOnMissingError %~dp_LOG%
::echo Robocopy %~n1 to %_Destination% with log file: %_LOG% ...
::echo ----------------------------------------------------------------------

:::main
::endlocal
::pause
::goto:EOF

:::exitOnMissingError
::echo ERROR: %1 does not exist !!! Aborting ...
::pause
::EXIT




title Robocopy E6510 to WD PASSPORT 120Go ...
echo OFF
cls
:CLEAN
echo -------------------------------------------------------------------------------
echo Cleaning ...
del /F /S /Q "%~dp0*.log"
:INIT
echo -------------------------------------------------------------------------------
set _Source=C:\Users\olivier\Documents\
set _Destination=H:\
set _SourceName="E6510"
set _DestinationName="WD PASSPORT 120Go"
set _ListDir=Resources
set _OptionsCopy=/Z /MIR
set _OptionsFile=/DST
set _OptionsRetry=/R:3 /W:5
set _OptionsLog=/X /V /FP /NS /NP /TEE
set _LogFile=e6510towdp120
echo SOURCE: %_SourceName% on %_Source%
echo DESTINATION: %_DestinationName% on %_Destination%
echo DIRECTORIES: %_ListDir%
echo OPTIONS: %_OptionsCopy% %_OptionsFile% %_OptionsRetry% %_OptionsLog%
echo LOG FILE: %_LogFile%
echo -------------------------------------------------------------------------------
:CHECKSOURCE
set _SourceChk=%_Source%Resources
if not exist "%_SourceChk%" echo %_SourceName% does not exist on %_Source% ! Aborting ...
if not exist "%_SourceChk%" goto ENDOFFILE
:CHECKDESTINATION
set _DestinationChk=%_Destination%120Go
if not exist "%_DestinationChk%" echo %_DestinationName% does not exist on %_Destination% ! Aborting ...
if not exist "%_DestinationChk%" goto ENDOFFILE
:ASK
echo %_SourceName% and %_DestinationName% are ready.
set /p _Continue=Would you like to continue [y/n]?
if /i "%_Continue%"=="y" (goto SAVE) else goto ENDOFFILE
:SAVE
echo -------------------------------------------------------------------------------
for %%b in ( %_ListDir% ) do (
robocopy "%_Source%\%%b" "%_Destination%\%%b" /Z /MIR /DST /R:3 /W:5 /X /V /FP /NS /NP /TEE /log:%_LogFile%-%%b-R.log
"C:\Program Files\SysinternalsSuite\contig.exe" -v -s "%_Destination%\%%b" > %_LogFile%-%%b-C.log
)
:ENDOFFILE
pause
echo ON
@echo ON
@EXIT /B 0
