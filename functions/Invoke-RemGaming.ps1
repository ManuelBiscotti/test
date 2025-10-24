#########################
# Remove Windows Gaming #
function Invoke-RemGaming {
	<#
		.SYNOPSIS
			Remove Windows Gaming
		.DESCRIPTION
	#>

	Write-Host "Removing Windows Gaming..." -ForegroundColor Green

	Write-Output "Disabling Game Bar..."
	# disable gamebar regedit
	reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d "0" /f | Out-Null
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d "0" /f | Out-Null
	# disable open xbox game bar using game controller regedit
	reg add "HKCU\Software\Microsoft\GameBar" /v "UseNexusForGameBarEnabled" /t REG_DWORD /d "0" /f | Out-Null
	# disable gameinput service regedit
	reg add "HKLM\SYSTEM\ControlSet001\Services\GameInputSvc" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	# disable gamedvr and broadcast user service regedit
	reg add "HKLM\SYSTEM\ControlSet001\Services\BcastDVRUserService" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	# disable xbox accessory management service regedit
	reg add "HKLM\SYSTEM\ControlSet001\Services\XboxGipSvc" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	# disable xbox live auth manager service regedit
	reg add "HKLM\SYSTEM\ControlSet001\Services\XblAuthManager" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	# disable xbox live game save service regedit
	reg add "HKLM\SYSTEM\ControlSet001\Services\XblGameSave" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	# disable xbox live networking service regedit
	reg add "HKLM\SYSTEM\ControlSet001\Services\XboxNetApiSvc" /v "Start" /t REG_DWORD /d "4" /f | Out-Null
	
	# disable ms-gamebar notifications with xbox controller plugged in regedit	
	# create reg file
	$MultilineComment = @"
Windows Registry Editor Version 5.00	
	
; disable ms-gamebar notifications with xbox controller plugged in	
[HKEY_CLASSES_ROOT\ms-gamebar]	
"URL Protocol"=""	
"NoOpenWith"=""	
@="URL:ms-gamebar"	
	
[HKEY_CLASSES_ROOT\ms-gamebar\shell\open\command]	
@="\"%SystemRoot%\\System32\\systray.exe\""	
	
[HKEY_CLASSES_ROOT\ms-gamebarservices]	
"URL Protocol"=""	
"NoOpenWith"=""	
@="URL:ms-gamebarservices"	
	
[HKEY_CLASSES_ROOT\ms-gamebarservices\shell\open\command]	
@="\"%SystemRoot%\\System32\\systray.exe\""	
	
[HKEY_CLASSES_ROOT\ms-gamingoverlay]	
"URL Protocol"=""	
"NoOpenWith"=""	
@="URL:ms-gamingoverlay"	
	
[HKEY_CLASSES_ROOT\ms-gamingoverlay\shell\open\command]	
@="\"%SystemRoot%\\System32\\systray.exe\""	
"@
	Set-Content -Path "$env:TEMP\MsGamebarNotiOff.reg" -Value $MultilineComment -Force
	# import reg file
	Regedit.exe /S "$env:TEMP\MsGamebarNotiOff.reg"
	
	# stop gamebar running
	Stop-Process -Force -Name GameBar | Out-Null

	# Remove Gamebar & Xbox apps
	# GAMEBAR
	Write-Output "Removing Gamebar App..."
	Get-AppxPackage -allusers *Microsoft.XboxGameOverlay* | Remove-AppxPackage
	Get-AppxPackage -allusers *Microsoft.XboxGamingOverlay* | Remove-AppxPackage
	# XBOX
	Write-Output "Removing Xbox App..."
	Get-AppxPackage -allusers *Microsoft.GamingApp* | Remove-AppxPackage
	Get-AppxPackage -allusers *Microsoft.Xbox.TCUI* | Remove-AppxPackage
	Get-AppxPackage -allusers *Microsoft.XboxApp* | Remove-AppxPackage
	Get-AppxPackage -allusers *Microsoft.XboxIdentityProvider* | Remove-AppxPackage
	Get-AppxPackage -allusers *Microsoft.XboxSpeechToTextOverlay* | Remove-AppxPackage

	# Uninstall Microsoft GameInput
	Write-Output "Uninstalling Microsoft GameInput..."
	Start-Process "msiexec.exe" -ArgumentList '/x {F563DC73-9550-F772-B4BF-2F72C83F9F30} /qn /norestart'
	Start-Process "msiexec.exe" -ArgumentList '/x {0812546C-471E-E343-DE9C-AECF3D0137E6} /qn /norestart'

	# Disable Gaming Services
	Write-Host "Disabling Gaming Services..."

	$MultilineComment = @'
Windows Registry Editor Version 5.00

; Disable Gaming Services
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\GamingServicesNet]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\GamingServices]
"Start"=dword:00000004
'@
	Set-Content -Path "$env:TEMP\GamingServicesOff.reg" -Value $MultilineComment -Force
	# disable services RunAsTI
	$GamingServicesOff = @'
Regedit.exe /S "$env:TEMP\GamingServicesOff.reg"
'@
	RunAsTI powershell "-nologo -windowstyle hidden -command $GamingServicesOff"
	Timeout /T 5 | Out-Null

	# Remove Gaming Services
	Write-Output "Removing Gaming Services..."
	Get-AppxPackage -allusers *Microsoft.GamingServices* | Remove-AppxPackage
}