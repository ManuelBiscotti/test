# Disable Updates
function Invoke-DisableWinUpdate {
	Write-Host "Disabling Updates..." -ForegroundColor Green

	$zip = Join-Path $env:TEMP 'windows-update-disabler-main.zip'
	$batch = Join-Path $env:TEMP 'windows-update-disabler-main\disable updates.bat'

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
        	Where-Object { $_.CommandLine -like "*disable updates.bat*" }
	} while ($running)

	# Hide Windows Update settings
    $regPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
    $name = 'SettingsPageVisibility'
    $backupName = 'SettingsPageVisibility.backup'

    # ensure key exists
    if (-not (Test-Path $regPath)) { New-Item -Path $regPath -Force | Out-Null }

    # backup existing value (if any)
    $existing = (Get-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue).$name
    if ($null -ne $existing) {
        New-ItemProperty -Path $regPath -Name $backupName -Value $existing -PropertyType String -Force | Out-Null
    } else {
        # create backup marker so revert knows we created it
        New-ItemProperty -Path $regPath -Name $backupName -Value '' -PropertyType String -Force | Out-Null
    }

    # set hide value (overwrites; preserves you can edit to merge if desired)
    $hideValue = 'hide:windowsupdate'
    Set-ItemProperty -Path $regPath -Name $name -Value $hideValue -Type String

    # try to refresh Settings (close Settings app if open)
    Get-Process -Name "SystemSettings","Settings" -ErrorAction SilentlyContinue | ForEach-Object { $_.CloseMainWindow() | Out-Null; Start-Sleep -Milliseconds 200; $_ | Stop-Process -Force -ErrorAction SilentlyContinue }

    "Applied: $regPath\$name = $hideValue (backup -> $backupName). A sign-out or reboot may be required for all users."

}