################
# Debloat Edge #

function Invoke-EdgeDebloat {
	Write-Host "Debloating Edge..." -ForegroundColor Green
	# edge-debloat
	Invoke-WebRequest -Uri "https://github.com/marlock9/edge-debloat/raw/refs/heads/main/edge-debloat.reg" -OutFile "$env:TEMP\edge-debloat.reg"
	# import reg file
	Regedit.exe /S "$env:TEMP\edge-debloat.reg"
	# remove logon edge
	cmd /c "reg delete `"HKLM\Software\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}`" /f >nul 2>&1"
	# disable edge services
	reg add "HKLM\SYSTEM\ControlSet001\Services\MicrosoftEdgeElevationService" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	reg add "HKLM\SYSTEM\ControlSet001\Services\edgeupdate" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	reg add "HKLM\SYSTEM\ControlSet001\Services\edgeupdatem" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	# disable edge tasks
	Get-ScheduledTask | Where-Object { $_.TaskName -like "*Edge*" } | ForEach-Object { Disable-ScheduledTask -TaskName $_.TaskName | Out-Null }
}