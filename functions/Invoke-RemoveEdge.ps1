###############
# Remove Edge #
function Invoke-RemoveEdge {
    Write-Host "Removing Edge..." -ForegroundColor Green

	# Remove Edge with its own uninstaller
	$temp = "$env:TEMP\EdgeRemover.ps1"
	Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1" -OutFile $temp -UseBasicParsing
	Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$temp`" -UninstallEdge -RemoveEdgeData -NonInteractive" -Wait
	
	# Uninstall Microsoft Edge
	Invoke-RestMethod https://gist.github.com/ave9858/c3451d9f452389ac7607c99d45edecc6/raw/UninstallEdge.ps1 | Invoke-Expression

	<#
	Write-Output "Uninstalling EdgeUpdate...."
	# find edgeupdate.exe
	$edgeupdate = @(); "LocalApplicationData", "ProgramFilesX86", "ProgramFiles" | ForEach-Object {
	$folder = [Environment]::GetFolderPath($_)
	$edgeupdate += Get-ChildItem "$folder\Microsoft\EdgeUpdate\*.*.*.*\MicrosoftEdgeUpdate.exe" -rec -ea 0
	}
	# find edgeupdate & allow uninstall regedit
	$global:REG = "HKCU:\SOFTWARE", "HKLM:\SOFTWARE", "HKCU:\SOFTWARE\Policies", "HKLM:\SOFTWARE\Policies", "HKCU:\SOFTWARE\WOW6432Node", "HKLM:\SOFTWARE\WOW6432Node", "HKCU:\SOFTWARE\WOW6432Node\Policies", "HKLM:\SOFTWARE\WOW6432Node\Policies"
	foreach ($location in $REG) { Remove-Item "$location\Microsoft\EdgeUpdate" -recurse -force}
	# uninstall edgeupdate
	foreach ($path in $edgeupdate) {
	if (Test-Path $path) { Start-Process -Wait $path -Args "/unregsvc" | Out-Null }
	do { Start-Sleep 3 } while ((Get-Process -Name "setup", "MicrosoftEdge*").Path -like "*\Microsoft\Edge*")
	if (Test-Path $path) { Start-Process -Wait $path -Args "/uninstall" | Out-Null }
	do { Start-Sleep 3 } while ((Get-Process -Name "setup", "MicrosoftEdge*").Path -like "*\Microsoft\Edge*")
	}

	Write-Output "Removing EdgeWebview2...."
	# remove edgewebview regedit
	cmd /c "reg delete `"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView`" /f >nul 2>&1"
	cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView`" /f >nul 2>&1"
	# remove folders edge edgecore edgeupdate edgewebview temp
	Remove-Item -Recurse -Force "$env:SystemDrive\Program Files (x86)\Microsoft" | Out-Null
	#>
}