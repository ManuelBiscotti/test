# Enable Updates
function Invoke-EnableWinUpdate {
	Write-Host "Enabling Updates..." -ForegroundColor Green

	$zip = Join-Path $env:TEMP 'windows-update-disabler-main.zip'
	$batch = Join-Path $env:TEMP 'windows-update-disabler-main\enable updates.bat'

	Invoke-WebRequest -Uri 'https://github.com/tsgrgo/windows-update-disabler/releases/latest/download/windows-update-disabler-main.zip' -OutFile $zip
	Expand-Archive -Path $zip -DestinationPath "$env:TEMP" -Force

	(Get-Content $batch) | Where-Object {
    	$_ -notmatch 'if not "%1"=="admin"' -and
    	$_ -notmatch 'if not "%2"=="system"' -and
    	$_ -notmatch '^\s*pause\s*$'
	} | Set-Content -Path $batch -Encoding ASCII

	RunAsTI $batch ""

	# Wait for process completion
	do {
    	Start-Sleep -Seconds 2
    	$running = Get-WmiObject Win32_Process -Filter "Name='cmd.exe'" 2>$null |
        	Where-Object { $_.CommandLine -like "*enable updates.bat*" }
	} while ($running)

	# Show Windows Update settings
    $regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
    $name = 'SettingsPageVisibility'
    $backupName = 'SettingsPageVisibility.backup'

    $backup = (Get-ItemProperty -Path $regPath -Name $backupName -ErrorAction SilentlyContinue).$backupName

    if ($null -ne $backup -and $backup -ne '') {
        # restore previous value
        Set-ItemProperty -Path $regPath -Name $name -Value $backup -Type String
        Remove-ItemProperty -Path $regPath -Name $backupName -ErrorAction SilentlyContinue
        "Restored previous SettingsPageVisibility value."
    } elseif ($backup -eq '') {
        # we created a blank backup meaning there was no previous value -> remove the setting
        Remove-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue
        Remove-ItemProperty -Path $regPath -Name $backupName -ErrorAction SilentlyContinue
        "Removed SettingsPageVisibility (no previous value existed)."
    } else {
        # no backup present -> just remove the setting
        Remove-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue
        "No backup found. Removed SettingsPageVisibility if present."
    }

    # refresh Settings app
    Get-Process -Name "SystemSettings","Settings" -ErrorAction SilentlyContinue | ForEach-Object { $_.CloseMainWindow() | Out-Null; Start-Sleep -Milliseconds 200; $_ | Stop-Process -Force -ErrorAction SilentlyContinue }

    "Revert done. A sign-out or reboot may be required for all users."
	
}