# Parameters for automation
param(
    [string]$DriverImageFile = "tempDrivers.wim",   # Driver wim name
    [string]$DriverAppImageFile = "temp\DriverAppsUWP.wim", # DriverApp wim name
    [string]$CaptureDriverDir = "C:\Drivers",          # Drivers Directory to capture
    [string]$CaptureDriverAppsDir = "C:\DriverApps",   # DriverApps Directory to capture
    [string]$ModelName = (Get-CimInstance -ClassName Win32_ComputerSystem).Model, # Model name
    [string]$CurrentDate = (Get-Date -Format "yyyyMMdd") # Default to today's date
)
<#if ($Driverwim does not exist) {
    Write-Host "make driver wim."
} else {
    Write-Host "DISM capture failed with exit code $LASTEXITCODE."
}
if ($Driverwim does not exist) {
    Write-Host "make driver wim."
} else {
    Write-Host "DISM capture failed with exit code $LASTEXITCODE."
}
#>
$Directories = @($CaptureDriverDir, $CaptureDriverAppsDir)
$WimType = @("Driver", "DriverApps")
$WimName = @($DriverImageFile, $DriverAppImageFile)
$CombinedArrays = @($Directories, $WimType, $WimName)
for ($i = 0; $i -le 1; $i++) {
    Write-Host "Iteration '$i':"
    foreach ($array in $CombinedArrays){
    # Combine model name and date for the image name
    $imageName = "$ModelName $WimType $CurrentDate"

    # Construct the DISM command
    $dismCommand = @(
        "/capture-image",
        "/imagefile:`"$WimName`"",
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
    }
}
