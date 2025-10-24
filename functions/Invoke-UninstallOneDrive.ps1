######################
# Uninstall OneDrive #
function Invoke-UninstallOneDrive {
    Write-Host "Uninstalling OneDrive . . ." -ForegroundColor Green
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"Invoke-RestMethod 'https://github.com/asheroto/UninstallOneDrive/raw/refs/heads/master/UninstallOneDrive.ps1' | Invoke-Expression`"" -Wait
}