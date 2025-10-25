function Invoke-WinUpdatePause {
    Write-Host "Pausing Windows Updates..." -ForegroundColor Green
    $reg = Join-Path $env:TEMP 'windows-updates-pause.reg'
    Invoke-WebRequest -Uri 'https://github.com/Aetherinox/pause-windows-updates/raw/refs/heads/main/windows-updates-pause.reg' -OutFile $reg -UseBasicParsing
	Start-Process reg.exe -ArgumentList "import `"$reg`"" -Wait

	# Setting Security Updates only
	$batchCode = @'
<# :

:: Developed in collaboration with MAS & ASDCORP

@setlocal DisableDelayedExpansion
@echo off

echo "%*" | find /i "-el" >nul && set _elev=1

set _PSarg="""%~f0""" -el

setlocal EnableDelayedExpansion

>nul fltmc || (
if not defined _elev powershell "start cmd.exe -arg '/c \"!_PSarg:'=''!\"' -verb runas" && exit /b
echo.
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'.
pause
exit /b
)

set "psScript=%~f0" & powershell -nop -c "Get-Content """$env:psScript""" -Raw | iex" & exit /b
: #>

$ps1 = Join-Path $env:TEMP 'Invoke-WPFUpdatessecurity.ps1'
Invoke-WebRequest -Uri 'https://github.com/ChrisTitusTech/winutil/raw/refs/heads/main/functions/public/Invoke-WPFUpdatessecurity.ps1' -OutFile $ps1 -UseBasicParsing
# Remove all messagebox lines
(Get-Content $ps1) | Where-Object {$_ -notmatch '\[System\.Windows\.MessageBox'} | Set-Content -Path $ps1 -Encoding UTF8
. "$ps1"
if (Get-Command Invoke-WPFUpdatessecurity -ErrorAction SilentlyContinue) {
    Invoke-WPFUpdatessecurity
}
'@

	$batPath = "$env:TEMP\Invoke-WPFUpdatessecurity.bat"
	Set-Content -Path $batPath -Value $batchCode -Encoding ASCII
	Start-Process -FilePath $batPath -Wait -NoNewWindow *> $null
}