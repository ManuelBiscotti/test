# Remove Windows AI
function Invoke-RemWinAI {
    Write-Host "Removing Windows AI..." -ForegroundColor Green
	# Create a response file with multiple "N" answers
	$responses = ("N" * 20) -join "`r`n"
	Set-Content -Path "$env:TEMP\responses.txt" -Value $responses | Out-Null
	
	# Download the original script and remove ReadKey() calls
	$scriptContent = (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/zoicware/RemoveWindowsAI/main/RemoveWindowsAi.ps1" -UseBasicParsing).Content
	$scriptContent = $scriptContent -replace '(?m)^.*ReadKey\(\).*$\n?', ''
	Set-Content -Path "$env:TEMP\RemoveWindowsAI.ps1" -Value $scriptContent -Force | Out-Null
	
	# Execute the script with redirected input in a new window
	Start-Process powershell.exe -ArgumentList @(
		'-NoProfile',
		'-ExecutionPolicy',
		'Bypass',
		'-File',
		"$env:TEMP\RemoveWindowsAI.ps1",
		'-NonInteractive',
		'-AllOptions'
	) -RedirectStandardInput "$env:TEMP\responses.txt" -WorkingDirectory $env:TEMP -PassThru -Wait | Out-Null
}