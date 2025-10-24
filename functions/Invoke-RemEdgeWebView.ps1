#########################
# Remove Edge + WebView #
function Invoke-RemEdgeWebView {
	<#
		.SYNOPSIS
			Remove Edge and Webview2
		.DESCRIPTION
			Long description

		.EXAMPLE
			Edge Only
			No Terminal - Edge only, with no terminal. Useful for Task Scheduler
			Edge + WebView

		.LINK
			https://github.com/ShadowWhisperer/Remove-MS-Edge

		.NOTES
			General notes
		#>

	Get-FileFromWeb -URL "https://github.com/ShadowWhisperer/Remove-MS-Edge/releases/latest/download/Remove-EdgeWeb.exe" -File "$env:TEMP\Remove-EdgeWeb.exe"
	Start-Process "$env:TEMP\Remove-EdgeWeb.exe" -Args "/s" -Wait -NoNewWindow
	Remove-Item "$env:TEMP\Remove-EdgeWeb.exe" -Force

	# UAC ISSUE (SOMETIMES IT ALSO GET FLAGGED BY AV)
	# Get-FileFromWeb -URL "https://github.com/ShadowWhisperer/Remove-MS-Edge/raw/refs/heads/main/Batch/Both.bat" -File "$env:TEMP\Both.bat"
	# Start-Process "cmd.exe" -ArgumentList "/c echo Y | `"%TEMP%\Both.bat`""
}