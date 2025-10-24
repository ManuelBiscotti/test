# Disable Windows Security - AchillesScript
function Invoke-DisableDefender {
	# === AchillesScript One-Time Autorun Setup ===
	Write-Host "Creating Windows Defender disabler task..." -ForegroundColor Green
	# Define paths
	$desktop = [Environment]::GetFolderPath("Desktop")
	$batPath = Join-Path $desktop "AchillesAutoRun.bat"

	# Create the batch file content
	$batContent = @"
@echo off
setlocal enabledelayedexpansion

:: Method 1: Normal deletion
schtasks /Delete /TN "AchillesAutoRunOnce" /F >nul 2>&1

:: Method 2: Using wildcard (sometimes works if task hidden)
schtasks /Delete /TN "*AchillesAutoRunOnce*" /F >nul 2>&1

:: Method 3: Force via PowerShell
powershell -NoProfile -Command "Try { Unregister-ScheduledTask -TaskName 'AchillesAutoRunOnce' -Confirm:\$false -ErrorAction SilentlyContinue } Catch {}"

:: Method 4: Kill task if running
for /f "tokens=*" %%i in ('schtasks /Query /TN "AchillesAutoRunOnce" /FO LIST 2^>nul') do (
    taskkill /F /FI "WINDOWTITLE eq %%i" >nul 2>&1
)

:: Method 5: Remove any leftover files (optional)
del "%SystemRoot%\System32\Tasks\AchillesAutoRunOnce" /F /Q >nul 2>&1

:: Set temp path
set "temp=%temp%\AchillesScript.cmd"
	
:: Download AchillesScript
powershell -Command "Invoke-WebRequest -Uri 'https://github.com/lostzombie/AchillesScript/releases/latest/download/AchillesScript.cmd' -OutFile '%temp%' -UseBasicParsing"
	
:: Set environment variables

:: to disable backup of your settings
REM set NoBackup=1

:: to disable warning before reboot
set NoWarn=1

:: if you don't want to disable the Security app
REM set NoSecHealth=1

:: Run AchillesScript silently (Policies + Settings + Services + Blocking)
cmd /c "%temp% apply 4"
	
:: --- aggressive self-delete attempts (multiple methods) ---
:: 1) immediate delete
del "%~f0" /f /q 2>nul

:: 2) attempt via PowerShell (delayed)
powershell -NoProfile -WindowStyle Hidden -Command "Start-Sleep -Seconds 2; Remove-Item -LiteralPath '%~f0' -Force -ErrorAction SilentlyContinue" 2>nul

:: 3) take ownership + icacls then delete
takeown /f "%~f0" >nul 2>&1
icacls "%~f0" /grant "%USERNAME%:F" >nul 2>&1
del "%~f0" /f /q 2>nul

:: 4) detached cmd fallback to delete after short delay
start "" cmd /c "timeout /t 3 /nobreak >nul & del /f /q "%~f0" & exit"

exit /b
"@
	# Write batch file to Desktop
	Set-Content -Path $batPath -Value $batContent -Encoding ASCII

	# Create one-time scheduled task
	$action = New-ScheduledTaskAction -Execute "cmd.exe" -Argument "/c `"$batPath`""
	$trigger = New-ScheduledTaskTrigger -AtStartup
	$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest

	Register-ScheduledTask -TaskName "AchillesAutoRunOnce" -Action $action -Trigger $trigger -Principal $principal -Description "Run AchillesScript once after reboot" -Force | Out-Null

}
