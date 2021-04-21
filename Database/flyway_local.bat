@echo off
rem d:\flyway-6.1.3\flyway.cmd -X -n -url=jdbc:sqlserver://172.16.15.25;instanceName=QA2016;integratedSecurity=true;databaseName=JG_Demo2 -locations=filesystem:d:\dev\ogt\ogt-legacy_gtm-sql\database\20.2\release\application migrate
rem ;instanceName=MSSQLSERVER
rem .\flyway\flyway.cmd -encoding=UTF-16 -placeholders.PartnerID=100 -X -n -url=jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=IP_3000_JRL -locations=filesystem:d:\dev\ogt\ogt-legacy_gtm-sql\database\19.4\release\application migrate

rem .\flyway\flyway.cmd -placeholders.PartnerID=100 -n -url=jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=IP_3000_JRL -locations=filesystem:d:\dev\ogt\ogt-legacy_gtm-sql\database\application migrate

rem .\flyway\flyway.cmd -placeholders.PartnerID=100 -n -url=jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=IP_100_test -locations=filesystem:d:\dev\ogt\ogt-legacy_gtm-sql\database\application repair

rem .\flyway\flyway.cmd -placeholders.PartnerID=100 -n -url=jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=SEC_TEST -locations=filesystem:d:\dev\ogt\ogt-legacy_gtm-sql\database\Security migrate

if "%~1"=="" goto blank
if "%~2"=="" goto blank
if "%~3"=="" goto blank
if "%~4"=="" goto blank

setlocal

set action=%~1
set partnerid=%~2
set scriptPath=%~3
set url=%~4

SHIFT
SHIFT
SHIFT
SHIFT

set after1=

:loop
if "%~1" == "" goto end1
set after1=%after1% %1
SHIFT
goto loop
:end1

set rest=%after1%

echo on

.\flyway\flyway.cmd -placeholders.PartnerID=%partnerid% -n -locations=filesystem:d:\dev\ogt\ogt-legacy_gtm-sql\database\%scriptPath% %action% -url=%url% %rest%

endlocal

goto done



:blank

setlocal
CALL :GETPARENT PARENT
IF /I "%PARENT%" == "powershell" GOTO :ISPOWERSHELL
IF /I "%PARENT%" == "pwsh" GOTO :ISPOWERSHELL
endlocal


echo:
echo Usage: flyway_local.bat migrate 1001 application "jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=IP_100_test"
echo		this will run flyway on the database of your choice
echo:
echo add "-placeholders.isBaseline=1" for new partner setup

GOTO :EOF

:GETPARENT
SET "PSCMD=$ppid=$pid;while($i++ -lt 3 -and ($ppid=(Get-CimInstance Win32_Process -Filter ('ProcessID='+$ppid)).ParentProcessId)) {}; (Get-Process -EA Ignore -ID $ppid).Name"

for /f "tokens=*" %%i in ('powershell -noprofile -command "%PSCMD%"') do SET %1=%%i

GOTO :EOF

:ISPOWERSHELL

echo:
echo Usage: flyway_local.bat migrate 1001 application '"jdbc:sqlserver://localhost;integratedSecurity=true;databaseName=IP_100_test"' '"-outOfOrder=true"'
echo or
echo Usage: .\flyway_local.bat migrate 101099 Application '"jdbc:sqlserver://127.0.0.1:14330;databaseName=FTZLink_Letourneau_DEV;Password=;"' '"-outOfOrder=true"' '"-user=IP_APP_GTM"'
echo		this will run flyway on the database of your choice
echo:
echo add '"-placeholders.isBaseline=1"' for new partner setup




:done













