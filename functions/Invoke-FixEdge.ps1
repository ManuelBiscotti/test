############
# Fix Edge #
function Invoke-FixEdge {
	<#
		.LINK
		https://github.com/he3als/EdgeRemover
	#>

	Write-Host "Fixing Microsoft Edge..." -ForegroundColor Green

	# Clear Edge Blocks
	Write-Output "Clearing Edge Blocks..." 
	Invoke-Expression "&{$(Invoke-RestMethod https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1)} -ClearUpdateBlocks"
	
	# Configure Edge
	Write-Output "Configuring Edge..."
	$batchCode = @'
@echo off
:: https://privacy.sexy — v0.13.8 — Sun, 19 Oct 2025 08:43:23 GMT
:: Initialize environment
setlocal EnableExtensions DisableDelayedExpansion


:: ----------------------------------------------------------
:: -----Disable Edge automatic update services (revert)------
:: ----------------------------------------------------------
echo --- Disable Edge automatic update services (revert)
:: Restore service(s) to default state: `edgeupdate`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'edgeupdate'; $defaultStartupMode = 'Automatic'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: Restore service(s) to default state: `edgeupdatem`
PowerShell -ExecutionPolicy Unrestricted -Command "$serviceName = 'edgeupdatem'; $defaultStartupMode = 'Manual'; $ignoreMissingOnRevert =  $false; Write-Host "^""Reverting service `"^""$serviceName`"^"" start to `"^""$defaultStartupMode`"^""."^""; <# -- 1. Skip if service does not exist #>; $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue; if (!$service) { if ($ignoreMissingOnRevert) { Write-Output "^""Skipping: The service `"^""$serviceName`"^"" is not found. No action required."^""; Exit 0; }; Write-Warning "^""Failed to revert changes to the service `"^""$serviceName`"^"". The service is not found."^""; Exit 1; }; <# -- 2. Enable or skip if already enabled #>; $startupType = $service.StartType <# Does not work before .NET 4.6.1 #>; if (!$startupType) { $startupType = (Get-WmiObject -Query "^""Select StartMode From Win32_Service Where Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; if (!$startupType) { $startupType = (Get-WmiObject -Class Win32_Service -Property StartMode -Filter "^""Name='$serviceName'"^"" -ErrorAction Ignore).StartMode; }; }; if ($startupType -eq "^""$defaultStartupMode"^"") { Write-Host "^""`"^""$serviceName`"^"" has already expected startup mode: `"^""$defaultStartupMode`"^"". No action required."^""; } else { try { Set-Service -Name "^""$serviceName"^"" -StartupType "^""$defaultStartupMode"^"" -Confirm:$false -ErrorAction Stop; Write-Host "^""Reverted `"^""$serviceName`"^"" with `"^""$defaultStartupMode`"^"" start, this may require restarting your computer."^""; } catch { Write-Error "^""Failed to enable `"^""$serviceName`"^"": $_"^""; Exit 1; }; }; <# -- 4. Start if not running (must be enabled first) #>; if ($defaultStartupMode -eq 'Automatic' -or $defaultStartupMode -eq 'Boot' -or $defaultStartupMode -eq 'System') { if ($service.Status -ne [System.ServiceProcess.ServiceControllerStatus]::Running) { Write-Host "^""`"^""$serviceName`"^"" is not running, starting it."^""; try { Start-Service $serviceName -ErrorAction Stop; Write-Host "^""Started `"^""$serviceName`"^"" successfully."^""; } catch { Write-Warning "^""Failed to start `"^""$serviceName`"^"", requires restart, it will be started after reboot.`r`n$_"^""; }; } else { Write-Host "^""`"^""$serviceName`"^"" is already running, no need to start."^""; }; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: --Disable Edge automatic update scheduled tasks (revert)--
:: ----------------------------------------------------------
echo --- Disable Edge automatic update scheduled tasks (revert)
:: Restore scheduled task(s) to default state: `\MicrosoftEdgeUpdateTaskMachineCore{*}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='MicrosoftEdgeUpdateTaskMachineCore{*}'; $shouldDisable =  $false; Write-Output "^""Enabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Warning ( "^""Missing task: Cannot enable, no tasks matching pattern `"^""$taskNamePattern`"^"" found."^"" + "^"" This task appears to be not included in this version of Windows."^"" ); exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($shouldDisable) { if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; } else { if (($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) -and ($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Unknown)) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already enabled, no action needed."^""; continue; }; }; try { if ($shouldDisable) { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } else { $task | Enable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully enabled task `"^""$taskName`"^""."^""; }; } catch { Write-Error "^""Failed to restore task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to restore some tasks. Check error messages above.'; exit 1; }"
:: Restore scheduled task(s) to default state: `\MicrosoftEdgeUpdateTaskMachineUA{*}`
PowerShell -ExecutionPolicy Unrestricted -Command "$taskPathPattern='\'; $taskNamePattern='MicrosoftEdgeUpdateTaskMachineUA{*}'; $shouldDisable =  $false; Write-Output "^""Enabling tasks matching pattern `"^""$taskNamePattern`"^""."^""; $tasks = @(Get-ScheduledTask -TaskPath $taskPathPattern -TaskName $taskNamePattern -ErrorAction Ignore); if (-Not $tasks) { Write-Warning ( "^""Missing task: Cannot enable, no tasks matching pattern `"^""$taskNamePattern`"^"" found."^"" + "^"" This task appears to be not included in this version of Windows."^"" ); exit 0; }; $operationFailed = $false; foreach ($task in $tasks) { $taskName = $task.TaskName; if ($shouldDisable) { if ($task.State -eq [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already disabled, no action needed."^""; continue; }; } else { if (($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Disabled) -and ($task.State -ne [Microsoft.PowerShell.Cmdletization.GeneratedTypes.ScheduledTask.StateEnum]::Unknown)) { Write-Output "^""Skipping, task `"^""$taskName`"^"" is already enabled, no action needed."^""; continue; }; }; try { if ($shouldDisable) { $task | Disable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully disabled task `"^""$taskName`"^""."^""; } else { $task | Enable-ScheduledTask -ErrorAction Stop | Out-Null; Write-Output "^""Successfully enabled task `"^""$taskName`"^""."^""; }; } catch { Write-Error "^""Failed to restore task `"^""$taskName`"^"": $($_.Exception.Message)"^""; $operationFailed = $true; }; }; if ($operationFailed) { Write-Output 'Failed to restore some tasks. Check error messages above.'; exit 1; }"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ---------Disable Edge update executable (revert)----------
:: ----------------------------------------------------------
echo --- Disable Edge update executable (revert)
:: Remove configuration preventing "MicrosoftEdgeUpdate.exe" from starting
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe!Debugger"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\MicrosoftEdgeUpdate.exe' /v 'Debugger' /f 2>$null"
:: Remove the rule that prevents the executable "MicrosoftEdgeUpdate.exe" from running via File Explorer
PowerShell -ExecutionPolicy Unrestricted -Command "$executableFilename='MicrosoftEdgeUpdate.exe'; try { $blockEntries = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if (-Not $blockEntries) { Write-Output "^""Skipping, no action needed: No block rules exist, `"^""$executableFilename`"^"" is not blocked."^""; exit 0; }; $blockingRulesForExecutable = @(; $blockEntries.PSObject.Properties | Where-Object { $_.Value -eq $executableFilename }; ); if (-Not $blockingRulesForExecutable) { Write-Output "^""Skipping, no action needed: `"^""$executableFilename`"^"" is not currently blocked."^""; exit 0; }; foreach ($blockingRuleForExecutable in $blockingRulesForExecutable) { $blockingRuleIndexForExecutable = $blockingRuleForExecutable.Name; Write-Output "^""Removing rule `"^""$blockingRuleIndexForExecutable`"^"" that blocks `"^""$executableFilename`"^""."^""; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -Name "^""$blockingRuleIndexForExecutable"^"" -Force -ErrorAction Stop; Write-Output "^""Successfully revoked blocking of `$executableFilename` under rule `"^""$blockingRuleIndexForExecutable`"^""."^""; }; } catch { Write-Error "^""Failed to revoke blocking of `"^""$executableFilename`"^"": $_"^""; Exit 1; }"
:: Restore the File Explorer DisallowRun policy if no other blocks are active
PowerShell -ExecutionPolicy Unrestricted -Command "try { $currentDisallowRunPolicyValue = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -ErrorAction Ignore | Select-Object -ExpandProperty 'DisallowRun'; if ([string]::IsNullOrEmpty($currentDisallowRunPolicyValue)) { Write-Output 'Skipping, no action needed: DisallowRun policy is not active.'; Exit 0; }; if ($currentDisallowRunPolicyValue -ne 1) { Write-Output "^""Skipping, DisallowRun policy is not configured by privacy.sexy, unexpected value: `"^""$currentDisallowRunPolicyValue`"^""."^""; Exit 0; }; $remainingBlockingRules = Get-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun' -ErrorAction Ignore; if ($remainingBlockingRules) { Write-Output 'Skipping deactivating DisallowRun policy, there are still active rules.'; Exit 0; }; Write-Output 'No remaining rules, deleting DisallowRun policy.'; Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' -Name 'DisallowRun' -Force -ErrorAction Stop; Write-Output 'Successfully restored DisallowRun policy.'; } catch { Write-Error "^""Failed to restore DisallowRun policy: $_"^""; Exit 1; }"
:: Restore files matching pattern: "%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe"  
PowerShell -ExecutionPolicy Unrestricted -Command "$revert = $true; $pathGlobPattern = "^""%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate\MicrosoftEdgeUpdate.exe.OLD"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); try { $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] { <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) { Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) { if (Test-Path -Path $path -PathType Container) { Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) { if (-not $path.EndsWith('.OLD')) { Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else { if ($path.EndsWith('.OLD')) { Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) { Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) { $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else { $newFilePath = "^""$($originalFilePath).OLD"^""; }; try { Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch { Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) { Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) { Write-Warning "^""Failed to process $($failedCount) items."^""; }"
:: Restore files matching pattern: "%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate\*\MicrosoftEdgeUpdate.exe"  
PowerShell -ExecutionPolicy Unrestricted -Command "$revert = $true; $pathGlobPattern = "^""%PROGRAMFILES(x86)%\Microsoft\EdgeUpdate\*\MicrosoftEdgeUpdate.exe.OLD"^""; $expandedPath = [System.Environment]::ExpandEnvironmentVariables($pathGlobPattern); Write-Host "^""Searching for items matching pattern: `"^""$($expandedPath)`"^""."^""; $renamedCount   = 0; $skippedCount   = 0; $failedCount    = 0; $foundAbsolutePaths = @(); try { $foundAbsolutePaths += @(; Get-Item -Path $expandedPath -ErrorAction Stop | Select-Object -ExpandProperty FullName; ); } catch [System.Management.Automation.ItemNotFoundException] { <# Swallow, do not run `Test-Path` before, it's unreliable for globs requiring extra permissions #>; }; $foundAbsolutePaths = $foundAbsolutePaths | Select-Object -Unique | Sort-Object -Property { $_.Length } -Descending; if (!$foundAbsolutePaths) { Write-Host 'Skipping, no items available.'; exit 0; }; Write-Host "^""Initiating processing of $($foundAbsolutePaths.Count) items from `"^""$expandedPath`"^""."^""; foreach ($path in $foundAbsolutePaths) { if (Test-Path -Path $path -PathType Container) { Write-Host "^""Skipping folder (not its contents): `"^""$path`"^""."^""; $skippedCount++; continue; }; if($revert -eq $true) { if (-not $path.EndsWith('.OLD')) { Write-Host "^""Skipping non-backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; } else { if ($path.EndsWith('.OLD')) { Write-Host "^""Skipping backup file: `"^""$path`"^""."^""; $skippedCount++; continue; }; }; $originalFilePath = $path; Write-Host "^""Processing file: `"^""$originalFilePath`"^""."^""; if (-Not (Test-Path $originalFilePath)) { Write-Host "^""Skipping, file `"^""$originalFilePath`"^"" not found."^""; $skippedCount++; exit 0; }; if ($revert -eq $true) { $newFilePath = $originalFilePath.Substring(0, $originalFilePath.Length - 4); } else { $newFilePath = "^""$($originalFilePath).OLD"^""; }; try { Move-Item -LiteralPath "^""$($originalFilePath)"^"" -Destination "^""$newFilePath"^"" -Force -ErrorAction Stop; Write-Host "^""Successfully processed `"^""$originalFilePath`"^""."^""; $renamedCount++; } catch { Write-Error "^""Failed to rename `"^""$originalFilePath`"^"" to `"^""$newFilePath`"^"": $($_.Exception.Message)"^""; $failedCount++; }; }; if (($renamedCount -gt 0) -or ($skippedCount -gt 0)) { Write-Host "^""Successfully processed $renamedCount items and skipped $skippedCount items."^""; }; if ($failedCount -gt 0) { Write-Warning "^""Failed to process $($failedCount) items."^""; }"
:: ----------------------------------------------------------


:: Disable Edge automatic updates across all channels (revert)
echo --- Disable Edge automatic updates across all channels (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!UpdateDefault"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'UpdateDefault' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Update{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Update{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Update{65C35B14-6C1D-4122-AC46-7148CC9D6497}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Update{65C35B14-6C1D-4122-AC46-7148CC9D6497}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Update{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Update{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Update{F3C4FE00-EFD5-403B-9569-398A20F1BA4A}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Update{F3C4FE00-EFD5-403B-9569-398A20F1BA4A}' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Disable Edge WebView and WebView2 updates (revert)----
:: ----------------------------------------------------------
echo --- Disable Edge WebView and WebView2 updates (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Update{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Update{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ------Disable Edge automatic update checks (revert)-------
:: ----------------------------------------------------------
echo --- Disable Edge automatic update checks (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!AutoUpdateCheckPeriodMinutes"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'AutoUpdateCheckPeriodMinutes' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: ----Maximize Edge update suppression duration (revert)----
:: ----------------------------------------------------------
echo --- Maximize Edge update suppression duration (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!UpdatesSuppressedDurationMin"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'UpdatesSuppressedDurationMin' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!UpdatesSuppressedStartHour"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'UpdatesSuppressedStartHour' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!UpdatesSuppressedStartMin"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'UpdatesSuppressedStartMin' /f 2>$null"
:: ----------------------------------------------------------


:: ----------------------------------------------------------
:: -----Disable automatic installation of Edge (revert)------
:: ----------------------------------------------------------
echo --- Disable automatic installation of Edge (revert)
:: Delete the registry value "HKLM\SOFTWARE\Microsoft\EdgeUpdate!DoNotUpdateToEdgeWithChromium"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Microsoft\EdgeUpdate' /v 'DoNotUpdateToEdgeWithChromium' /f 2>$null"
:: ----------------------------------------------------------


:: Disable automatic installation of Edge across all channels (revert)
echo --- Disable automatic installation of Edge across all channels (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!InstallDefault"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'InstallDefault' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Install{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Install{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Install{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Install{2CD8A007-E189-409D-A2C8-9AF4EF3C72AA}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Install{65C35B14-6C1D-4122-AC46-7148CC9D6497}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Install{65C35B14-6C1D-4122-AC46-7148CC9D6497}' /f 2>$null"
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Install{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Install{0D50BFEC-CD6A-4F9A-964C-C7416E3ACB10}' /f 2>$null"
:: ----------------------------------------------------------


:: Disable automatic installation of WebView and WebView2 (revert)
echo --- Disable automatic installation of WebView and WebView2 (revert)
:: Delete the registry value "HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate!Install{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}"
PowerShell -ExecutionPolicy Unrestricted -Command "reg delete 'HKLM\SOFTWARE\Policies\Microsoft\EdgeUpdate' /v 'Install{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}' /f 2>$null"
:: ----------------------------------------------------------


:: Restore previous environment settings
endlocal
'@

	$batPath = "$env:TEMP\ConfigureEdge.bat"
	Set-Content -Path $batPath -Value $batchCode -Encoding ASCII
	Start-Process -FilePath $batPath -Wait -NoNewWindow *> $null

	<#
	# Install Edge
	$temp = "$env:TEMP\EdgeRemover.ps1"
	Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/gh/he3als/EdgeRemover@main/get.ps1" -OutFile $temp -UseBasicParsing
	Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$temp`" -InstallEdge -InstallWebView -NonInteractive" -Wait
	#>

	# stop edge running
	$stop = "MicrosoftEdgeUpdate", "OneDrive", "WidgetService", "Widgets", "msedge", "Resume", "CrossDeviceResume", "msedgewebview2"
	$stop | ForEach-Object { Stop-Process -Name $_ -Force -ErrorAction SilentlyContinue }
	# install copilot
	Get-AppXPackage -AllUsers *Microsoft.Windows.Ai.Copilot.Provider* | ForEach-Object-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	# enable edge updates regedit
	cmd /c "reg delete `"HKLM\SOFTWARE\Microsoft\EdgeUpdate`" /f >nul 2>&1"
	# remove allow edge uninstall regedit
	cmd /c "reg delete `"HKLM\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdateDev`" /f >nul 2>&1"
	# download edge installer
	Get-FileFromWeb -URL "https://go.microsoft.com/fwlink/?linkid=2109047&Channel=Stable&language=en&brand=M100" -File "$env:TEMP\Edge.exe"
	# start edge installer
	Start-Process -wait "$env:TEMP\Edge.exe"
	# stop edge running
	$stop = "MicrosoftEdgeUpdate", "OneDrive", "WidgetService", "Widgets", "msedge", "Resume", "CrossDeviceResume", "msedgewebview2"
	$stop | ForEach-Object { Stop-Process -Name $_ -Force -ErrorAction SilentlyContinue }
	# download edge webview installer
	Get-FileFromWeb -URL "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/304fddef-b073-4e0a-b1ff-c2ea02584017/MicrosoftEdgeWebview2Setup.exe" -File "$env:TEMP\EdgeWebView.exe"
	# start edge webview installer
	Start-Process -wait "$env:TEMP\EdgeWebView.exe"
	# stop edge running
	$stop = "MicrosoftEdgeUpdate", "OneDrive", "WidgetService", "Widgets", "msedge", "msedgewebview2"
	$stop | ForEach-Object { Stop-Process -Name $_ -Force -ErrorAction SilentlyContinue }
	# add edge shortcuts
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:SystemDrive\Windows\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk")
	$Shortcut.TargetPath = "$env:SystemDrive\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	$Shortcut.Save()
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge.lnk")
	$Shortcut.TargetPath = "$env:SystemDrive\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	$Shortcut.Save()
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge.lnk")
	$Shortcut.TargetPath = "$env:SystemDrive\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	$Shortcut.Save()
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Tombstones\Microsoft Edge.lnk")
	$Shortcut.TargetPath = "$env:SystemDrive\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	$Shortcut.Save()
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Edge.lnk")
	$Shortcut.TargetPath = "$env:SystemDrive\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	$Shortcut.Save()
	$WshShell = New-Object -comObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$env:SystemDrive\Users\Public\Desktop\Microsoft Edge.lnk")
	$Shortcut.TargetPath = "$env:SystemDrive\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
	$Shortcut.Save()
	# install uwp edge & bing apps
	Get-AppXPackage -AllUsers *Microsoft.MicrosoftEdge.Stable* | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppXPackage -AllUsers *Microsoft.BingNews* | ForEach-Object-Object {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppXPackage -AllUsers *Microsoft.BingSearch* | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}
	Get-AppXPackage -AllUsers *Microsoft.BingWeather* | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}

}