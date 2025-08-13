@echo off


setlocal enabledelayedexpansion

:: Get Manufacturer using Powershell
for /f %%M in ('powershell -NoProfile -Command "(Get-CimInstance -Class Win32_ComputerSystem).Manufacturer"') do (
    set "ComputerManufacturer=%%M"
    echo The manufacturer of this computer is !ComputerManufacturer!
)

if /i not "!ComputerManufacturer!" == "Microsoft" (
    echo Starting powershell script to create wim file of Drivers Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDriversWim.ps1"

    echo Starting powershell script to create wim file of DriverApps Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDriverAppsWim.ps1"
) else (
    cd C:\Downloads

    set /p driverMsi=Enter the driverMsi name:
    echo Extracting  driver msi ...
    msiexec /a "%driverMsi%" targetdir="C:\Drivers" /qn /l*v admin_install.log

    echo Starting powershell script to create wim file of Drivers Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDriversWim.ps1"

    set /p dockMsi=Enter the dockMsi name:
    echo Extracting dock msi ...
    msiexec /a "%dockMsi%" targetdir="C:\Dock" /qn /l*v admin_install.log
    echo Dock folder exists 
    echo Starting powershell script to create wim file of Dock Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDockWim.ps1"
)

endlocal

echo files executed successfully

pause

exit