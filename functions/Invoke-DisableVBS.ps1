# Disable VBS
function Invoke-DisableVBS {
	Write-Host "Disabling Virtualization-based Security..." -ForegroundColor Green
	bcdedit /set hypervisorlaunchtype off | Out-Null 
	bcdedit /set vsmlaunchtype off | Out-Null
	DISM /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart | Out-Null
}