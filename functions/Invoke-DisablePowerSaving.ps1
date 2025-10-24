<#
.SYNOPSIS
	DISABLE POWER SAVING
#>
function Invoke-DisablePowerSaving {
	param (
		[switch]$Silent
	)
	
	if (!$Silent) {
		$isLaptop = (Get-CimInstance -Class Win32_ComputerSystem -Property PCSystemType).PCSystemType -eq 2
		if ($isLaptop) {
			Write-Host @"
	WARNING: You are on a laptop, disabling power saving will cause faster battery drainage and increased heat output.
	If you use your laptop on battery, certain power saving features will enable, but not all.
	Generally, it's NOT recommended to run this script on laptops.`n 
"@ -ForegroundColor Red
			Start-Sleep 3
			# Enable High Performance Power Plan
			cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v HighPerformance /t REG_DWORD /d 1 /f >nul 2>&1"
		}
	}

	Write-Host "Disabling Power Saving Features..." -ForegroundColor Green
	# DISABLE CPU POWER SAVING
 	# Disable power throttling
	Write-Output "Disabling Power Throttling..."
	$powerKey = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling"	
	if (!(Test-Path $powerKey)) { New-Item $powerKey | Out-Null }
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -PropertyType DWORD -Force | Out-Null	
	# Disable processor throttle states to prevent CPU frequency reduction
	powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb 0
	# Set processor performance time check interval to 200 milliseconds for optimized DPC management
	# This setting reduces deferred procedure calls and can be increased to 5000ms for statically clocked systems
	powercfg /setacvalueindex scheme_current 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 200	
	# Force all CPU cores to remain unparked for maximum responsiveness
	Write-Output "Disabling CPU Core Parking..."
	cmd /c "reg add `"HKLM\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583`" /v `"ValueMax`" /t REG_DWORD /d `"0`" /f >nul 2>&1"	
	# Disable dynamic tick
	Write-Output "Disabling Dynamic Tick..."
	bcdedit /set disabledynamictick yes | Out-Null
	# Enable platform tick use the platform timer (usually HPET)
	Write-Output "Enabling Platform Tick..."
	bcdedit /set useplatformtick yes | Out-Null

	# DISABLE SLEEP
	Write-Output "Disabling Sleep..."
	# Disable system hibernation feature to free up disk space and improve system performance
	Write-Output "Disabling Hibernation..."
	powercfg /hibernate off
	# Disable hibernation functionality through registry setting to prevent system from entering hibernate state
	cmd /c "reg add `"HKLM\SYSTEM\CurrentControlSet\Control\Power`" /v `"HibernateEnabled`" /t REG_DWORD /d `"0`" /f >nul 2>&1"
	# Set default hibernation state to disabled in registry to ensure hibernation remains off after system changes
	cmd /c "reg add `"HKLM\SYSTEM\CurrentControlSet\Control\Power`" /v `"HibernateEnabledDefault`" /t REG_DWORD /d `"0`" /f >nul 2>&1"
	# Disable Windows Fast Startup to ensure clean system initialization on boot
	Write-Output "Disabling Fast Startup..."
	cmd /c "reg add `"HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power`" /v `"HiberbootEnabled`" /t REG_DWORD /d `"0`" /f >nul 2>&1"

	# DISABLE DEVICE POWER SAVING
	# DISPLAY
	Write-Output "Disabling Display Power Saving..."
	# Disable automatic display dimming feature to maintain consistent screen brightness at all times
	powercfg /setacvalueindex scheme_current 7516b95f-f776-4464-8c53-06167f40cc99 17aaa29b-8b43-4b94-aafe-35f64daaf1ee 0
	# Disable automatic display turn-off to keep screen active indefinitely for uninterrupted workflow
	powercfg /setacvalueindex scheme_current 7516b95f-f776-4464-8c53-06167f40cc99 3c0bc021-c8a8-4e07-a973-6b14cbcb2b7e 0
	# NVME
	Write-Output "Disabling NVME Power Saving..."
	# Configure secondary NVMe drive idle timeout to 0 milliseconds
	powercfg /setacvalueindex scheme_current 0012ee47-9041-4b5d-9b77-535fba8b1442 d3d55efd-c1ff-424e-9dc3-441be7833010 0
	# Configure primary NVMe drive idle timeout to 0 milliseconds to prevent drive sleep states
	powercfg /setacvalueindex scheme_current 0012ee47-9041-4b5d-9b77-535fba8b1442 d639518a-e56d-4345-8af2-b9f32fb26109 0
	# Disable NVMe NOPPME (Non-Operational Power Management Enable) 
	powercfg /setacvalueindex scheme_current 0012ee47-9041-4b5d-9b77-535fba8b1442 fc7372b6-ab2d-43ee-8797-15e9841f2cca 0
	# Disable D3 support on SATA/NVMEs while using Modern Standby
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Storage" -Name "StorageD3InModernStandby" -Value 0 -PropertyType DWORD -Force | Out-Null	
	# Disable IdlePowerMode for stornvme.sys (storage devices) - the device will never enter a low-power state	
	New-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\stornvme\Parameters\Device" -Name "IdlePowerMode" -Value 0 -PropertyType DWORD -Force | Out-Null			
	# USB
	Write-Output "Disabling USB Power Saving..."
	# Set USB hub selective suspend timeout to 0 milliseconds to prevent USB device sleep
	powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 0853a681-27c8-4100-a2fd-82013e970683 0
	# Disable USB selective suspend feature to prevent individual USB devices from entering low-power states
	powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 48e6b7a6-50f5-4782-a5d4-53bb8f07e226 0
	# Disable USB 3.0 link power management to maintain maximum USB 3.0 device performance and connectivity
	powercfg /setacvalueindex scheme_current 2a737441-1930-4402-8d77-b2bebba308a3 d4e98f31-5ffe-4ce1-be31-1b38b384c009 0
	# disables power saving features for all devices (that support power saving) in Device Manager.	
	# get all USB ROOT devices	
	$devicesUSB = Get-PnpDevice | Where-Object { $_.InstanceId -like "*USB\ROOT*" }	
	# disable each device	
	foreach ($device in $devicesUSB) {	
    	try {	
        	Set-CimInstance -Namespace root\wmi `
            	-Query "SELECT * FROM MSPower_DeviceEnable WHERE InstanceName LIKE '%$($device.PNPDeviceID)%'" `
            	-Property @{Enable = $false} ` | Out-Null	
    	} catch {}	
	}

	# DISABLE NETWORK POWER SAVING
	Write-Output "Disabling Network Power Saving..."
	$properties = Get-NetAdapter -Physical | Get-NetAdapterAdvancedProperty	
	foreach ($setting in @(	
    	# Stands for Ultra Low Power	
    	"ULPMode",	

    	# Energy Efficient Ethernet	
    	"EEE",	
    	"EEELinkAdvertisement",	
    	"AdvancedEEE",	
    	"EnableGreenEthernet",	
    	"EeePhyEnable",	

    	# Wi-Fi capability that saves power consumption	
    	"uAPSDSupport",	

    	# Self-explanatory	
    	"EnablePowerManagement",	
    	"EnableSavePowerNow",	
    	"bLowPowerEnable",	
    	"PowerSaveMode",	
    	"PowerSavingMode",	
    	"SavePowerNowEnabled",	
    	"AutoPowerSaveModeEnabled",	
    	"NicAutoPowerSaver",	
    	"SelectiveSuspend"	
	)) {	
    	$properties | Where-Object { $_.RegistryKeyword -eq "*$setting" -or $_.RegistryKeyword -eq $setting } | Set-NetAdapterAdvancedProperty -RegistryValue 0	
	}	

	$keys = Get-ChildItem -Path "HKLM:\SYSTEM\CurrentControlSet\Enum" -Recurse -EA 0	
	foreach ($value in @(	
    	"AllowIdleIrpInD3",	
    	"D3ColdSupported",	
    	"DeviceSelectiveSuspended",	
    	"EnableIdlePowerManagement",	
    	"EnableSelectiveSuspend",	
    	"EnhancedPowerManagementEnabled",	
    	"IdleInWorkingState",	
    	"SelectiveSuspendEnabled",	
    	"SelectiveSuspendOn",	
    	"WaitWakeEnabled",	
    	"WakeEnabled",
    	"WdfDirectedPowerTransitionEnable"	
	)) {	
    	$keys | Where-Object { $_.GetValueNames() -contains $value } | ForEach-Object {	
        	$keyPath = $_.PSPath	
        	$oldValue = "$value-OLD"	
        	
        	if ($null -eq (Get-ItemProperty -Path $keyPath -Name $oldValue -EA 0)) {	
            	Rename-ItemProperty -Path $keyPath -Name $value -NewName $oldValue -Force	
        	}	
	
        	Set-ItemProperty -Path $KeyPath -Name $value -Value 0 -Type DWORD -Force	
    	}	
	}
	Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root/WMI | Set-CimInstance -Property @{ Enable = $false }	

	# ADDITIONAL POWER OPTIMIZATIONS
	# Additional Power Optimizations by @sherifmagdy32, creator of "GoInterruptPolicy" app
	Write-Host "Additional Power Optimizations by @sherifmagdy32..." -ForegroundColor Green
	# Processor idle thresholds
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82BE-4824-96C1-47B60B740D00 4B92D758-5A24-4851-A470-815D78AEE119 100   # Idle demote threshold
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82BE-4824-96C1-47B60B740D00 7B224883-B3CC-4D79-819F-8374152CBE7C 100   # Idle promote threshold
	# Allow Standby States
	powercfg /setacvalueindex SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 abfc2519-3608-4c2a-94ea-171b0ed546ab 0
 	# Deep Sleep
	# powercfg /setacvalueindex SCHEME_CURRENT 2e601130-5351-4d9d-8e04-252966bad054 d502f7ee-1dc7-4efd-a55d-f04b6f5c0545 0
	# Processor performance core parking
	# undocumented setting (Unknown, not in official docs)
	# powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 a55612aa-f624-42c6-a443-7397d064c04f 0   # Core override
	# Ensures a minimum of 100% of logical processors remain unparked
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 ea062031-0e34-4ff1-9b6d-eb1059334028 100 # Max cores
  	# Processor performance boost mode
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 be337238-0d82-4146-a960-4f3749d470c7 2	
 	# Processor autonomous modes
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 8baa4a8a-14c6-4451-8e8b-14bdbd197537 0
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 cfeda3d0-7697-4566-a922-a9086cd49dfa 0   # Activity window
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 4e4450b3-6179-4e91-b8f1-5bb9938f81a1 0   # Duty cycling
	# NVMe Power State Transition Latency Tolerance
	powercfg /setacvalueindex SCHEME_CURRENT 0012ee47-9041-4b5d-9b77-535fba8b1442 fc95af4d-40e7-4b6d-835a-56d131dbc80e 0
	# Processor idle disable. Only uncomment if on desktop with good CPU refrigeration and low temps, because it reduces input lag but raises temp even on idle. It keeps running the CPU at 100% all the time.
	# powercfg /setacvalueindex SCHEME_CURRENT 54533251-82BE-4824-96C1-47B60B740D00 5d76a2ca-e8c0-402f-a133-2158492d58ad 1
	
 	# (All safe on AC-powered laptops)
 	# System unattended sleep timeout
	powercfg /setacvalueindex SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 0 
	# Processor performance increase threshold
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 06cadf0e-64ed-448a-8927-ce7bf90eb35d 0
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 06cadf0e-64ed-448a-8927-ce7bf90eb35e 0   # Efficiency Class 1
	# Latency sensitivity hint processor performance
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 619b7505-003b-4e82-b7a6-4dd29c300971 0
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 619b7505-003b-4e82-b7a6-4dd29c300972 0   # Efficiency Class 1
	# Disconnected standby mode
	powercfg /setacvalueindex SCHEME_CURRENT fea3413e-7e05-4911-9a71-700331f1c294 68afb2d9-ee95-47a8-8f50-4115088073b1 0  
	# Processor energy performance preference policy
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 36687f9e-e3a5-4dbf-b1dc-15eb381c6863 0
	# Processor performance decrease thresholds/policies
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 12a0ab44-fe28-4fa9-b3bd-4b64f44960a6 10
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 2
	# Processor performance increase policies
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 465e1f50-b610-473a-ab58-00d1077dc418 2
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 465e1f50-b610-473a-ab58-00d1077dc419 2   # Efficiency Class 1
	# Sleep button action
	powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 96996bc0-ad50-47ec-923b-6f41874dd9eb 0
	# Disable away mode
	powercfg /setacvalueindex SCHEME_CURRENT 238c9fa8-0aad-41ed-83f4-97be242c8f20 25dfa149-5dd1-4736-b5ab-e8a37b5b8187 0
	# Lid close action
	powercfg /setacvalueindex SCHEME_CURRENT 4f971e89-eebd-4455-a8de-9e59040e7347 5ca83367-6e45-459f-a27b-476b1d01c936 0
	# Media sharing
	powercfg /setacvalueindex SCHEME_CURRENT 9596fb26-9850-41fd-ac3e-f7c3c00afd4b 03680956-93bc-4294-bba6-4e0f09bb717f 1
	# Processor performance boost policy
	powercfg /setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96C1-47B60B740D00 45bcc044-d885-43e2-8605-ee0ec6e96b59 100
 	
	# Disable power saving feature in devices
	$keys = Get-ChildItem -Path "HKLM:\SYSTEM\CurrentControlSet\Enum" -Recurse	
	foreach ($value in @(	
		"DisableIdlePowerManagement"
	)) {	
    	$keys | Where-Object { $_.GetValueNames() -contains $value } | ForEach-Object {	
        	$keyPath = $_.PSPath	
        	$oldValue = "$value-OLD"	
        	
        	if ($null -eq (Get-ItemProperty -Path $keyPath -Name $oldValue -EA 0)) {	
            	Rename-ItemProperty -Path $keyPath -Name $value -NewName $oldValue -Force	
        	}	
	
	        Set-ItemProperty -Path $KeyPath -Name $value -Value 1 -Type DWORD -Force	
    	}	
	}

	$keys = Get-ChildItem -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Class" -Recurse -EA 0	
	foreach ($value in @(	
		"WakeEnabled"
    	"WdkSelectiveSuspendEnable"	
	)) {	
    	$keys | Where-Object { $_.GetValueNames() -contains $value } | ForEach-Object {	
        	$keyPath = $_.PSPath	
        	$oldValue = "$value-OLD"	
        	
        	if ($null -eq (Get-ItemProperty -Path $keyPath -Name $oldValue -EA 0)) {	
            	Rename-ItemProperty -Path $keyPath -Name $value -NewName $oldValue -Force	
        	}	
	
        	Set-ItemProperty -Path $KeyPath -Name $value -Value 1 -Type DWORD -Force	
    	}	
	}

	# Disable Coalescing Timer Interval to improve DPC latency
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Power\ModernSleep"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Power"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Session Manager\Power"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Session Manager\Memory Management"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Session Manager\kernel"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Session Manager\Executive"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control\Session Manager"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\System\CurrentControlSet\Control"" /v CoalescingTimerInterval /t REG_DWORD /d 0 /f >nul 2>&1"
	# Tell Windows to stop tolerating high DPC/ISR latencies
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v ExitLatency /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v ExitLatencyCheckEnabled /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v Latency /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v LatencyToleranceDefault /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v LatencyToleranceFSVP /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v LatencyTolerancePerfOverride /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v LatencyToleranceScreenOffIR /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v LatencyToleranceVSyncEnabled /t REG_DWORD /d 1 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v RtlCapabilityCheckLatency /t REG_DWORD /d 1 /f >nul 2>&1"

	# Disable Energy Estimation
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v EnergyEstimationEnabled /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable Connected Standby
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v CsEnabled /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable Platform Sleep States
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v PerfCalculateActualUtilization /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable Sleep Reliability Detailed Diagnostics
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v SleepReliabilityDetailedDiagnostics /t REG_DWORD /d 0 /f >nul 2>&1"

	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v EventProcessorEnabled /t REG_DWORD /d 0 /f >nul 2>&1"
	
	# Disable QoS management of idle processors to reduce latency
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v QosManagesIdleProcessors /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable Vsync Latency Update to reduce latency spikes
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v DisableVsyncLatencyUpdate /t REG_DWORD /d 1 /f >nul 2>&1"
	# Disable Sensor Watchdog to prevent unnecessary power state changes
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v DisableSensorWatchdog /t REG_DWORD /d 1 /f >nul 2>&1"
	# Disable Deep Io Coalescing to reduce latency
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v DeepIoCoalescingEnabled /t REG_DWORD /d 0 /f >nul 2>&1"
	# Setting CPU performance scaling to 64% for lower latency
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v LowLatencyScalingPercentage /t REG_DWORD /d 64 /f >nul 2>&1"
	# Disabling media foundation buffering threshold for real-time media processing
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v MfBufferingThreshold /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disabling away mode which mimics sleep while keeping apps running
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v AwayModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1"
	# Setting initial unparked CPU cores to maximum for immediate responsiveness
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v Class1InitialUnparkCount /t REG_DWORD /d 100 /f >nul 2>&1"
	# Enabling power plan customization during system setup
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v CustomizeDuringSetup /t REG_DWORD /d 1 /f >nul 2>&1"
	# Setting hibernation file size to 0% to disable hibernation
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v HiberFileSizePercent /t REG_DWORD /d 0 /f >nul 2>&1"
	# Setting timer threshold for better power state transitions
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v TimerRebaseThresholdOnDripsExit /t REG_DWORD /d 30 /f >nul 2>&1"
	# Disabling energy estimation to prevent power-saving throttling
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v EnergyEstimationDisabled /t REG_DWORD /d 1 /f >nul 2>&1"
	# Enabling performance boost even at guaranteed power levels
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v PerfBoostAtGuaranteed /t REG_DWORD /d 1 /f >nul 2>&1"
	# Disabling core parking to keep all CPU cores active
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v CoreParkingDisabled /t REG_DWORD /d 1 /f >nul 2>&1"
	# Set minimum processor state to 100%
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v MinimumThrottlePercent /t REG_DWORD /d 0 /f >nul 2>&1"
	# Set maximum processor state to 100%
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power"" /v MaximumThrottlePercent /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable power management in connected standby mode
	cmd /c "reg add ""HKLM\SOFTWARE\Policies\Microsoft\Windows\WcmSvc\GroupPolicy"" /v fDisablePowerManagement /t REG_DWORD /d 1 /f >nul 2>&1"
	# Disable energy save from PDC
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\PDC\Activators\Default\VetoPolicy"" /v EA:EnergySaverEngaged /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\PDC\Activators\28\VetoPolicy"" /v EA:PowerStateDischarging /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable ASPM
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Services\pci\Parameters"" /v ASPMOptOut /t REG_DWORD /d 1 /f >nul 2>&1"
	# Disable Sleep study
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power"" /v SleepStudyDisabled /t REG_DWORD /d 1 /f >nul 2>&1"
	# High Performance Burst
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}"" /v TimeLimitInSeconds /t REG_DWORD /d 12 /f >nul 2>&1"
	# Power profile tweaks (multiple entries)
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{BDB3AF7A-F67E-4d1e-945D-E2790352BE0A}"" /ve /t REG_SZ /d ""{db57eb61-1aa2-4906-9396-23e8b8024c32}"" /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{BDB3AF7A-F67E-4d1e-945D-E2790352BE0A}"" /v Operator /t REG_DWORD /d 2 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{BDB3AF7A-F67E-4d1e-945D-E2790352BE0A}"" /v Type /t REG_DWORD /d 0x0000103d /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{BDB3AF7A-F67E-4d1e-945D-E2790352BE0A}"" /v Value /t REG_DWORD /d 0 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{CD9230EE-218E-44b9-8AE5-EE7AA5DAD08F}"" /ve /t REG_SZ /d ""{db57eb61-1aa2-4906-9396-23e8b8024c32}"" /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{CD9230EE-218E-44b9-8AE5-EE7AA5DAD08F}"" /v Operator /t REG_DWORD /d 2 /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{CD9230EE-218E-44b9-8AE5-EE7AA5DAD08F}"" /v Type /t REG_DWORD /d 0x0000100a /f >nul 2>&1"
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Power\Profile\Events\{54533251-82be-4824-96c1-47b60b740d00}\{0DA965DC-8FCF-4c0b-8EFE-8DD5E7BC959A}\{7E01ADEF-81E6-4e1b-8075-56F373584694}\{F6CC25DF-6E8F-4cf8-A242-B1343F565884}\{CD9230EE-218E-44b9-8AE5-EE7AA5DAD08F}"" /v Value /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable CPPC (Collaborative Processor Performance Control)
	cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Processor"" /v CPPCEnable /t REG_DWORD /d 0 /f >nul 2>&1"
	# Disable Cstates (BIOS settings override)
	# Write-Output "Disabling CPU C-States..."
	# cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Processor"" /v Capabilities /t REG_DWORD /d 0x0007e066 /f >nul 2>&1"
	# cmd /c "reg add ""HKLM\SYSTEM\CurrentControlSet\Control\Processor"" /v Cstates /t REG_DWORD /d 0 /f >nul 2>&1"

	if ($Silent) {}	
}