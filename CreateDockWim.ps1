# Parameters for automation
param(
    [string]$TempFileName = "tempDock.wim",   # WIM file name
    [string]$CaptureDir = "C:\Dock",          # Directory to capture
    [string]$ModelName = (Get-CimInstance -ClassName Win32_ComputerSystem).Model, # Model name
    [string]$CurrentDate = (Get-Date -Format "yyyyMMdd"), # Current date
    [string]$MergedImageName = "$ModelName Dock $Date", # Merges model, drivers, and date
    [string]$SourceWimPath = "C:\windows\system32\tempDock.wim",   # Source WIM file path
    [string]$DestinationWimPath = "C:\tempDock.wim" #Final WIM file path
)

$CaptureLog = "C:\temp\Logs\DISM_Capture_Dock.log"
$ExportLog  = "C:\temp\Logs\DISM_Export_Dock.log"

# Construct the DISM capture command
$DismCommand = @(
    "/capture-image",
    "/imagefile:`"$TempFileName`"",
    "/capturedir:`"$CaptureDir`"",
    "/name:`"$MergedImageName`"",
    "/compress:none"
    "/LogPath:`"$CaptureLog`"",
    "/LogLevel:4"
) -join " "

# Execute the capture command
Write-Host "Running DISM command: $DismCommand"
Start-Process -FilePath "dism.exe" -ArgumentList $DismCommand -NoNewWindow -Wait

# Check for errors
if ($LASTEXITCODE -eq 0) {
    Write-Host "DISM capture completed successfully."
} else {
    Write-Host "DISM capture failed with exit code $LASTEXITCODE."
}

# Construct the DISM export command
$DismCommand = @(
    "/export-image",
    "/sourceimagefile:`"$SourceWimPath`"",
    "/destinationimagefile:`"$DestinationWimPath`"",
    "/sourceindex:1",
    "/compress:recovery"
    "/LogPath:`"$ExportLog`"",
    "/LogLevel:4"
) -join " "

# Execute the  export command
Write-Host "Running DISM command: $DismCommand"
Start-Process -FilePath "dism.exe" -ArgumentList $DismCommand -NoNewWindow -Wait

# Check for errors
if ($LASTEXITCODE -eq 0) {
    Write-Host "DISM export completed successfully."
} else {
    Write-Host "DISM export failed with exit code $LASTEXITCODE."
}

Pause