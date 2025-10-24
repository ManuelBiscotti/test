# Personalization tweaks
function Invoke-WinPersonalize {
	Write-Host "Personalizing Windows..." -ForegroundColor Green
	# Enable dark mode (apps + system)
	Write-Output "Enabling dark mode globally..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Type DWord -Value 0 -Force
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Type DWord -Value 0 -Force

	# Unpin all taskbar icons
	Write-Output "Unpinning all Taskbar icons..."
	cmd /c "reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f >nul 2>&1"
	Remove-Item -Recurse -Force "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch" | Out-Null
	New-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" -ItemType Directory -Force | Out-Null
	New-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\ImplicitAppShortcuts" -ItemType Directory -Force | Out-Null

	# 🧡 Enable transparency
	Write-Output "Enabling transparency..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "EnableTransparency" -Type DWord -Value 1 -Force

	# ✅ Enable animations
	Write-Output "Enabling animations..."
	Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "UserPreferencesMask" -Value ([byte[]](0x9E,0x3E,0x07,0x80,0x12,0x00,0x00,0x00)) -Force

<#
	# 🟨 Set accent color
	Write-Output "Setting Colors..."

	# Accent colors orange
	$accentKeys = @(
	    'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent',
	    'HKU\.DEFAULT\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent'
	)
	$dwmKeys = @(
	    'HKCU\Software\Microsoft\Windows\DWM',
	    'HKU\.DEFAULT\Software\Microsoft\Windows\DWM'
	)
	foreach ($key in $accentKeys) {
	    reg add $key /v StartColorMenu /t REG_DWORD /d 4284394495 /f | Out-Null
	    reg add $key /v AccentColorMenu /t REG_DWORD /d 4286102015 /f | Out-Null
	    reg add $key /v AccentPalette /t REG_BINARY /d "FFE5CEFFFFD3ABFFFEC691FFFFB978FFFFAB5EFFFF9E44FFFE8C21FF88179800" /f | Out-Null
	}
	foreach ($key in $dwmKeys) {
	    reg add $key /v AccentColor /t REG_DWORD /d 4286102015 /f | Out-Null
	    reg add $key /v ColorizationColor /t REG_DWORD /d 3305093496 /f | Out-Null
	    reg add $key /v ColorizationAfterglow /t REG_DWORD /d 3305093496 /f | Out-Null
	}
	
	# 🟦 Light orange selection highlight
	$color = "255 165 0"  # RGB (light orange)
	Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "Hilight" -Value $color
	Set-ItemProperty -Path "HKCU:\Control Panel\Colors" -Name "HotTrackingColor" -Value $color
#>	
	# 🟧 Show accent color on title bars & borders
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\DWM" -Name "ColorPrevalence" -Type DWord -Value 1 | Out-Null

	# 🟩 Custom cursor
	Write-Output "Installing Cursor..."
	Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/refs/heads/main/Cursor.zip" -OutFile "$env:TEMP\Cursor.zip"
	Expand-Archive "$env:TEMP\Cursor.zip" -Dest "$env:TEMP" -Force
	
	$inf = Join-Path $env:TEMP "install.inf"
	if (!(Test-Path $inf)) {}
	
	$p = Start-Process rundll32 "setupapi.dll,InstallHinfSection DefaultInstall 132 $inf" -WindowStyle Hidden -PassThru
	
	Add-Type 'using System;using System.Runtime.InteropServices;public class C{[DllImport("user32.dll")]public static extern bool SystemParametersInfo(uint a,uint b,IntPtr c,uint d);public static void R(){SystemParametersInfo(0x57,0,IntPtr.Zero,0);}}' | Out-Null
	[C]::R()
	Start-Sleep -Milliseconds 300
	
	1..3 | ForEach-Object {
	    Get-Process rundll32 | Where-Object { $_.MainWindowTitle -match "Mouse|Cursors|Pointer" } | ForEach-Object {
	        $_.CloseMainWindow() | Out-Null
	        Start-Sleep -Milliseconds 200
	        if (-not $_.HasExited) { Stop-Process $_ -Force }
	    }
	
	    if ($p -and -not $p.HasExited) {
	        $p.CloseMainWindow() | Out-Null
	        if (-not $p.WaitForExit(500)) { Stop-Process $p -Force }
	    }
	
	    Get-Process rundll32 | Where-Object { $_.Id -ne $PID } | Stop-Process -Force
	}
<#
	# Wallpaper
	Write-Output "Changing Wallpaper..."
	$picturesFolder = [Environment]::GetFolderPath("MyPictures")
	$persistentWallpaperPath = Join-Path $picturesFolder "CustomWallpaper.jpg"
	Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/refs/heads/main/Wallpaper.jpg" -OutFile $persistentWallpaperPath -UseBasicParsing
	
	Add-Type @"
	using System.Runtime.InteropServices;
	public class Wallpaper {
	    public const int SPI_SETDESKWALLPAPER = 0x0014;
	    public const int SPIF_UPDATEINIFILE = 0x01;
	    public const int SPIF_SENDWININICHANGE = 0x02;
	    [DllImport("user32.dll", CharSet=CharSet.Auto)]
	    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
	}
"@
	Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "WallpaperStyle" -Value "10"
	Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "TileWallpaper" -Value "0"
	[Wallpaper]::SystemParametersInfo(0x0014, 0, $persistentWallpaperPath, 3) | Out-Null

	# MyDockFinder
	Get-FileFromWeb -Url "https://github.com/ManueITest/Windows/raw/refs/heads/main/MyDockFinder.zip" -File "$env:TEMP\MyDockFinder.zip"
	Expand-Archive -Path "$env:TEMP\MyDockFinder.zip" -DestinationPath "$env:TEMP\MyDockFinder" -Force
	Move-Item "$env:TEMP\MyDockFinder\MyDockFinder" "C:\MyDockFinder" -Force
	# Create a shortcut in the user's Startup folder
	$startup = [Environment]::GetFolderPath('Startup')
	$WshShell = New-Object -ComObject WScript.Shell
	$shortcutPath = Join-Path $startup "MyDockFinder.lnk"
	$shortcut = $WshShell.CreateShortcut($shortcutPath)
	$shortcut.TargetPath = "C:\MyDockFinder\Dock_64.exe"
	$shortcut.WorkingDirectory = "C:\MyDockFinder"
	$shortcut.WindowStyle = 1
	$shortcut.IconLocation = "C:\MyDockFinder\Dock_64.exe, 0"
	$shortcut.Save()
#>
	# if Windows 11+
	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
		# StartAllBack ROG Orb (W11)
		$Dest = "$env:ProgramFiles\StartAllBack\Orbs\rog.png"
		$Dir  = Split-Path $Dest
		if (-not (Test-Path $Dir)) { New-Item -Path $Dir -ItemType Directory -Force | Out-Null }
		
		Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/main/rog.png" -OutFile $Dest -UseBasicParsing
	
		# Create registry key if not exists
		if (-not (Test-Path 'HKCU:\Software\StartIsBack')) {
		    New-Item -Path 'HKCU:\Software\StartIsBack' -Force | Out-Null
		}

		# Set custom start button
		Set-ItemProperty -Path 'HKCU:\Software\StartIsBack' -Name 'OrbBitmap' -Value $Dest | Out-Null
		
		# Win7 Taskbar style
		# Set-ItemProperty -Path 'HKCU:\Software\StartIsBack' -Name 'TaskbarStyle' -Value 'Windows 7.msstyles' | Out-Null
		
		# Plumpness ( 1 = Buffer )
		New-ItemProperty -Path 'HKCU:\Software\StartIsBack' -Name 'FatTaskbar' -PropertyType DWord -Value 1 -Force | Out-Null
		
		# Hide user account picture
		# New-ItemProperty -Path 'HKCU:\Software\StartIsBack' -Name 'HideUserFrame' -PropertyType DWord -Value 1 -Force | Out-Null
		
		# Center task icons - Together with start button
		# New-ItemProperty -Path 'HKCU:\Software\StartIsBack' -Name 'TaskbarCenterIcons' -PropertyType DWord -Value 2 -Force | Out-Null
		<#
		# Disable rounded corners (W11)	
		Write-Output "Disabling rounded corners..."
		Invoke-WebRequest -Uri "https://github.com/valinet/Win11DisableRoundedCorners/releases/latest/download/Win11DisableOrRestoreRoundedCorners.exe" -OutFile "$env:TEMP\Win11DisableOrRestoreRoundedCorners.exe" -UseBasicParsing
		Start-Process -FilePath "$env:TEMP\Win11DisableOrRestoreRoundedCorners.exe" -ArgumentList "/disable" -Wait	
		#>
	}else{		
	}
<#
	Write-Output "Changing Recycle Bin icons..."
	
	# Download icons
	$iconFull   = "$env:ProgramData\RecycleBinFull.ico"
	$iconEmpty  = "$env:ProgramData\RecycleBinEmpty.ico"
	
	Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/refs/heads/main/IconGroup54.ico" -OutFile $iconFull -UseBasicParsing
	Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/refs/heads/main/IconGroup55.ico" -OutFile $iconEmpty -UseBasicParsing
	
	# Apply to registry
	$recyclePath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}\DefaultIcon"
	New-Item -Path $recyclePath -Force | Out-Null
	Set-ItemProperty -Path $recyclePath -Name "full"  -Value $iconFull
	Set-ItemProperty -Path $recyclePath -Name "empty" -Value $iconEmpty
	
	# Refresh icons
	ie4uinit.exe -show
#>
	# Restart Explorer to apply changes
	# Stop-Process -Name explorer -Force
	# Stop-Process -Name StartAllBackCfg -Force

	# ExplorerBlurMica
	Write-Output "Registering ExplorerBlurMica..."

	# Download and extract
	Invoke-WebRequest -Uri "https://github.com/Maplespe/ExplorerBlurMica/releases/latest/download/Release_x64.zip" -OutFile "$env:TEMP\Release_x64.zip"
	Expand-Archive "$env:TEMP\Release_x64.zip" -DestinationPath "C:\ExplorerBlurMica" -Force
	
	# Register the DLL silently using the /s flag
	regsvr32 /s "C:\ExplorerBlurMica\Release\ExplorerBlurMica.dll"
}