@echo off

echo Starting powershell script to create wim file of Drivers Folder ...
start "" powershell -executionpolicy bypass -file "%~dp0CreateDriversWim.ps1"

setlocal enabledelayedexpansion

:: Get Manufacturer using Powershell
for /f %%M in ('powershell -NoProfile -Command "(Get-CimInstance -Class Win32_ComputerSystem).Manufacturer"') do (
    set "ComputerManufacturer=%%M"
    echo The manufacturer of this computer is !ComputerManufacturer!
)

if /i not "!ComputerManufacturer!" == "Microsoft" (
    echo Starting powershell script to create wim file of DriverApps Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDriverAppsWim.ps1"
) else (
    echo Starting powershell script to create wim file of Dock Folder ...
    start "" powershell -executionpolicy bypass -file "%~dp0CreateDockWim.ps1"
)

endlocal

echo files executed successfully

pause

exit