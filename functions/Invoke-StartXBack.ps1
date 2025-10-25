function Invoke-StartXBack {
	try {
		$dir="$env:ProgramData\Bloatware"
		New-Item $dir -ItemType Directory -Force  *> $null
		$script=@'
for ($i = 1; $i -le 3; $i++) {
    "gamingservices","AggregatorHost","RuntimeBroker","MoUsoCoreWorker","UserOOBEBroker","WinStore.App","msedge","TextInputHost","SearchApp","ConnectedUserExperiences","CrossDeviceResume","MicrosoftEdgeUpdate","msedgewebview2","ONENOTEM" | % { Get-Process $_ -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue }
    "MSDTC","VSS","uhssvc","Spooler","WSearch" | % { Stop-Service $_ -Force -ErrorAction SilentlyContinue }
    Start-Sleep -Seconds 1
}
'@
		$script | Set-Content "$dir\KillBloatware.ps1" -Encoding UTF8 -Force *> $null
		$trigger=New-ScheduledTaskTrigger -AtStartup
		$action=New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$dir\KillBloatware.ps1`""
		Register-ScheduledTask -TaskName "KillBloatwareAtStartup" -Action $action -Trigger $trigger -RunLevel Highest -User "SYSTEM" -Force *> $null
	} catch {
	}

	# StartIsBack (Windows 10)
	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -le 19045) {
		Write-Host "Installing StartIsBack..." -ForegroundColor Green
		$exe="$env:TEMP\StartIsBackPlusPlus_setup.exe"
		Invoke-WebRequest -Uri "https://startisback.sfo3.cdn.digitaloceanspaces.com/StartIsBackPlusPlus_setup.exe" -OutFile $exe
		Start-Process $exe -ArgumentList "/elevated /silent" -Wait
		Start-Process explorer
		
		# StartIsBack Orb (W10)
		$Dest="C:\Program Files (x86)\StartIsBack\Orbs\6801-6009.bmp"
		if (!(Test-Path (Split-Path $Dest))) { New-Item -Path (Split-Path $Dest) -ItemType Directory -Force | Out-Null }
		Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/refs/heads/main/6801-6009.bmp" -OutFile $Dest	
		New-Item -Path "HKCU:\Software\StartIsBack" -Force | Out-Null
		Set-ItemProperty -Path "HKCU:\Software\StartIsBack" -Name "OrbBitmap" -Value "C:\Program Files (x86)\StartIsBack\Orbs\6801-6009.bmp" | Out-Null
		
		# StartIsBack Registry Tweaks
		$MultilineComment = @"
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\SOFTWARE\StartIsBack]
"CurrentVersion"="2.9.20"
"WinBuild"=dword:00004a65
"WinLangID"=dword:00000409
"ModernIconsColorized"=dword:00000000
"WelcomeShown"=dword:00000002
"Start_LargeMFUIcons"=dword:00000001
"StartMetroAppsMFU"=dword:00000001
"StartScreenShortcut"=dword:00000000
"Start_LargeAllAppsIcons"=dword:00000000
"StartMetroAppsFolder"=dword:00000001
"Start_SortFoldersFirst"=dword:00000000
"Start_NotifyNewApps"=dword:00000000
"Start_AutoCascade"=dword:00000000
"Start_AskCortana"=dword:00000000
"Start_RightPaneIcons"=dword:00000002
"Start_ShowUser"=dword:00000001
"Start_ShowMyDocs"=dword:00000001
"Start_ShowMyPics"=dword:00000001
"Start_ShowMyMusic"=dword:00000001
"Start_ShowVideos"=dword:00000000
"Start_ShowDownloads"=dword:00000001
"Start_ShowSkyDrive"=dword:00000000
"StartMenuFavorites"=dword:00000000
"Start_ShowRecentDocs"=dword:00000000
"Start_ShowNetPlaces"=dword:00000000
"Start_ShowNetConn"=dword:00000000
"Start_ShowMyComputer"=dword:00000001
"Start_ShowControlPanel"=dword:00000001
"Start_ShowPCSettings"=dword:00000001
"Start_AdminToolsRoot"=dword:00000000
"Start_ShowPrinters"=dword:00000000
"Start_ShowSetProgramAccessAndDefaults"=dword:00000000
"Start_ShowCommandPrompt"=dword:00000000
"Start_ShowRun"=dword:00000001
"Start_MinMFU"=dword:00000009
"Start_JumpListItems"=dword:0000000a
"AutoUpdates"=dword:00000000
"Disabled"=dword:00000000
"StartIsApps"=dword:00000000
"NoXAMLPrelaunch"=dword:00000001
"TerminateOnClose"=dword:00000001
"AllProgramsFlyout"=dword:00000000
"CombineWinX"=dword:00000001
"HideUserFrame"=dword:00000001
"TaskbarLargerIcons"=dword:00000000
"TaskbarSpacierIcons"=dword:fffffffe
"TaskbarJumpList"=dword:00000001
"HideOrb"=dword:00000000
"HideSecondaryOrb"=dword:00000000
"StartMenuMonitor"=dword:00000001
"ImmersiveMenus"=dword:ffffffff
"WinkeyFunction"=dword:00000000
"MetroHotkeyFunction"=dword:00000000
"MetroHotKey"=dword:0000000a
"OrbBitmap"="C:\Program Files (x86)\StartIsBack\Orbs\6801-6009.bmp"
"TaskbarStyle"="C:\\Program Files (x86)\\StartIsBack\\Styles\\Windows 10.msstyles"
"AlterStyle"="C:\\Program Files (x86)\\StartIsBack\\Styles\\Plain10.msstyles"
"AppsFolderIcon"=hex(2):73,00,68,00,65,00,6c,00,6c,00,33,00,32,00,2e,00,64,00,\
  6c,00,6c,00,2c,00,33,00,00,00
"SettingsVersion"=dword:00000005

[HKEY_CURRENT_USER\SOFTWARE\StartIsBack\Cache]
"IdealHeight.6"=dword:00000000
"IdealHeight.9"=dword:00020009
"IdealWidth.9"="Control Panel"
"@
		
		Set-Content -Path "$env:TEMP\StartIsBack.reg" -Value $MultilineComment -Force							
		# import reg file
		Regedit.exe /S "$env:TEMP\StartIsBack.reg"
		
		<#
		
			SYNOPSIS.
				Start X Back
			ABOUT.
				Developed in collaboration with MAS & ASDCORP
			LINK.
				https://github.com/WitherOrNot/StartXBack

		#>
		
		Invoke-WebRequest -Uri "https://github.com/WitherOrNot/StartXBack/releases/latest/download/StartXBack.cmd" -OutFile "$env:TEMP\StartXBack.cmd"
		(Get-Content "$env:TEMP\StartXBack.cmd") | Where-Object { $_ -ne 'pause' } | Set-Content "$env:TEMP\StartXBack.cmd"
		& "$env:TEMP\StartXBack.cmd" -Wait
		
		# Download x86 DLL
		Invoke-WebRequest -Uri "https://github.com/WitherOrNot/StartXBack/releases/download/release/version_x86.dll" -OutFile "${env:ProgramFiles(x86)}\StartIsBack\version.dll"
		
	}
	
	# StartAllBack (Windows 11)
	elseif ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
		Write-Host "Installing StartAllBack..." -ForegroundColor Green
		# Download and silently install StartAllBack
		Write-Output "Downloading latest StartAllBack setup..."
		$installer = "$env:TEMP\StartAllBack_setup.exe"
		Invoke-WebRequest -Uri "https://www.startallback.com/download.php/StartAllBack_setup.exe" -OutFile $installer
		Write-Output "Installing StartAllBack silently..."
		Start-Process -FilePath $installer -ArgumentList "/elevated /silent" -Wait

		# Create reg file
		$MultilineComment = @'
Windows Registry Editor Version 5.00

[HKEY_CURRENT_USER\Software\StartIsBack]
"AutoUpdates"=dword:00000000
"SettingsVersion"=dword:00000006
"WelcomeShown"=dword:00000003
"UpdateCheck"=hex:a2,06,b2,19,3d,0a,dc,01
"FrameStyle"=dword:00000000
"AlterStyle"=""
"TaskbarStyle"=""
"SysTrayStyle"=dword:00000000
"BottomDetails"=dword:00000000
"Start_LargeAllAppsIcons"=dword:00000000
"AllProgramsFlyout"=dword:00000000
"StartMetroAppsFolder"=dword:00000001
"Start_SortOverride"=dword:0000000a
"Start_NotifyNewApps"=dword:00000000
"Start_AutoCascade"=dword:00000000
"Start_LargeSearchIcons"=dword:00000000
"Start_AskCortana"=dword:00000000
"HideUserFrame"=dword:00000001
"Start_RightPaneIcons"=dword:00000002
"Start_ShowUser"=dword:00000001
"Start_ShowMyDocs"=dword:00000001
"Start_ShowMyPics"=dword:00000001
"Start_ShowMyMusic"=dword:00000001
"Start_ShowVideos"=dword:00000000
"Start_ShowDownloads"=dword:00000001
"Start_ShowSkyDrive"=dword:00000000
"StartMenuFavorites"=dword:00000000
"Start_ShowRecentDocs"=dword:00000000
"Start_ShowNetPlaces"=dword:00000000
"Start_ShowNetConn"=dword:00000000
"Start_ShowMyComputer"=dword:00000001
"Start_ShowControlPanel"=dword:00000001
"Start_ShowPCSettings"=dword:00000001
"Start_AdminToolsRoot"=dword:00000000
"Start_ShowPrinters"=dword:00000000
"Start_ShowSetProgramAccessAndDefaults"=dword:00000000
"Start_ShowTerminal"=dword:00000000
"Start_ShowCommandPrompt"=dword:00000000
"Start_ShowRun"=dword:00000001
"TaskbarSpacierIcons"=dword:fffffffe
"TaskbarOneSegment"=dword:00000000
"TaskbarCenterIcons"=dword:00000000
"FatTaskbar"=dword:00000000
"TaskbarTranslucentEffect"=dword:00000000
"Start_MinMFU"=dword:00000009
"AppsFolderIcon"=hex(2):73,00,68,00,65,00,6c,00,6c,00,33,00,32,00,2e,00,64,00,\
  6c,00,6c,00,2c,00,33,00,00,00
"UpdateInfo"=hex:3c,3f,78,6d,6c,20,76,65,72,73,69,6f,6e,3d,22,31,2e,30,22,3f,\
  3e,0a,3c,55,70,64,61,74,65,20,4e,61,6d,65,3d,22,53,74,61,72,74,41,6c,6c,42,\
  61,63,6b,20,33,2e,39,2e,31,33,22,20,44,65,73,63,72,69,70,74,69,6f,6e,3d,22,\
  22,20,44,6f,77,6e,6c,6f,61,64,55,52,4c,3d,22,68,74,74,70,73,3a,2f,2f,73,74,\
  61,72,74,69,73,62,61,63,6b,2e,73,66,6f,33,2e,63,64,6e,2e,64,69,67,69,74,61,\
  6c,6f,63,65,61,6e,73,70,61,63,65,73,2e,63,6f,6d,2f,53,74,61,72,74,41,6c,6c,\
  42,61,63,6b,5f,33,2e,39,2e,31,33,5f,73,65,74,75,70,2e,65,78,65,22,20,4c,65,\
  61,72,6e,4d,6f,72,65,55,52,4c,3d,22,68,74,74,70,73,3a,2f,2f,77,77,77,2e,73,\
  74,61,72,74,61,6c,6c,62,61,63,6b,2e,63,6f,6d,2f,22,2f,3e,0a
"UpdateInfoHash"=dword:92d3cc3c
"NavBarGlass"=dword:00000000
"TaskbarAlpha"=dword:00000080
"SysTrayClockFormat"=dword:00000003

[HKEY_CURRENT_USER\Software\StartIsBack\Cache]
"OrbWidth.96"=dword:00000028
"OrbHeight.96"=dword:00000028
"IdealHeight.6"=dword:00000000
"IdealHeight.9"=dword:00020009
"IdealWidth.9"="Control Panel"

[HKEY_CURRENT_USER\Software\StartIsBack\DarkMagic]

[HKEY_CURRENT_USER\Software\StartIsBack\Taskbaz]
"Toolbars"=hex:0c,00,00,00,08,00,00,00,01,00,00,00,00,00,00,00,aa,4f,28,68,48,\
  6a,d0,11,8c,78,00,c0,4f,d9,18,b4,00,00,00,00,40,0d,00,00,00,00,00,00,28,00,\
  00,00,00,00,00,00,00,00,00,00,28,00,00,00,00,00,00,00,01,00,00,00
"Settings"=hex:30,00,00,00,fe,ff,ff,ff,02,00,00,00,03,00,00,00,30,00,00,00,28,\
  00,00,00,00,00,00,00,d8,02,00,00,00,04,00,00,00,03,00,00,60,00,00,00,01,00,\
  00,00

[HKEY_CURRENT_USER\Software\StartIsBack\Recolor]
'@

		# import reg
		Set-Content -Path "$env:TEMP\StartAllBack.reg" -Value $MultilineComment -Force
		reg import "$env:TEMP\StartAllBack.reg"
		
		# StartAllBack activator (for educational purpose only)
		irm "https://github.com/YT-Advanced/SAB/raw/refs/heads/main/SAB.ps1" | iex
		
	}else{$null}	
}
