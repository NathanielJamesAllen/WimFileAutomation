@echo off


setlocal enabledelayedexpansion

:: Get Manufacturer using Powershell
for /f %%M in ('powershell -NoProfile -Command "(Get-CimInstance -Class Win32_ComputerSystem).Manufacturer"') do (
    set "ComputerManufacturer=%%M"
    echo The manufacturer of this computer is !ComputerManufacturer!
)

if /i not "!ComputerManufacturer!" == "Microsoft" (
    echo Starting powershell script to create wim file of DriverApps Folder ...
    start /wait "" powershell -executionpolicy bypass -file "%~dp0CreateDriverAppsWim.ps1"
    echo DriverApps Wim created successfully

    echo Starting powershell script to create wim file of Drivers Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDriversWim.ps1"
    echo Drivers Wim created successfully

) else (
    REM cd C:\Users\a-vita_sd\Downloads\

    set /p driverMsi=Enter the driverMsi name:
    echo Extracting  driver msi ...
    msiexec /a "%driverMsi%" targetdir="C:\Drivers" /qn /l*v admin_install.log

    set /p dockMsi=Enter the dockMsi name:
    echo Extracting dock msi ...
    msiexec /a "%dockMsi%" targetdir="C:\Dock" /qn /l*v admin_install.log

    REM if exist "C:\Downloads\*.msi"(
    REM  del "C:\Downloads\*.msi" /f /q
    REM  echo  Folders with msi extension deleted ...
    REM)

    echo Starting powershell script to create wim file of Dock Folder ...
    start /wait "" powershell -executionpolicy bypass -file "%~dp0CreateDockWim.ps1"
    echo Dock Wim created successfully

    echo Starting powershell script to create wim file of Drivers Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDriversWim.ps1"
    echo Driver Wim created successfully
    
)

endlocal

pause

exit