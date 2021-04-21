@echo off
setlocal

IF [%1]==[] GOTO BLANK
IF [%2]==[] GOTO BLANK

GOTO RUN

:BLANK
echo.
echo Usage: 
echo ApplyDBChanges.bat [version] [partnerID]
echo.
GOTO END

:RUN
@set v=%1
@set p=%2
SETLOCAL ENABLEDELAYEDEXPANSION
SET Skip=2

FOR %%I IN (%*) DO IF !Skip! LEQ 0 ( 
        SET params=!params! %%I
    ) ELSE SET /A Skip-=1

cd %~dp0
@echo on
DBUpgrade.exe -t=GTM -m=Security=ftzweb:userauth -v=%v% -p=%p% %params%

:END