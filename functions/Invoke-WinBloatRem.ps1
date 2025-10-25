function Invoke-RemWinBloat {
	<#
		.SYNOPSIS
			REMOVE UNIVERSAL WINDOWS PLATFORM APPS
		.DESCRIPTION
			NVIDIA, CBS, Winget, Xbox, Snipping Tool
			Notepad(system), VBSCRIPT, Microsoft Paint, Windows Media Player Legacy (App)
			Media Features
	#>
    	
    Write-Host "Removing Universal Windows Platform (UWP) Apps..." -ForegroundColor Green
	Get-AppxPackage -AllUsers |
	Where-Object {
	    $_.Name -notlike '*NVIDIA*' -and
	    $_.Name -notlike '*CBS*' -and
	    $_.Name -notlike '*AppInstaller*' -and
	    $_.Name -notlike '*Gaming*' -and
	    $_.Name -notlike '*Xbox*' -and
		$_.Name -notlike '*Widgets*' -and
	    $_.Name -notlike '*WebExperience*'
	} |
	Remove-AppxPackage
    
	<#
		.SYNOPSIS
			Remove Windows Features on Demand (Capabilities)
		.DESCRIPTION
			This function removes a predefined list of Windows capabilities that are often considered unnecessary for many users.
			It targets features such as Steps Recorder, Quick Assist, Internet Explorer, Math Recognizer, PowerShell ISE, and more.
			Some features are commented out due to potential system instability or breaking certain functionalities.
		.LINK
			https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/features-on-demand-non-language-fod?view=windows-11
	#>

	Write-Host "Removing Available Features on Demand (Capabilities)..." -ForegroundColor Green
	# Remove Steps Recorder
	Write-Output "Removing Steps Recorder..."
	Remove-WindowsCapability -Online -Name "App.StepsRecorder~~~~0.0.1.0" | Out-Null
	# Remove Quick Assist
	Write-Output "Removing Quick Assist..."
	Remove-WindowsCapability -Online -Name "App.Support.QuickAssist~~~~0.0.1.0" | Out-Null
	# Remove Internet Explorer
	Write-Output "Removing Internet Explorer..."
	Remove-WindowsCapability -Online -Name "Browser.InternetExplorer~~~~0.0.11.0" | Out-Null
	# Delete Internet Explorer shortcuts
    Remove-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk" -Force
    Remove-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Internet Explorer.lnk" -Force
    Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Internet Explorer.lnk" -Force
    Remove-Item "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Internet Explorer.lnk" -Force
	# Remove DirectX Configuration Database
	Write-Output "Removing DirectX Configuration Database..."
	Remove-WindowsCapability -Online -Name "DirectX.Configuration.Database~~~~0.0.1.0" | Out-Null
	# Remove Face Recognition
	Write-Output "Removing Face Recognition..."
	Remove-WindowsCapability -Online -Name "Hello.Face.18967~~~~0.0.1.0" | Out-Null
	Remove-WindowsCapability -Online -Name "Hello.Face.20134~~~~0.0.1.0" | Out-Null
	# Remove Math Recognizer
	Write-Output "Removing Math Recognizer..."
	Remove-WindowsCapability -Online -Name "MathRecognizer~~~~0.0.1.0" | Out-Null
	# Remove Windows Media Player Legacy
	# Write-Output "Removing Windows Media Player Legacy..."
	# Remove-WindowsCapability -Online -Name "Media.WindowsMediaPlayer~~~~0.0.12.0" | Out-Null
	# Remove Extended Theme Content
	Write-Output "Removing Extended Theme Content..."
	Remove-WindowsCapability -Online -Name "Microsoft.Wallpapers.Extended~~~~0.0.1.0" | Out-Null
	# Remove Microsoft Paint Legacy
	# Write-Output "Removing Paint Legacy..."
	# Remove-WindowsCapability -Online -Name "Microsoft.Windows.MSPaint~~~~0.0.1.0" | Out-Null
	# Remove Notepad (system)
	# Write-Output "Removing Notepad (system)..."
	# Remove-WindowsCapability -Online -Name "Microsoft.Windows.Notepad.System~~~~0.0.1.0" | Out-Null
	# Remove-WindowsCapability -Online -Name "Microsoft.Windows.Notepad~~~~0.0.1.0" | Out-Null
	# Remove PowerShell ISE
	Write-Output "Removing PowerShell ISE..."
	Remove-WindowsCapability -Online -Name "Microsoft.Windows.PowerShell.ISE~~~~0.0.1.0" | Out-Null
	# Remove WordPad
	Write-Output "Removing WordPad..."
	Remove-WindowsCapability -Online -Name "Microsoft.Windows.WordPad~~~~0.0.1.0" | Out-Null
	# Remove OneSync
	Write-Output "Removing OneSync..."
	Remove-WindowsCapability -Online -Name "OneCoreUAP.OneSync~~~~0.0.1.0" | Out-Null
	# Remove OpenSSH Client
	Write-Output "Removing OpenSSH Client..."
	Remove-WindowsCapability -Online -Name "OpenSSH.Client~~~~0.0.1.0" | Out-Null
	# Remove Windows Fax and Scan
	Write-Output "Removing Fax and Scan..."
	Remove-WindowsCapability -Online -Name "Print.Fax.Scan~~~~0.0.1.0" | Out-Null
	# Remove Print Management Console
	Write-Output "Removing Print Management Console..."
	Remove-WindowsCapability -Online -Name "Print.Management.Console~~~~0.0.1.0" | Out-Null
	# breaks installer & uninstaller programs
	# Remove-WindowsCapability -Online -Name "VBSCRIPT~~~~" | Out-Null
	# Remove WMIC
	Write-Output "Removing WMIC..."
	Remove-WindowsCapability -Online -Name "WMIC~~~~" | Out-Null
	# Remove Windows Feature Experience Pack
	# breaks uwp snippingtool w10
	# Write-Output "Windows Feature Experience Pack..."
	# Remove-WindowsCapability -Online -Name "Windows.Client.ShellComponents~~~~0.0.1.0" | Out-Null
	# Remove Linear Address 57-bit
	# Write-Output "Removing Linear Address 57-bit..."
	# Remove-WindowsCapability -Online -Name "Windows.Kernel.LA57~~~~0.0.1.0" | Out-Null
	# Remove Character Map
	Write-Output "Removing Character Map..."
	Remove-Item "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\System Tools\Character Map.lnk" -Force -ErrorAction SilentlyContinue | Out-Null

    # DISABLE WINDOWS FEATURES
	Write-Host "Disabling Windows Features..." -ForegroundColor Green
	# .NET Framework 4.8
	# Dism /Online /NoRestart /Disable-Feature /FeatureName:NetFx4-AdvSrvs | Out-Null
	# Disable WCF Services
	Write-Output "Disabling WCF Services..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:WCF-Services45 | Out-Null
	# Disable TCP Port Sharing
	Dism /Online /NoRestart /Disable-Feature /FeatureName:WCF-TCP-PortSharing45 | Out-Null
	# Disable Media Features
	# Write-Output "Disabling Media Features..."
	# Dism /Online /NoRestart /Disable-Feature /FeatureName:MediaPlayback | Out-Null
	# Disable Microsoft Print to PDF
	Write-Output "Disabling Microsoft Print to PDF..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:Printing-PrintToPDFServices-Features | Out-Null
	# Disable Microsoft XPS Document Writer
	Write-Output "Disabling Microsoft XPS Document Writer..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:Printing-XPSServices-Features | Out-Null
	# Disable Print and Document Services
	Write-Output "Disabling Print and Document Services..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:Printing-Foundation-Features | Out-Null
	# Disable Internet Printing Client
	Dism /Online /NoRestart /Disable-Feature /FeatureName:Printing-Foundation-InternetPrinting-Client | Out-Null
	# Disable Remote Differential Compression API Support
	Write-Output "Disabling Remote Differential Compression API Support..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:MSRDC-Infrastructure | Out-Null
	# breaks search
	# Dism /Online /NoRestart /Disable-Feature /FeatureName:SearchEngine-Client-Package | Out-Null
	# Disable SMB 1.0/CIFS File Sharing Support
	Write-Output "Disabling SMB 1.0..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:SMB1Protocol | Out-Null
	Dism /Online /NoRestart /Disable-Feature /FeatureName:SMB1Protocol-Client | Out-Null
	Dism /Online /NoRestart /Disable-Feature /FeatureName:SMB1Protocol-Deprecation | Out-Null
	# Disable SMB Direct
	Write-Output "Disabling SMB Direct..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:SmbDirect | Out-Null
	# Disable Windows Identity Foundation 3.5
	Write-Output "Disabling Windows Identity Foundation 3.5..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:Windows-Identity-Foundation | Out-Null
	# Disable Windows Powershell 2.0
	Write-Output "Disabling Windows Powershell 2.0..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2Root | Out-Null
	Dism /Online /NoRestart /Disable-Feature /FeatureName:MicrosoftWindowsPowerShellV2 | Out-Null
	# Disable Work Folders Client
	Write-Output "Disabling Work Folders Client..."
	Dism /Online /NoRestart /Disable-Feature /FeatureName:WorkFolders-Client | Out-Null
	# Disable Hyper-V
	# Write-Output "Disabling Hyper-V..."
	# Dism /Online /NoRestart /Disable-Feature /FeatureName:Microsoft-Hyper-V-All | Out-Null
	# Disable Recall
	# Write-Output "Disabling Recall..."
	# Dism /Online /NoRestart /Disable-Feature /FeatureName:Recall | Out-Null

	# Uninstall Microsoft Update Health Tools 
	Write-Host "Uninstalling Microsoft Update Health Tools..." -ForegroundColor Green
	# Windows 11
	Start-Process "msiexec.exe" -ArgumentList '/X{C6FD611E-7EFE-488C-A0E0-974C09EF6473}', '/qn' -Wait -WindowStyle Hidden
	# Windows 10
	Start-Process "msiexec.exe" -ArgumentList '/X{1FC1A6C2-576E-489A-9B4A-92D21F542136}', '/qn' -Wait -WindowStyle Hidden
	# Clean Microsoft Update Health Tools
    Remove-Item 'HKLM:\SYSTEM\ControlSet001\Services\uhssvc' -Recurse -Force | Out-Null
	Unregister-ScheduledTask -TaskName PLUGScheduler -Confirm:$false
	# Uninstall Update for x64-based Windows Systems
	Write-Host "Uninstalling Update for x64-based Windows Systems..." -ForegroundColor Green	
	Start-Process "msiexec.exe" -ArgumentList '/X{B9A7A138-BFD5-4C73-A269-F78CCA28150E}', '/qn' -Wait -WindowStyle Hidden
	Start-Process "msiexec.exe" -ArgumentList '/X{85C69797-7336-4E83-8D97-32A7C8465A3B}', '/qn' -Wait -WindowStyle Hidden
	# (KB5001716)
	Start-Process "msiexec.exe" -ArgumentList '/x {B8D93870-98D1-4980-AFCA-E26563CDFB79} /qn /norestart' -Wait -WindowStyle Hidden

	# Uninstall Remote Desktop Connection
	Write-Host "Uninstalling Remote Desktop Connection..." -ForegroundColor Green
	function Wait-ProcessWindow {
	    param($ProcessName, $Timeout = 30)
	    $startTime = Get-Date
	    while (((Get-Date) - $startTime).TotalSeconds -lt $Timeout) {
	        $proc = Get-Process -Name $ProcessName -ErrorAction SilentlyContinue
	        if ($proc -and $proc.MainWindowTitle -ne "") {
	            return $proc
	        }
	        Start-Sleep -Milliseconds 500
	    }
	    return $null
	}

	function Test-RemoteDesktopInstalled {
	    try {
	        # Multiple methods to check if Remote Desktop is installed
	        $methods = @(
	            { Get-Command "mstsc.exe" -ErrorAction Stop | Out-Null },
	            { Test-Path "$env:Windir\System32\mstsc.exe" },
	            { Get-WindowsCapability -Online -Name "Microsoft.Windows.RemoteDesktop.Client*" -ErrorAction SilentlyContinue | Where-Object { $_.State -eq "Installed" } }
	        )
	        
	        foreach ($method in $methods) {
	            try {
	                & $method
	                return $true
	            } catch {
	                continue
	            }
	        }
	        return $false
	    } catch {
	        return $true  # Assume installed if we can't determine
	    }
	}

	try {
	    # Check if Remote Desktop is already uninstalled
	    if (-not (Test-RemoteDesktopInstalled)) {
	        # Write-Host "Remote Desktop is already uninstalled - skipping process" -ForegroundColor Green
	    } else {
	        # Write-Host "Starting Remote Desktop uninstall..." -ForegroundColor Yellow
	        
	        # Start the uninstall process
	        $process = Start-Process "mstsc.exe" -ArgumentList "/uninstall" -PassThru -WindowStyle Hidden
	        
	        # Wait for the window to appear with timeout
	        $windowProcess = Wait-ProcessWindow -ProcessName "mstsc" -Timeout 15
	        
	        if ($windowProcess) {
	            # Close the window using the main window handle
	            Add-Type @"
	                using System;
	                using System.Runtime.InteropServices;
	                public class WindowHelper {
	                    [DllImport("user32.dll")]
	                    public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);
	                    
	                    [DllImport("user32.dll")]
	                    public static extern bool EndDialog(IntPtr hDlg, IntPtr nResult);
	                    
	                    public const uint WM_CLOSE = 0x0010;
	                }
"@

	            # Try to close the window gracefully first
	            [WindowHelper]::SendMessage($windowProcess.MainWindowHandle, 0x0010, [IntPtr]::Zero, [IntPtr]::Zero) *> $null
	            
	            Start-Sleep -Seconds 3
	            
	            # If still running, force close
	            if (!$process.HasExited) {
	                $process | Stop-Process -Force 
	            }
	            
	            # Write-Host "Remote Desktop uninstall completed silently" -ForegroundColor Green
	        } else {
	            # Write-Host "No uninstall window detected - process may have completed" -ForegroundColor Yellow
	        }
	    }
	} catch {
	    # Write-Host "Process completed with notes: $_" -ForegroundColor Yellow
	} finally {
	    # Write-Host "Remote Desktop uninstall process finished" -ForegroundColor Cyan
	}
    
 	# WINDOWS STUFF

	# Disable Windows Platform Binary Table (WPBT)
	Write-Host "Disabling Windows Platform Binary Table (WPBT)..." -ForegroundColor Green
	reg add "HKLM\zSYSTEM\ControlSet001\Control\Session Manager" /v DisableWpbtExecution /t REG_DWORD /d 1 /f | Out-Null

	# Hide the Settings Home page
	Write-Host "Hiding the Settings Home page" -ForegroundColor Green
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "SettingsPageVisibility" -Value "hide:home" -Type String -Force | Out-Null
	
	# Remove Home and Gallery from explorer
	Write-Host "Removing Home and Gallery from explorer" -ForegroundColor Green
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}" -Name "(default)" -Force | Out-Null
	Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}" -Name "(default)" -Force | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1 -Type DWord -Force | Out-Null 	
    
	# Activate Windows Photo Viewer
	Write-Output "Activating Windows Photo Viewer..."
	'tif','tiff','bmp','dib','gif','jfif','jpe','jpeg','jpg','jxr','png','ico'|ForEach-Object{
 		reg add "HKLM\SOFTWARE\Microsoft\Windows Photo Viewer\Capabilities\FileAssociations" /v ".${_}" /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >$null 2>&1
 		reg add "HKCU\SOFTWARE\Classes\.${_}" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f >$null 2>&1
  	}
    
  	# Bloatware Killer Task
	Write-Output "Scheduling Bloatware Killer Task..."
	try {
		$dir="$env:ProgramData\Bloatware"
		New-Item $dir -ItemType Directory -Force  *> $null
		$script=@'
for ($i = 1; $i -le 3; $i++) {
    "gamingservices","AggregatorHost","MoUsoCoreWorker","UserOOBEBroker","WinStore.App","msedge","TextInputHost","SearchApp","ConnectedUserExperiences","CrossDeviceResume","MicrosoftEdgeUpdate","msedgewebview2","ONENOTEM" | % { Get-Process $_ -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue }
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

	# Hide Search box (0 = hidden, 1 = icon, 2 = box)
	Write-Output "Hiding Search box..."
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value 0 -Type DWord -Force | Out-Null
	# New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -PropertyType DWord -Value 0 -Force | Out-Null

	# Hide Task View
	Write-Output "Hiding Task View..."
	Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name 'ShowTaskViewButton' -Value 0 -Type DWord | Out-Null

  	# Disable Bing search suggestions in the Start menu search box
	Write-Output "Disabling Web Search & Search Highlights..."
	New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsAADCloudSearchEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDeviceSearchHistoryEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsMSACloudSearchEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "SafeSearchMode" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "ConnectedSearchUseWeb" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -PropertyType DWord -Value 1 -Force | Out-Null
	New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "EnableDynamicContentInWSB" -PropertyType DWord -Value 0 -Force | Out-Null
	New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -PropertyType DWord -Value 1 -Force | Out-Null
	New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings" -Name "IsDynamicSearchBoxEnabled" -PropertyType DWord -Value 0 -Force | Out-Null

	# Disable Windows Spotlight	
	# Disable cloud/Spotlight features via registry
	Write-Output "Disabling Windows Spotlight..."
	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableCloudOptimizedContent" -Type DWord -Value 1 | Out-Null	
	New-Item -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightFeatures" -Type DWord -Value 1 | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightWindowsWelcomeExperience" -Type DWord -Value 1 | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightOnActionCenter" -Type DWord -Value 1 | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsSpotlightOnSettings" -Type DWord -Value 1 | Out-Null
	Set-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableThirdPartySuggestions" -Type DWord -Value 1 | Out-Null	
	# Hide the "Meet Now" desktop icon
	Write-Output "Hiding Meet Now desktop icon..."	
	New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Force | Out-Null
	Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" -Type DWord -Value 1 | Out-Null

	# TASKS
	# Disable Unnecessary Tasks
	Write-Output "Disabling Unnecessary Tasks..."
	# Disable OneDrive, Edge, Brave and Google tasks
	Get-ScheduledTask | Where-Object { $_.TaskName -like "*OneDrive*" -or $_.TaskName -like "*Edge*" -or $_.TaskName -like "*Brave*" -or $_.TaskName -like "*Google*" } | ForEach-Object { Disable-ScheduledTask -TaskName $_.TaskName | Out-Null }
	# Disable security scheduled tasks
	schtasks /Change /TN "Microsoft\Windows\ExploitGuard\ExploitGuard MDM policy Refresh" /Disable | Out-Null
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cache Maintenance" /Disable | Out-Null
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Cleanup" /Disable | Out-Null
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Scheduled Scan" /Disable | Out-Null
	schtasks /Change /TN "Microsoft\Windows\Windows Defender\Windows Defender Verification" /Disable | Out-Null

	# Kill Microsoft Text Input Application
	Write-Output "Killing Microsoft Text Input Application..."
	cmd /c "taskkill /F /IM TextInputHost.exe >nul 2>&1"; $d=Get-ChildItem "$env:SystemRoot\SystemApps" -Dir -Filter "MicrosoftWindows.Client.CBS_*"|Select-Object -First 1 -ExpandProperty FullName
	if($d){$x=Join-Path $d "TextInputHost.exe"
		if(Test-Path $x){cmd /c "takeown /f `"$x`" >nul 2>&1 & icacls `"$x`" /grant *S-1-3-4:F >nul 2>&1 & move /y `"$x`" `"$env:SystemRoot\TextInputHost.exe.bak`" >nul 2>&1"}
	}

	# Remove Startup apps
	Write-Output "Removing Startup apps..."
 	Remove-Item -Recurse -Force "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup" | Out-Null
	Remove-Item -Recurse -Force "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" | Out-Null
	New-Item -Path "$env:AppData\Microsoft\Windows\Start Menu\Programs\Startup" -ItemType Directory | Out-Null
	New-Item -Path "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" -ItemType Directory | Out-Null

	# Prevent Print Spooler to start automatically with windows
	Write-Output "Preventing Print Spooler to start automatically with windows..."
	Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Services\Spooler' -Name 'Start' -Value 3

	# Disable Windows Search Indexing
	Write-Output "Disabling Windows Search Indexing..."
	Set-ItemProperty -Path 'HKLM:\SYSTEM\ControlSet001\Services\WSearch' -Name 'Start' -Value 4

	# Create System Properties Start menu shortcut
	Write-Output "Creating System Properties Start shortcut..."
	$t="$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\System Properties.lnk"
	$s=(New-Object -ComObject WScript.Shell).CreateShortcut($t)
	$s.TargetPath="$env:SystemRoot\System32\SystemPropertiesAdvanced.exe"
	$s.IconLocation="$env:SystemRoot\System32\SystemPropertiesAdvanced.exe"
	$s.Save() >$null 2>&1

	# WINDOWS 10 STUFF
 	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -le 19045) {
		Write-Host "Windows 10 Stuff..." -ForegroundColor Green

		# Clean Adobe Type Manager
		Write-Output "Cleaning Adobe Type Manager..."
		Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Font Drivers' -Recurse -Force | Out-Null

<#
	# Uninstall SnippingTool Legacy
	Start-Process "C:\Windows\System32\SnippingTool.exe" -ArgumentList "/Uninstall"
	# silent window for old snippingtool w10
	$processExists = Get-Process -Name SnippingTool -ErrorAction SilentlyContinue
	if ($processExists) {
		$running = $true
		do {
			$openWindows = Get-Process | Where-Object { $_.MainWindowTitle -ne '' } | Select-Object MainWindowTitle
			foreach ($window in $openWindows) {
				if ($window.MainWindowTitle -eq 'Snipping Tool') {
					Stop-Process -Force -Name SnippingTool -ErrorAction SilentlyContinue | Out-Null
					$running = $false
				}
			}
		} while ($running)
	} else {
	}
#>

		# Set Desktop Wallpaper and Style
		Write-Output "Setting Desktop Wallpaper and Style..."
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
		$WallpaperPath = "C:\Windows\web\wallpaper\Windows\img0.jpg"
		Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "WallpaperStyle" -Value "10"
		Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "TileWallpaper" -Value "0"
		[Wallpaper]::SystemParametersInfo(0x0014, 0, $WallpaperPath, 3) | Out-Null

	
		# Disable AppX Deployment Service
		Write-Output "Disabling AppX Deployment Service..."
		Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\AppXSvc" -Name "Start" -Value 4 -Type DWord | Out-Null
		
		# Disable TextInput Management Service	
		Write-Output "Disabling TextInput Management Service	..."
		Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\TextInputManagementService" -Name "Start" -Value 4 -Type DWord | Out-Null
		
		# Show Copy as Path always in right-click menu          
		Write-Output "Enabling Show Copy as Path always in right-click menu ..."
		$regPath = "Registry::HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\windows.copyaspath"
		New-Item -Path $regPath -Force | Out-Null; Set-ItemProperty -Path $regPath -Name "(default)" -Value "Copy &as path" | Out-Null
		Set-ItemProperty -Path $regPath -Name "InvokeCommandOnSelection" -Value 1 -Type DWord | Out-Null
		Set-ItemProperty -Path $regPath -Name "VerbHandler" -Value "{f3d06e7c-1e45-4a26-847e-f9fcdee59be0}" | Out-Null
		Set-ItemProperty -Path $regPath -Name "VerbName" -Value "copyaspath" | Out-Null   		
 		
		# Remove "Meet Now" icon from taskbar
		Write-Output "Removing Meet Now icon from taskbar..."
		New-Item -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" | Out-Null
		Set-ItemProperty -Path "HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "HideSCAMeetNow" -Type DWord -Value 1 | Out-Null
		
		# CLEAN START MENU W10
		Write-Output "Cleaning Start..."		
		Remove-Item -Recurse -Force "$env:SystemDrive\Windows\StartMenuLayout.xml"
		$MultilineComment = @'
<LayoutModificationTemplate xmlns:defaultlayout="http://schemas.microsoft.com/Start/2014/FullDefaultLayout" xmlns:start="http://schemas.microsoft.com/Start/2014/StartLayout" Version="1" xmlns:taskbar="http://schemas.microsoft.com/Start/2014/TaskbarLayout" xmlns="http://schemas.microsoft.com/Start/2014/LayoutModification">
	<LayoutOptions StartTileGroupCellWidth="6" />
	<DefaultLayoutOverride>
		<StartLayoutCollection>
			<defaultlayout:StartLayout GroupCellWidth="6" />
		</StartLayoutCollection>
	</DefaultLayoutOverride>
</LayoutModificationTemplate>
'@
		Set-Content -Path "C:\Windows\StartMenuLayout.xml" -Value $MultilineComment -Force -Encoding ASCII
		$layoutFile="C:\Windows\StartMenuLayout.xml"
		$regAliases = @("HKLM", "HKCU")
		foreach ($regAlias in $regAliases){
		$basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
		$keyPath = $basePath + "\Explorer"
		IF(!(Test-Path -Path $keyPath)) { New-Item -Path $basePath -Name "Explorer" | Out-Null }	
		Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 1 | Out-Null
		Set-ItemProperty -Path $keyPath -Name "StartLayoutFile" -Value $layoutFile | Out-Null
		}	
		Stop-Process -Force -Name explorer
		Timeout /T 5 | Out-Null
		foreach ($regAlias in $regAliases){
		$basePath = $regAlias + ":\SOFTWARE\Policies\Microsoft\Windows"
		$keyPath = $basePath + "\Explorer"
		Set-ItemProperty -Path $keyPath -Name "LockedStartLayout" -Value 0 | Out-Null
		}
  	}

 	# Windows 11 Stuff
  	elseif ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
		Write-Host "Windows 11 Stuff..." -ForegroundColor Green
		# Set Desktop Wallpaper and Style
		Write-Output "Setting Desktop Wallpaper and Style..."
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
		$WallpaperPath = "C:\Windows\web\Wallpaper\Windows\img19.jpg"
		Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "WallpaperStyle" -Value "10"
		Set-ItemProperty "HKCU:\Control Panel\Desktop" -Name "TileWallpaper" -Value "0"
		[Wallpaper]::SystemParametersInfo(0x0014, 0, $WallpaperPath, 3) | Out-Null
	
		# Revert to Classic Right-Click Menu
		Write-Output "Enabling Classic Right-Click Menu..."
		New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" -Name "InprocServer32" -force -value "" | Out-Null

		# Set taskbar alignment to left (0 = left, 1 = center)
		Write-Output "Aligning taskbar to the left..."
		New-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAl" -PropertyType DWord -Value 0 -Force | Out-Null

   		# Hide the recommended section in the Start menu. This will also change the start menu layout to More pins
		Write-Output "Hiding the recommended section in Start..."
		Write-Output "Changing the Start layout to More pins..."
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Force | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Start" -Name "HideRecommendedSection" -Value 1 -Type DWord | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "HideRecommendedSection" -Value 1 -Type DWord | Out-Null
		New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Force | Out-Null
		Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\Education" -Name "IsEducationEnvironment" -Value 1 -Type DWord | Out-Null

		# Remove all pinned apps from Start https://github.com/Raphire/Win11Debloat/tree/refs/heads/master/Assets/Start
		Write-Output "Removing all pinned apps from Start..."		
		Get-Process StartMenuExperienceHost | Stop-Process -Force | Out-Null; Start-Sleep -Milliseconds 200
		$dst="$env:LOCALAPPDATA\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start2.bin"
  		if (!(Test-Path (Split-Path $dst))){New-Item -Path (Split-Path $dst) -ItemType Directory -Force}
  		Invoke-WebRequest -Uri 'https://github.com/Raphire/Win11Debloat/raw/refs/heads/master/Assets/Start/start2.bin' -OutFile $dst -UseBasicParsing
	 	# Rename Windows Media Player Legacy Start menu shortcut if it exists
		Write-Output "Renaming Windows Media Player Legacy Start shortcut..."		
		Rename-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Windows Media Player Legacy.lnk" -NewName "Windows Media Player.lnk" -Force

		# Install legacy Snipping Tool and Paint apps	
		Write-Output "Installing legacy Snipping Tool and Paint apps..."

		# Ensure target directory exists
		New-Item -Path "C:\Program Files\Windows NT\Accessories" -ItemType Directory -Force | Out-Null	

		# Ensure Accessories folder exists
		New-Item -Path "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories" -ItemType Directory -Force | Out-Null	

		# SNIPPING TOOL
		# Snipping Tool (Windows 10 Version 1803)
		Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/main/SnippingTool.zip" -OutFile "$env:TEMP\SnippingTool.zip"
		Expand-Archive -Path "$env:TEMP\SnippingTool.zip" -DestinationPath "C:\Program Files\Windows NT\Accessories" -Force	
		# Create Snipping Tool Start menu shortcut
		Write-Output "Creating Snipping Tool Start shortcut..."
		$shell = New-Object -ComObject WScript.Shell
		$shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Snipping Tool.lnk")
		$shortcut.TargetPath = "C:\Program Files\Windows NT\Accessories\SnippingTool.exe"
		$shortcut.Save()		

		# PAINT
		# classic Paint (mspaint) app taken from Windows 10 Build 14393
		Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/main/Classic%20Paint.zip" -OutFile "$env:TEMP\ClassicPaint.zip"
		Expand-Archive -Path "$env:TEMP\ClassicPaint.zip" -DestinationPath "C:\Program Files\Windows NT\Accessories" -Force	
		# Create Paint Start menu shortcut  
		Write-Output "Creating Paint Start shortcut..."
		$shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Paint.lnk")
		$shortcut.TargetPath = "C:\Program Files\Windows NT\Accessories\mspaint1.exe"
		$shortcut.Save()

  		# NOTEPAD
		# Create Notepad Start menu shortcut
		Write-Output "Create Notepad Start shortcut..."
		$shortcut = $shell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Accessories\Notepad.lnk")
		$shortcut.TargetPath = "$env:SystemRoot\System32\notepad.exe"
		$shortcut.Save()
  		# Restore New Text Document context menu item
		Write-Output "Restoring New Text Document context menu item..."
		Invoke-WebRequest -Uri "https://github.com/vishnusai-karumuri/Registry-Fixes/raw/refs/heads/master/Restore_New_Text_Document_context_menu_item.reg" -OutFile "$env:TEMP\Restore_New_Text_Document_context_menu_item.reg"
  		Start-Process regedit.exe -ArgumentList "/s `"$env:TEMP\Restore_New_Text_Document_context_menu_item.reg`"" -Wait	
<#
		# Add "Edit with Notepad" to right-click context menu
		Write-Output "Adding Edit with Notepad to right-click context menu..."
		# Create .reg file
		$MultilineComment = @'
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\*\shell\Edit with &Notepad]
"Icon"="C:\\Windows\\System32\\notepad.exe,0"

[HKEY_CLASSES_ROOT\*\shell\Edit with &Notepad\command]
@="C:\\Windows\\System32\\notepad.exe \"%1\""
'@
		Set-Content -Path "$env:TEMP\EditWithNotepad.reg" -Value $MultilineComment -Force
		# import reg file
		Regedit.exe /S "$env:TEMP\EditWithNotepad.reg"
	}

	else {	
		Write-Output "Found unsupported Winver..." -ForegroundColor Red
		Timeout /T 5 | Out-Null
	} 
#>
	Stop-Process -Name explorer -Force | Out-Null
}