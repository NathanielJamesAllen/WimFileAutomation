# Parameters for automation
param(
    [string]$sourceWimPath = "C:\windows\system32\tempDriverAppsUWP.wim",   # Source WIM file path
    [string]$destinationWimPath = "C:\tempDriverAppsUWP.wim"         # Destination WIM file path
)

# Construct the DISM command
$dismCommand = @(
    "/export-image",
    "/sourceimagefile:`"$sourceWimPath`"",
    "/destinationimagefile:`"$destinationWimPath`"",
    "/sourceindex:1",
    "/compress:recovery"
) -join " "

# Execute the command
Write-Host "Running DISM command: $dismCommand"
Start-Process -FilePath "dism.exe" -ArgumentList $dismCommand -NoNewWindow -Wait

# Check for errors
if ($LASTEXITCODE -eq 0) {
    Write-Host "DISM export completed successfully."
} else {
    Write-Host "DISM export failed with exit code $LASTEXITCODE."
}