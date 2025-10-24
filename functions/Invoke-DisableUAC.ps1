# Disable UAC
function Invoke-DisableUAC {
	Write-Host "Disabling UAC..." -ForegroundColor Green
	New-Item -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" | Out-Null
	New-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -value "0" -PropertyType Dword | Out-Null
	Set-ItemProperty -Path "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -value "0" | Out-Null
}
