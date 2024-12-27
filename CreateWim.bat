@echo off
echo Starting powershell script to create wim file of Drivers Folder ...
start "" powershell -executionpolicy bypass -file "%~dp0CreateDriversWim.ps1"
echo Starting powershell script to create wim file of DriverApps Folder ...
start "" powershell -executionpolicy bypass -file "%~dp0CreateDriverAppsWim.ps1"

echo files executed successfully
exit