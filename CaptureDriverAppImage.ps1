# Parameters for automation
param(
    [string]$ImageFile = "tempDriversAppsUWP.wim",   # Default WIM file path
    [string]$CaptureDir = "C:\DriverApps",          # Directory to capture
    [string]$ModelName = (Get-CimInstance -ClassName Win32_ComputerSystem).Model, # Model name
    [string]$Date = (Get-Date -Format "yyyyMMdd") # Default to today's date
)

# Combine model name and date for the image name
$imageName = "$ModelName DriverApps $Date"

# Construct the DISM command
$dismCommand = @(
    "/capture-image",
    "/imagefile:`"$ImageFile`"",
    "/capturedir:`"$CaptureDir`"",
    "/name:`"$imageName`"",
    "/compress:none"
) -join " "

# Execute the command
Write-Host "Running DISM command: $dismCommand"
Start-Process -FilePath "dism.exe" -ArgumentList $dismCommand -NoNewWindow -Wait

# Check for errors
if ($LASTEXITCODE -eq 0) {
    Write-Host "DISM capture completed successfully."
} else {
    Write-Host "DISM capture failed with exit code $LASTEXITCODE."
}