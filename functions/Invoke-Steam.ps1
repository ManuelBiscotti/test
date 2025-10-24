# Install or upgrade Steam
function Invoke-Steam {	
	Write-Host "Installing Steam..." -ForegroundColor Green
	# Official installer
	$installer = "$env:TEMP\SteamSetup.exe"
	Get-FileFromWeb -URL "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe" $installer
	Start-Process -FilePath $installer -ArgumentList '/S' -PassThru | Wait-Process

	# Launch Steam, wait indefinitely for steamwebhelper to appear, then kill both immediately
	Start-Process "${env:ProgramFiles(x86)}\Steam\steam.exe"

	while (-not (Get-Process -Name 'steamwebhelper')) {
    	Start-Sleep -Milliseconds 200
	}

	# As soon as any steamwebhelper exists, kill all instances and Steam
	Get-Process -Name 'steamwebhelper' | Stop-Process -Force
	Get-Process -Name 'steam' | Stop-Process -Force

	# delete steam desktop shortcut
	$s="$env:PUBLIC\Desktop\Steam.lnk"
	if(Test-Path $s){Remove-Item $s -Force}

	$MultilineComment = @"
Windows Registry Editor Version 5.00

; This reg file implements all the changes can be done on Steam by regedit to achieve better gaming performance. By imribiy#0001

[HKEY_CURRENT_USER\SOFTWARE\Valve\Steam]
"SmoothScrollWebViews"=dword:00000000
"DWriteEnable"=dword:00000000
"StartupMode"=dword:00000000
"H264HWAccel"=dword:00000000
"DPIScaling"=dword:00000000
"GPUAccelWebViews"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Run]
"Steam"=-
"@
	Set-Content -Path "$env:TEMP\Steam.reg" -Value $MultilineComment -Force							
	# import reg file				
	Regedit.exe /S "$env:TEMP\Steam.reg"

	# Steam Low RAM Usage script
	$batchCode = @'
@echo off

set "Steam=%programfiles(x86)%\Steam\steam.exe"
start "" "%Steam%" -dev -console -nofriendsui -no-dwrite -nointro -nobigpicture -nofasthtml -nocrashmonitor -noshaders -no-shared-textures -disablehighdpi -cef-single-process -cef-in-process-gpu -single_core -cef-disable-d3d11 -cef-disable-sandbox -disable-winh264 -cef-force-32bit -no-cef-sandbox -vrdisable -cef-disable-breakpad -noverifyfiles -nobootstrapupdate -skipinitialbootstrap -norepairfiles -overridepackageurl steam://open/minigameslist
exit
'@
    
	$steamDir = "${env:ProgramFiles} (x86)\Steam"
	$batPath = "$steamDir\Steam.bat"
    
	Set-Content -Path $batPath -Value $batchCode -Encoding ASCII -Force
    
	$desktopShortcut = "$env:USERPROFILE\Desktop\Steam.lnk"
	$startMenuFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Steam"
	$startMenuShortcut = "$startMenuFolder\Steam.lnk"
    
	Remove-Item -Path $desktopShortcut -Force -ErrorAction SilentlyContinue
	Remove-Item -Path $startMenuShortcut -Force -ErrorAction SilentlyContinue
    
	if (-not (Test-Path $startMenuFolder)) {
    	New-Item -ItemType Directory -Path $startMenuFolder -Force | Out-Null
	}

	$shell = New-Object -ComObject WScript.Shell
	$steamExe = "$steamDir\steam.exe"
    
	$desktopSC = $shell.CreateShortcut($desktopShortcut)
	$desktopSC.TargetPath = $batPath
	$desktopSC.WorkingDirectory = $steamDir
	$desktopSC.IconLocation = "$steamExe, 0"
	$desktopSC.Save()
    
	$startMenuSC = $shell.CreateShortcut($startMenuShortcut)
	$startMenuSC.TargetPath = $batPath
	$startMenuSC.WorkingDirectory = $steamDir
	$startMenuSC.IconLocation = "$steamExe, 0"
	$startMenuSC.Save()
    
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($desktopSC) | Out-Null
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($startMenuSC) | Out-Null
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($shell) | Out-Null
	[System.GC]::Collect()
	[System.GC]::WaitForPendingFinalizers()
}