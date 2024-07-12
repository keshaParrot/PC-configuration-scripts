@echo off

REM Checking if the password parameter is provided
if "%1"=="" (
    REM If password is not provided, create UserAdmin account without a password
    net user UserAdmin /add /passwordreq:no
    echo Created UserAdmin without a password.
) else (
    REM If password is provided, set the password for UserAdmin account
    set PASSWORD=%1
    net user UserAdmin /add
    net user UserAdmin %PASSWORD%
    echo Password for UserAdmin was set successfully.
)

REM Adding UserAdmin to Administrators group
net localgroup Administrators UserAdmin /add

REM Restarting the system
shutdown.exe -r -t 0
