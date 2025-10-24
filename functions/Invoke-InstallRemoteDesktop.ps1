#############################
# Remote Desktop Connection #
function Invoke-RemoteDesktop {
	Write-Host "Installing Remote Desktop Connection..."
	# download remote desktop connection
	Get-FileFromWeb -URL "https://go.microsoft.com/fwlink/?linkid=2247659" -File "$env:TEMP\RemoteDesktopConnection.exe"
	# install remote desktop connection 
	cmd /c "%TEMP%\RemoteDesktopConnection.exe >nul 2>&1"
}