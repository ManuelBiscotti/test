# WinUtil Redux
function Invoke-WinUtilMinimal {
$json = @'
{
    "WPFTweaks":  [
                      "WPFTweaksWifi",
                      "WPFTweaksDebloatAdobe",
                      "WPFTweaksDisableWpbtExecution",
                      "WPFTweaksDisableLMS1",
                      "WPFTweaksIPv46",
                      "WPFTweaksTele",
                      "WPFTweaksAH",
                      "WPFTweaksEdgeDebloat",
                      "WPFTweaksHome",
                      "WPFTweaksDisableExplorerAutoDiscovery",
                      "WPFTweaksBraveDebloat",
                      "WPFTweaksPowershell7Tele",
                      "WPFTweaksDisableCrossDeviceResume",
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