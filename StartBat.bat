@echo off
echo Starting powershell script to capture image of Drivers Folder ...
start "" powershell -executionpolicy bypass -file "%~dp0CaptureDriversImage.ps1"
echo Starting powershell script to capture image of DriverApps Folder ...
start "" powershell -executionpolicy bypass -file "%~dp0CaptureDriverAppsImage.ps1"

powershell -executionpolicy bypass -file "%~dp0ExportDriverAppsImage.ps1"
powershell -executionpolicy bypass -file "%~dp0ExportDriversImage.ps1"

echo files executed successfully
exit