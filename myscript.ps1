#Requires -RunAsAdministrator

<#
	.SYNOPSIS

	.DESCRIPTION 

	.PARAMETER Recommended

	.PARAMETER Full

	.LINK
	https://github.com/ManuelBiscotti/Windows
#>




##############
# Parameters #
[CmdletBinding()]
param (
	[switch]$CPlusPlus

)
##############




function Invoke-Pause {
    try {
        if ($Host -and $Host.UI -and $Host.UI.RawUI) {
            Write-Host ""
            Write-Host "Press any key to continue..."
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
        } else {
            Read-Host -Prompt "Press Enter to continue"
        }
    } catch {
        Read-Host -Prompt "Press Enter to continue"
    }
}
function Pause { Invoke-Pause }

function Get-ConsoleWidth {
    try {
        if ($Host -and $Host.UI -and $Host.UI.RawUI -and $Host.UI.RawUI.WindowSize.Width) {
            return $Host.UI.RawUI.WindowSize.Width
        }
    } catch { }
    return 80
}

# -------------------------
# If switches used -> run them and exit (no menu)
# -------------------------
if ($PSBoundParameters.Count -gt 0) {
    try {
if ($CPlusPlus) {
    . ([ScriptBlock]::Create((irm 'https://github.com/ManuelBiscotti/test/raw/refs/heads/main/functions/Get-FileFromWeb.ps1')))
    . ([ScriptBlock]::Create((irm 'https://github.com/ManuelBiscotti/test/raw/refs/heads/main/functions/Invoke-CPlusPlus.ps1')))
    Get-FileFromWeb
    Invoke-CPlusPlus
}


    } catch {
        Write-Host "Error while running parameter actions: $_" -ForegroundColor Red
		pause
    }
    return
}

# -------------------------
# Full UI menu (runs only when no switches)
# -------------------------
$global:O = @(
	'Backup','Activation','Bloatware',
	'Updates','Telemetry','Security',
	'Services','Registry','Drivers',
	'Apps','Tuning','Tweaks',
	'Cleanup','Quick Access','Troubleshoot'
)

while ($true) {
    Clear-Host

    $w = Get-ConsoleWidth
    $c = { param($t) $s = [string]$t; (' ' * [Math]::Max(0,[Math]::Floor(($w - $s.Length)/2))) + $s }

    1..3 | ForEach-Object { '' }


    1..3 | ForEach-Object { '' }
    Write-Host (& $c " Not your avarage Windows optimizer... ") -ForegroundColor DarkGray
    Write-Host (& $c " Install Programs, Tweaks, Fixes, and Updates ") -ForegroundColor DarkGray
    Write-Host (& $c " ") -ForegroundColor DarkGray
    1..3 | ForEach-Object { '' }

    # --- UI helpers ---
    $ESC = [char]27
    function Reset-Ansi { "$ESC[0m" }
    function Get-Fg256Ansi([int]$n){ "$ESC[38;5;${n}m" }
    $AnsiColorMap = @{ Orange=208; Purple=129; Pink=205; Teal=37; Lime=118; Red=196; Blue=27; White=15; Black=16; Gray=244 }
    function Write-ColorInline($text,$color){
        if ($AnsiColorMap.ContainsKey($color)) {
            Write-Host ("{0}{1}{2}" -f (Get-Fg256Ansi $AnsiColorMap[$color]), $text, (Reset-Ansi)) -NoNewline
        } else {
            Write-Host $text -ForegroundColor $color -NoNewline
        }
    }

    function Show-Menu {
        param([array]$options,[hashtable]$colorOptions=@{})
        $cols = 3
        $w = Get-ConsoleWidth
        for ($row = 0; $row -lt $options.Count; $row += $cols) {
            $endIndex = [Math]::Min($row + $cols - 1, $options.Count - 1)
            $slice = $options[$row..$endIndex]
            # build a rawRow purely for centering calculation
            $items = for ($i=0; $i -lt $slice.Count; $i++) {
                $num = $row + $i + 1
                "[ $num ] $($slice[$i])"
            }
            $rawRow = ($items -join "    ")
            $padding = ' ' * [Math]::Max(0, [Math]::Floor(($w - $rawRow.Length)/2))
            Write-Host $padding -NoNewline

            for ($i=0; $i -lt $slice.Count; $i++) {
                $num = $row + $i + 1
                Write-ColorInline '[' "Orange"
                Write-Host " $num " -ForegroundColor White -NoNewline
                Write-ColorInline ']' "Orange"
                $txt = $slice[$i]
                if ($colorOptions.ContainsKey($txt)) {
                    Write-ColorInline " $txt" $colorOptions[$txt]
                } else {
                    Write-Host " $txt" -ForegroundColor White -NoNewline
                }
                if ($i -lt ($slice.Count - 1)) { Write-Host '    ' -NoNewline }
            }
            Write-Host "`n`n"
        }
    }

    # --- Main menu ---
    Show-Menu $O
    Write-ColorInline (& $c "Enter a number") 'Orange'
    Write-Host (& $c " ")
    Write-Host (& $c "SELECTION: ") -NoNewline
    $choice = Read-Host

    if ($choice -match '^\d+$') {
        $sel = [int]$choice
        if ($sel -ge 1 -and $sel -le $O.Count) {
            Clear-Host
            switch ($sel) {
				############################################################################
                1 {
                    Clear-Host
                    Invoke-CreateRestorePoint
                    Start-Process 'C:\Windows\System32\SystemPropertiesProtection.exe'
                }
				############################################################################
                2 {
                    $activationOptions = @('Buy Microsoft Software','Microsoft Activation Scripts')
                    $exitSubMenu = $false
                    while (-not $exitSubMenu) {
                        Clear-Host
				        1..3 | ForEach-Object { '' }
						
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
						# Show submenu
                        Show-Menu $activationOptions
                        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
                        Write-Host (& $c "SELECTION: ") -NoNewline
                        $appChoice = Read-Host
                        $skipPause = $false
                        Clear-Host
                        switch ($appChoice.ToUpper()) {
                            '1' {
								Start-Process "https://www.gamers-outlet.net/en/software" 
								Start-Process 'ms-settings:activation'
								$skipPause = $true
							}
                            '2' {
                                Invoke-RestMethod https://get.activated.win | Invoke-Expression
								Start-Process 'ms-settings:activation'
								$skipPause = $true
							}
							'i' { Start-Process "https://massgrave.dev/" }

                            'R' { $exitSubMenu = $true; $skipPause = $true }
                            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }
                        }
                        if (-not $skipPause) { Press-AnyKey }
                    }
                }
				############################################################################
                3 {
					$bloatwareOptions = @(
						'Debloat Windows','Uninstall OneDrive','Toggle Xbox Gamebar'						
						'Toggle Edge','Toggle Windows AI','Toggle Widgets',
						'Install Microsoft Store','Install OneDrive','Install Remote Desktop',
						'Remove EdgeWebView','Toggle Network Adapters','Toggle Start Search Shell'
					)
					$exitSubMenu = $false   # flag
					while (-not $exitSubMenu) {
					    Clear-Host

				        1..3 | ForEach-Object { '' }

						$lines = @(
						"    ____  __    ____  ___  _______       _____    ____  ______  ",
						"   / __ )/ /   / __ \/   |/_  __/ |     / /   |  / __ \/ ____/  ",
						"  / __  / /   / / / / /| | / /  | | /| / / /| | / /_/ / __/     ",
						" / /_/ / /___/ /_/ / ___ |/ /   | |/ |/ / ___ |/ _, _/ /___     ",
						"/_____/_____/\____/_/  |_/_/    |__/|__/_/  |_/_/ |_/_____/    "
						)

		                $width = [console]::WindowWidth
		                foreach($line in $lines){
		                    $pad = ($width + $line.Length) / 2
		                    Write-Host $line.PadLeft($pad) -ForegroundColor Magenta
		                }
						
						1..2 | ForEach-Object { '' }

						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
				    
				        # Show submenu
				        $colorOptions = @{ 
							'Debloat Windows' = 'Green'
							'Remove Edge + Webview' = 'Red'
							'Toggle Start Search Shell' = 'Red' 
						}
						Show-Menu -Options $bloatwareOptions -ColorOptions $colorOptions						
				    
				        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
				        Write-Host (& $c "SELECTION: ") -NoNewline
				        $appChoice = Read-Host
						$skipPause = $false
						Clear-Host
						switch ($appChoice.ToUpper()) {
							'1' { 
								# Invoke-Win11Debloat 
								Clear-Host
								# Invoke-WinUtilAuto 								
								Invoke-RemWinBloat
								Invoke-DebloatEdge
							}
				            '2' { Invoke-UninstallOneDrive }  
							'3' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/6%20Windows/6%20Gamebar.ps1 | iex"' }
                            '4' { Invoke-Expression (Invoke-RestMethod https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1) }
				            '5' { powershell -NoP -C "& ([scriptblock]::Create((irm 'https://raw.githubusercontent.com/zoicware/RemoveWindowsAI/main/RemoveWindowsAi.ps1')))"; $skipPause = $true }  
							'6' { 
								Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/6%20Windows/4%20Widgets.ps1 | iex"' 
							}
							'7' { 
								# Reinstall Microsoft Store
								Invoke-FixStore
								# Open Phone Link App page
								Start-Process "ms-windows-store://pdp/?ProductId=9NMPJ99VJBWV" 
							}
							'8' { Invoke-FixOneDrive }
							'9' { Invoke-RemoteDesktop }
							'10' { Invoke-RemoveEdgeWebView }
							'11' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/8%20Advanced/1%20Network%20Adapter.ps1 | iex"' }
							'12' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/8%20Advanced/12%20Start%20Search%20Shell.ps1 | iex"' }
							'R' { $exitSubMenu = $true; $skipPause = $true }
				            
							'S' { @( 'https://github.com/asheroto/UninstallOneDrive' ,'https://github.com/he3als/EdgeRemover' ,'https://github.com/ShadowWhisperer/Remove-MS-Edge' ,'https://github.com/zoicware/RemoveWindowsAI/tree/main' ) | ForEach-Object { Start-Process $_ } }
							default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }	
						}	
							
						if (-not $skipPause) { Press-AnyKey }
				    }
                }
				############################################################################
				4 {
					$updatesOptions = @(
						'Disable Updates','Enable Updates','Fix Updates',
						'WU Mini Tool','Insider Program','Offline Update Tutorial'
					)
					$exitSubMenu = $false   # flag
                    while (-not $exitSubMenu) {
                        Clear-Host
				        1..3 | ForEach-Object { '' }
						
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
						# Show submenu
                        Show-Menu $updatesOptions
                        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
                        Write-Host (& $c "SELECTION: ") -NoNewline
                        $appChoice = Read-Host
                        $skipPause = $false
                        Clear-Host
                        switch ($appChoice.ToUpper()) {
                            '1' { Invoke-DisableUpdates; Start-Process 'ms-settings:windowsupdate' }
                            '2' { Invoke-EnableUpdates; Start-Process 'ms-settings:windowsupdate' }
							'3' { Invoke-FixUpdates; Start-Process 'ms-settings:windowsupdate' }							
                            '4' {
								Invoke-WebRequest -Uri "https://github.com/sergiye/winUpdateMiniTool/releases/latest/download/winUpdateMiniTool.exe" -OutFile "$env:TEMP\winUpdateMiniTool.exe"
								Start-Process "$env:TEMP\winUpdateMiniTool.exe" -Wait
								# $skipPause = $true
							}						
							'5' {
								Invoke-WebRequest 'https://github.com/abbodi1406/offlineinsiderenroll/raw/refs/heads/master/OfflineInsiderEnroll.cmd' -OutFile "$env:TEMP\OfflineInsiderEnroll.cmd" -UseBasicParsing
								Start-Process -FilePath "$env:TEMP\OfflineInsiderEnroll.cmd" -Verb RunAs
							}		
							'6' { Start-Process 'https://www.youtube.com/watch?v=WyUvy4zHLkA' }

							'I' { @(
								'https://github.com/tsgrgo/windows-update-disabler', 
								'https://github.com/sergiye/winUpdateMiniTool',
								'https://github.com/abbodi1406/offlineinsiderenroll'
								) | ForEach-Object { Start-Process $_ } 
							}

                            'R' { $exitSubMenu = $true; $skipPause = $true }
                            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }
                        }
                        if (-not $skipPause) { Press-AnyKey }
                    }
				}
				############################################################################
				5 {
					$telemetryOptions = @(
						'WPD (Privacy dashboard for Windows)','O&O ShutUp10++','DoNotSpy11',
						'privacy.sexy','WindowsSpyBlocker','DNS Blocklists',
						'Portmaster','simplewall','TinyWall',
						'LibreWolf','Mullvad Browser','Tor Browser',
						'Proton VPN','',''
					)
					$exitSubMenu = $false   # flag
                    while (-not $exitSubMenu) {

						Clear-Host

				        1..3 | ForEach-Object { '' }
						
						$lines = @(
						"    ______________    ________  _____________________  __ ",
						"   /_  __/ ____/ /   / ____/  |/  / ____/_  __/ __ \ \/ / ",
						"    / / / __/ / /   / __/ / /|_/ / __/   / / / /_/ /\  /  ",
						"   / / / /___/ /___/ /___/ /  / / /___  / / / _, _/ / /   ",
						"  /_/ /_____/_____/_____/_/  /_/_____/ /_/ /_/ |_| /_/    "
						)

		                $width = [console]::WindowWidth
		                foreach($line in $lines){
		                    $pad = ($width + $line.Length) / 2
		                    Write-Host $line.PadLeft($pad) -ForegroundColor Blue
		                }
						
						1..2 | ForEach-Object { '' }

						Write-Host (& $c "You are being watched.") -ForegroundColor DarkGray
						Write-Host (& $c "Private and state-sponsored organizations are monitoring and recording your online activities.") -ForegroundColor DarkGray
						Write-Host (& $c "Use tools and privacy guides to counter global mass surveillance") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
						# Show submenu
				        $colorOptions = @{
							'O&O ShutUp10++' = 'Green'
							'privacy.sexy' = 'Red'
							'simplewall' = 'Green'
							'Proton VPN' = 'Green'
						}

						Show-Menu -Options $telemetryOptions -ColorOptions $colorOptions						

                        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
                        Write-Host (& $c "SELECTION: ") -NoNewline
                        $appChoice = Read-Host
                        $skipPause = $false
                        Clear-Host
                        switch ($appChoice.ToUpper()) {
                            '1' {
								Invoke-WPDTweaks
								Start-Process "$env:TEMP\WPD.exe"
							}
							'2' {
								Invoke-ShutUp10Tweaks
								Start-Process "$env:TEMP\OOSU10.exe"
							}
							'3'{
								Get-FileFromWeb -URL "https://pxc-coding.com/dl/donotspy11/" -File "$env:TEMP\DoNotSpy11-Setup.exe"
								Start-Process -Wait -FilePath "$env:TEMP\DoNotSpy11-Setup.exe" -ArgumentList "/VERYSILENT", "/NORESTART", "/SP-", "/SUPPRESSMSGBOXES"
								Start-Process "C:\Program Files (x86)\DoNotSpy11\DoNotSpy11.exe"	
							}
                            '4' {
								Write-Host "Installing privacy.sexy..." -ForegroundColor Green
                                $url=(Invoke-RestMethod "https://api.github.com/repos/undergroundwires/privacy.sexy/releases/latest").assets | Where-Object { $_.name -like '*.exe' } | Select-Object -First 1 -ExpandProperty browser_download_url
								$exe="$env:TEMP\privacy.sexy-Setup.exe"
								Get-FileFromWeb $url $exe
								Start-Process $exe -Arg '/s' -Wait
								$shortcut = Join-Path $env:PUBLIC 'Desktop\privacy.sexy.lnk'
    							if (Test-Path $shortcut) { Remove-Item $shortcut -Force }
								Invoke-PrivacyScript
							}
							'5' {
								Get-FileFromWeb -URL "https://github.com/crazy-max/WindowsSpyBlocker/releases/latest/download/WindowsSpyBlocker.exe" -File "$env:TEMP\WindowsSpyBlocker.exe"
								Start-Process "$env:TEMP\WindowsSpyBlocker.exe"
							}
							'6' {
								# dns block list
								Write-Host "Coming soon..." -ForegroundColor White
								Start-Sleep 3
							}
							'7' {
								Invoke-Portmaster
								Start-Process "C:\Program Files\Portmaster\portmaster.exe"
							}
							'8' {
								Invoke-Simplewall 
								Start-Process "C:\Program Files\simplewall\simplewall.exe"
							}
							'9' {
								Invoke-WebRequest -Uri "https://tinywall.pados.hu/ccount/click.php?id=4" -OutFile "$env:TEMP\TinyWall-Installer.msi"
								Start-Process -Wait -FilePath "msiexec.exe" -ArgumentList "/i", "`"$env:TEMP\TinyWall-Installer.msi`"", "/qb", "/norestart"
							}
							'10' {
								Invoke-LibreWolf
								Start-Process "C:\Program Files\LibreWolf\librewolf.exe"
							}
							'11' {
								# proton
							}
							'12' {
								# dns
							}

							'I' { @(
									'https://wpd.app/',				
									'https://www.oo-software.com/en/shutup10',
									'https://pxc-coding.com/donotspy11/',
									'https://www.privacy.sexy/',				
									'https://crazymax.dev/WindowsSpyBlocker/',
									'https://github.com/hagezi/dns-blocklists',					
									'https://github.com/safing/portmaster',					
									'https://github.com/henrypp/simplewall',
									'https://github.com/pylorak/TinyWall?tab=readme-ov-file',
									'https://mullvad.net/en/browser',
									'https://www.torproject.org/'
						
								) | ForEach-Object { Start-Process $_ } 						
							}	

                            'R' { $exitSubMenu = $true; $skipPause = $true }
                            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }
                        }
                        if (-not $skipPause) { Press-AnyKey }
                    }
				}
				############################################################################
				6 {
					$securityOptions = @(
						'Toggle Defender','Enable Defender','Remove Defender',
						'Toggle VBS','Toggle Mitigations','Toggle UAC',
						'Fix Security','Remove Security Center App','',
						'Fix The app can not run because Device Guard...'
					)
					$exitSubMenu = $false   # flag
                    while (-not $exitSubMenu) {
                        Clear-Host
				        1..3 | ForEach-Object { '' }
						
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
				        # Show submenu
				        $colorOptions = @{ 'Toggle UAC' = 'Green'; 'Remove Security Center App' = 'Red'; 'Remove Defender' = 'Red' }
						Show-Menu -Options $securityOptions -ColorOptions $colorOptions						

                        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
                        Write-Host (& $c "SELECTION: ") -NoNewline
                        $appChoice = Read-Host
                        $skipPause = $false
                        Clear-Host
                        switch ($appChoice.ToUpper()) {
                            '1' {  
								$folder = Join-Path $env:USERPROFILE "Desktop\AchillesScript"
								New-Item -ItemType Directory -Path $folder -Force | Out-Null
								$dest = Join-Path $folder "AchillesScript.cmd"
								Invoke-WebRequest -Uri "https://github.com/lostzombie/AchillesScript/raw/refs/heads/main/AchillesScript.cmd" -OutFile $dest -UseBasicParsing
								Write-Host "Downloaded to: $dest"
								Start-Process "$dest"
							}
							'2' { Invoke-EnableDefender }
							'3' { Invoke-DefenderRemover }
							'4' { Invoke-ToggleVBS }
							'5' { 
								Invoke-WebRequest -Uri "https://www.grc.com/files/InSpectre.exe" -OutFile "$env:TEMP\InSpectre.exe"
								Start-Process "$env:TEMP\InSpectre.exe"
							}
							'6' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/8%20Advanced/8%20UAC.ps1 | iex"' }
							'7' { Invoke-FixWinSecurity; Invoke-EnableUAC }
                            '8' { Invoke-RemWinSecurityApp }
							'9' { }							
							'10' { Invoke-RemWinDefenderAppGuardPolicies }
							'R' { $exitSubMenu = $true; $skipPause = $true }
                            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }
                        }
                        if (-not $skipPause) { Press-AnyKey }
                    }					
				}
				############################################################################
				7 {
					$servicesOptions = @('Disable Unnecessary Services','Minimal Services','Default Services')
					$exitSubMenu = $false   # flag
                    while (-not $exitSubMenu) {
                        Clear-Host
				        1..3 | ForEach-Object { '' }
						
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
						# Show submenu
                        Show-Menu $servicesOptions
                        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
                        Write-Host (& $c "SELECTION: ") -NoNewline
                        $appChoice = Read-Host
                        $skipPause = $false
                        Clear-Host
                        switch ($appChoice.ToUpper()) {
                            '1' { Invoke-DisableServices }
                            '2' { Invoke-MinimalServices }
							'3' { Invoke-EnableServices } 
                            'R' { $exitSubMenu = $true; $skipPause = $true }
                            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }
                        }
                        if (-not $skipPause) { Press-AnyKey }
                    }
				}
				############################################################################
				8 {
					$registryOptions = @('Optimize Registry','Default Registry')
					$exitSubMenu = $false   # flag
                    while (-not $exitSubMenu) {
                        Clear-Host
				        1..3 | ForEach-Object { '' }
						
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
						# Show submenu
                        Show-Menu $registryOptions
                        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
                        Write-Host (& $c "SELECTION: ") -NoNewline
                        $appChoice = Read-Host
                        $skipPause = $false
                        Clear-Host
                        switch ($appChoice.ToUpper()) {
                            '1' { Invoke-OptimizeRegistry; Invoke-PauseUpdates }
                            '2' { Invoke-DefaultReg }

                            'R' { $exitSubMenu = $true; $skipPause = $true }
                            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }
                        }
                        if (-not $skipPause) { Press-AnyKey }
                    }					
				}
				############################################################################
				9 {
				}
				############################################################################
				10 {
					$appsOptions = @(
						'C++','.NET','DirectX',
						'Brave','Firefox','Chrome',
						'Start(X)Back','Everything','7-Zip',
						'NanaZip','VLC media player','SpotX (Spotify)',
						'Powershell 7','UniGetUI','Winget',
						'Chocolatey','WebCord (Discord)','Steam',
						'Process Explorer','Core Temp','Notepad++',
						'Microsoft 365'
					)
					$exitSubMenu = $false   # flag
                    while (-not $exitSubMenu) {
                        Clear-Host
				        1..3 | ForEach-Object { '' }
						
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
						
				        # Show submenu
				        $colorOptions = @{ 'C++' = 'Green'; 'Brave' = 'Green'; 'SpotX (Spotify)' = 'Red'}
						Show-Menu -Options $appsOptions -ColorOptions $colorOptions						
					
					    Write-Host (& $c "Enter one or multiple numbers or letters separated by commas") -ForegroundColor Cyan
					    Write-Host (& $c "SELECTION: ") -NoNewline
					    $appChoice = Read-Host
					
					    # Split multiple selections
					    $appChoices = $appChoice -split ',' | ForEach-Object { $_.Trim().ToUpper() }
					    $skipPause = $false
						Clear-Host
					
						foreach ($choice in $appChoices) {
						if ([int]::TryParse($choice,[ref]$null)) {
					    	# Numeric selection
					    	$aSel = [int]$choice
					    	switch ($aSel) {
								'1' { Invoke-CPlusPlusAIO }
                            	'2' { Invoke-NETFreamework35; Invoke-NETDesktopAIO }
								'3' { Invoke-DirectX }
								'4' { Invoke-Brave; Invoke-DebloatBrave }
								'5' { Invoke-Firefox }
								'6' { Invoke-Chrome }
								'7' { Invoke-StartXBack }
								'8' { Invoke-EverythingSearch }
								'9' { Invoke-7Zip }
								'10' { Invoke-NanaZip }
								'11' { Invoke-VLC }
								'12' { Invoke-SpotX }
								'13' { Invoke-Powershell7 }
								'14' { Invoke-UniGetUI }
								'15' { Invoke-Winget }
								'16' {  }
								'17' { Invoke-WebCord }
								'18' { Invoke-Steam }
								'19' { Invoke-ProcessExplorer }
								'20' { Invoke-CoreTemp }
								'21' { Invoke-NotepadPlusPlus }
								'22' { Invoke-Office365 }													
									
					            default {
					                Write-Host "Invalid number: $aSel" -ForegroundColor White -BackgroundColor Red
					                Start-Sleep 2
					                $skipPause = $true
					            }
					        }
					    }
							
					    else {
					        # Letter selection
					        switch ($choice) {
					            'R' { $exitSubMenu = $true; $skipPause = $true } # Return to Main Menu
					            default {
					                Write-Host "Invalid letter: $choice" -ForegroundColor White -BackgroundColor Red
					                Start-Sleep 2
					                $skipPause = $true
					            }
					        }
					    }
					}
					
					if (-not $skipPause) { Press-AnyKey }
					}
				}
				############################################################################
				11 {		

					clear-host

					$tuningOptions = @(
						'ThrottleStop','Process Lasso','CPU Unpark',
						'MSI Mode','MSI Afterburner','Timer Res','Reduce Audio Latency',
						'GoInterruptPolicy','Custom Resolution Utility','Fan Control',
						'TCP Optimizer','DNS Jumper','Win32Prior Tool',
						'PowerSettingsExplorer','NVIDIA Profile Inspector'
					)

					$exitSubMenu = $false
					while (-not $exitSubMenu) {
					    Clear-Host
				        1..3 | ForEach-Object { '' }
					    	
						$lines = @(
							"  ________  ___   _______   ________",
							" /_  __/ / / / | / /  _/ | / / ____/",
							"  / / / / / /  |/ // //  |/ / / __  ",
							" / / / /_/ / /|  // // /|  / /_/ /  ",
							"/_/  \____/_/ |_/___/_/ |_/\____/   "
						)
                        
				        $width = [console]::WindowWidth
				        foreach($line in $lines){
				            $pad = ($width + $line.Length) / 2
				            Write-Host $line.PadLeft($pad)
				        }
				        
						1..3 | ForEach-Object { '' }
						Write-Host (& $c "A bunch of registry tweaks.") -ForegroundColor DarkGray
						
				        1..2 | ForEach-Object { '' }
				    
				        Show-Menu $tuningOptions
				    
				        Write-Host (& $c "Enter a number to select an option") -ForegroundColor Cyan
				        Write-Host (& $c "SELECTION: ") -NoNewline
				        $appChoice = Read-Host
						$skipPause = $false
						Clear-Host
						switch ($appChoice.ToUpper()) {
							'1' { Get-FileFromWeb -URL "https://geeks3d.com/dl/get/10061" -File "$env:TEMP\ThrottleStop.zip"; $dst="$env:TEMP\ThrottleStop"; if(Test-Path $dst){Remove-Item $dst -Recurse -Force -ErrorAction SilentlyContinue}; Expand-Archive "$env:TEMP\ThrottleStop.zip" $dst -Force; $exe=Get-ChildItem $dst -Recurse -Filter "ThrottleStop.exe" -ErrorAction SilentlyContinue | Select-Object -First 1; if($exe){ Start-Process $exe.FullName } }
							'2' { Install-ProcessLasso }
				            '3' { Get-FileFromWeb -URL "https://www.coderbag.com/assets/downloads/disable-cpu-core-parking/Unpark-CPU-App.zip" -File "$env:TEMP\Unpark-CPU-App.zip"; $dst="$env:TEMP\Unpark-CPU-App"; if(Test-Path $dst){Remove-Item $dst -Recurse -Force -ErrorAction SilentlyContinue}; Expand-Archive "$env:TEMP\Unpark-CPU-App.zip" $dst -Force; $exe=Join-Path $dst "UnparkCpu.exe"; if(Test-Path $exe){ Start-Process $exe } }
				            '4' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/5%20Graphics/9%20Msi%20Mode.ps1 | iex"' }
				            '5' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/4%20Installers/3%20MSI%20Afterburner.ps1 | iex"' }
							'6' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/6%20Windows/10%20Timer%20Resolution.ps1 | iex"' }
				            '7' { Invoke-WebRequest -Uri "https://github.com/sherifmagdy32/gaming_os_tweaker/raw/refs/heads/main/scripts/tweaks/audio.cmd" -OutFile "$env:TEMP\audio.cmd"; Start-Process "$env:TEMP\audio.cmd"; Invoke-WebRequest -Uri "https://github.com/miniant-git/REAL/releases/download/updater-v2/REAL.exe" -OutFile "$env:TEMP\REAL.exe"; Start-Process "$env:TEMP\REAL.exe"}
				            '8' { Get-FileFromWeb -URL "https://github.com/spddl/GoInterruptPolicy/releases/latest/download/GoInterruptPolicy.exe" -File "$env:TEMP\GoInterruptPolicy.exe"; Start-Process "$env:TEMP\GoInterruptPolicy.exe" }	
							'9' { Get-FileFromWeb -URL "https://www.monitortests.com/download/cru/cru-1.5.3.zip" -File "$env:TEMP\cru.zip"; Expand-Archive "$env:TEMP\cru.zip" -DestinationPath "$env:TEMP" -Force; Start-Process "$env:TEMP\CRU.exe" }
							'10' { $rel=Invoke-RestMethod "https://api.github.com/repos/Rem0o/FanControl.Releases/releases/latest"; $asset=$rel.assets | Where-Object { $_.name -match '_net_4_8_Installer\.exe$' } | Select-Object -First 1; if($asset){ $exe=Join-Path $env:TEMP $asset.name; Invoke-WebRequest $asset.browser_download_url -OutFile $exe -UseBasicParsing; Start-Process -FilePath $exe -ArgumentList '/verysilent' -Wait; $fc1="C:\Program Files (x86)\FanControl\FanControl.exe"; $fc2="C:\Program Files\FanControl\FanControl.exe"; if(Test-Path $fc1){ Start-Process $fc1 } elseif(Test-Path $fc2){ Start-Process $fc2 } } }
							'11' { Get-FileFromWeb -URL "https://www.speedguide.net/files/TCPOptimizer.exe" -File "$env:TEMP\TCPOptimizer.exe"; Start-Process "$env:TEMP\TCPOptimizer.exe" }
							'12' { Get-FileFromWeb -URL "https://www.sordum.org/files/downloads.php?dns-jumper" -File "$env:TEMP\DnsJumper.zip"; $dst="$env:TEMP\DnsJumper"; if(Test-Path $dst){Remove-Item $dst -Recurse -Force -ErrorAction SilentlyContinue}; Expand-Archive "$env:TEMP\DnsJumper.zip" $dst -Force; $exe=Join-Path $dst "DnsJumper\DnsJumper.exe"; if(Test-Path $exe){ Start-Process $exe } }
							'13' { $url=(Invoke-RestMethod "https://api.github.com/repos/keoy7am/Win32PrioritySeparationTool/releases/latest").assets | Where-Object name -like '*.zip' | Select-Object -f 1 -exp browser_download_url; $zip="$env:TEMP\Win32PrioritySeparationTool.zip"; Invoke-WebRequest $url -OutFile $zip; Expand-Archive $zip -DestinationPath $env:TEMP -Force; Start-Process "$env:TEMP\Win32PrioritySeparationTool.exe" }
							'14' { Invoke-WebRequest -Uri "https://github.com/ManueITest/Windows/raw/refs/heads/main/PowerSettingsExplorer.exe" -OutFile "$env:TEMP\PowerSettingsExplorer.exe"; Start-Process "$env:TEMP\PowerSettingsExplorer.exe" }
							'15' { Start-Process powershell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command "irm https://github.com/FR33THYFR33THY/Ultimate-Windows-Optimization-Guide/raw/refs/heads/main/5%20Graphics/5%20Nvidia%20Settings.ps1 | iex"' }
							
							'I' { @( '', '' ,'https://github.com/keoy7am/Win32PrioritySeparationTool' ) | ForEach-Object { Start-Process $_ } }
							'R' { $exitSubMenu = $true; $skipPause = $true }
				            default { Write-Host "INVALID SELECTION!" -ForegroundColor White -BackgroundColor Red; Start-Sleep 3; $skipPause = $true }	
						}	
						if (-not $skipPause) { Press-AnyKey }
				    }						
				}								
                #############################################################
                default {
                    Write-Host "Invalid option." -ForegroundColor Red
                    Start-Sleep 1
                }
            }
        } else {
            Write-Host "Invalid number: $choice" -ForegroundColor Red
            Start-Sleep 1
        }
    }
    elseif ($choice -match '^[A-Za-z]$') {
        switch ($choice.ToUpper()) {
            'R' { break } # Return/Exit
            default { Write-Host "Invalid letter: $choice" -ForegroundColor Red; Start-Sleep 1 }
        }
    }
    else {
        Write-Host "Invalid input: $choice" -ForegroundColor Red
        Start-Sleep 1
    }
}