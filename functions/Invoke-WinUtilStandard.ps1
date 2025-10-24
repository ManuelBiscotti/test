# Chris Titus Tech's Windows Utility Automation
function Invoke-WinUtilStandard {
<#
.EXAMPLE
	Create Restore Point
    "WPFTweaksRestorePoint"
.EXAMPLE
	Run Disk Cleanup
	"WPFTweaksDiskCleanup"
.EXAMPLE
	Disable hibernation
	"WPFTweaksHiber"
.EXAMPLE
	Disable Full Screen optimization
	"WPFTweaksDisableFSO"
.EXAMPLE
	Remove OneDrive
	"WPFTweaksRemoveOnedrive"
.EXAMPLE
	Remove UWP Apps
	"WPFTweaksDeBloat"
.EXAMPLE
	Powershell 7
    "WPFTweaksPowershell7"
.EXAMPLE
    Disable Copilot
	"WPFTweaksRemoveCopilot"
.EXAMPLE
	Disable Notifications
    "WPFTweaksDisableNotifications"
.EXAMPLE
	Set time to UTC
	"WPFTweaksUTC"
#>

$json = @'
{
    "WPFTweaks":  [
                      "WPFTweaksTeredo",
                      "WPFTweaksWifi",
                      "WPFTweaksRazerBlock",
                      "WPFTweaksRightClickMenu",
                      "WPFTweaksDebloatAdobe",
                      "WPFTweaksDisableWpbtExecution",
                      "WPFTweaksDisableLMS1",
                      "WPFTweaksStorage",
					  "WPFTweaksDisableCrossDeviceResume",
                      "WPFTweaksRemoveHome",
                      "WPFTweaksIPv46",
                      "WPFTweaksConsumerFeatures",
                      "WPFTweaksDVR",
                      "WPFTweaksRemoveGallery",
                      "WPFTweaksTele",
                      "WPFTweaksDisplay",
                      "WPFTweaksAH",
                      "WPFTweaksEndTaskOnTaskbar",
                      "WPFTweaksBlockAdobeNet",
                      "WPFTweaksEdgeDebloat",
                      "WPFTweaksLoc",
                      "WPFTweaksHome",
                      "WPFTweaksDisableExplorerAutoDiscovery",
                      "WPFTweaksBraveDebloat",
                      "WPFTweaksPowershell7Tele",
                      "WPFTweaksDeleteTempFiles",
                      "WPFTweaksRecallOff",
                      "WPFTweaksDisableBGapps",
                      "WPFTweaksServices"				  				
                   ]
}
'@

	$config = "$env:TEMP\tweaks.json"
	$script = "$env:TEMP\winutil.ps1"
	
	Set-Content -Path $config -Value $json -Encoding ASCII
	Invoke-WebRequest -Uri "https://github.com/ChrisTitusTech/winutil/releases/latest/download/winutil.ps1" -OutFile $script
	
	# Use Start-Process with redirected output
	$psi = New-Object System.Diagnostics.ProcessStartInfo
	$psi.FileName = "powershell.exe"
	$psi.Arguments = "-NoProfile -Sta -ExecutionPolicy Bypass -File `"$script`" -Config `"$config`" -Run"
	$psi.RedirectStandardOutput = $true
	$psi.RedirectStandardError  = $true
	$psi.UseShellExecute = $false
	$psi.CreateNoWindow = $true
	
	$p = New-Object System.Diagnostics.Process
	$p.StartInfo = $psi
	$p.Start() | Out-Null
	
	$reader = $p.StandardOutput
	while (-not $p.HasExited) {
	    $line = $reader.ReadLine()
	    if ($null -ne $line) {
	        Write-Host $line
	        if ($line -match "Tweaks are Finished") {
	            $p.Kill()
	            break
	        }
	    } else {
	    }
	}
}