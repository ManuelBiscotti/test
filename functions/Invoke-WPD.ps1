#######
# WPD #
function Invoke-WPD {

	<#
		.LINK
			https://wpd.app/
	#>

	# Disable Firewall
	Write-Output "Disabling Firewall"
	netsh advfirewall set allprofiles state off | Out-Null
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f > $null 2>&1
	
	# Run WPD automation
    Write-Output "Running WPD (Privacy dashboard for Windows)..."
    Invoke-WebRequest -Uri "https://wpd.app/get/latest.zip" -OutFile "$env:TEMP\latest.zip"
    Expand-Archive "$env:TEMP\latest.zip" -DestinationPath "$env:TEMP" -Force
    Start-Process "$env:TEMP\WPD.exe" -ArgumentList "-wfpOnly","-wfp on","-recommended","-close" -Wait

}