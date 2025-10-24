function Invoke-RegOptimize {
	Write-Host "Optimizing Registry..." -ForegroundColor Green
	$MultilineComment = @'
Windows Registry Editor Version 5.00

; --LEGACY CONTROL PANEL--




; EASE OF ACCESS
; disable narrator
[HKEY_CURRENT_USER\Software\Microsoft\Narrator\NoRoam]
"DuckAudio"=dword:00000000
"WinEnterLaunchEnabled"=dword:00000000
"ScriptingEnabled"=dword:00000000
"OnlineServicesEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Narrator]
"NarratorCursorHighlight"=dword:00000000
"CoupleNarratorCursorKeyboard"=dword:00000000

; disable ease of access settings 
[HKEY_CURRENT_USER\Software\Microsoft\Ease of Access]
"selfvoice"=dword:00000000
"selfscan"=dword:00000000

[HKEY_CURRENT_USER\Control Panel\Accessibility]
"Sound on Activation"=dword:00000000
"Warning Sounds"=dword:00000000

[HKEY_CURRENT_USER\Control Panel\Accessibility\HighContrast]
"Flags"="4194"

[HKEY_CURRENT_USER\Control Panel\Accessibility\Keyboard Response]
"Flags"="2"
"AutoRepeatRate"="0"
"AutoRepeatDelay"="0"

[HKEY_CURRENT_USER\Control Panel\Accessibility\MouseKeys]
"Flags"="130"
"MaximumSpeed"="39"
"TimeToMaximumSpeed"="3000"

[HKEY_CURRENT_USER\Control Panel\Accessibility\StickyKeys]
"Flags"="2"

[HKEY_CURRENT_USER\Control Panel\Accessibility\ToggleKeys]
"Flags"="34"

[HKEY_CURRENT_USER\Control Panel\Accessibility\SoundSentry]
"Flags"="0"
"FSTextEffect"="0"
"TextEffect"="0"
"WindowsEffect"="0"

[HKEY_CURRENT_USER\Control Panel\Accessibility\SlateLaunch]
"ATapp"=""
"LaunchAT"=dword:00000000




; CLOCK AND REGION
; disable notify me when the clock changes
[HKEY_CURRENT_USER\Control Panel\TimeDate]
"DstNotification"=dword:00000000




; APPEARANCE AND PERSONALIZATION
; disable spotlight
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableCloudOptimizedContent"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableWindowsSpotlightFeatures"=dword:00000001
"DisableWindowsSpotlightWindowsWelcomeExperience"=dword:00000001
"DisableWindowsSpotlightOnActionCenter"=dword:00000001
"DisableWindowsSpotlightOnSettings"=dword:00000001
"DisableThirdPartySuggestions"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel]
"{2cc5ca98-6485-489a-920e-b3e88a6ccce3}"=dword:00000001

; open file explorer to this pc
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"LaunchTo"=dword:00000001

; hide frequent folders in quick access
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowFrequent"=dword:00000000

; show file name extensions
; show hidden files
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"HideFileExt"=dword:00000000
"Hidden"=dword:00000001

; disable search history
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDeviceSearchHistoryEnabled"=dword:00000000

; disable show files from office.com
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"ShowCloudFilesInQuickAccess"=dword:00000000

; disable display file size information in folder tips
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"FolderContentsInfoTip"=dword:00000000

; enable display full path in the title bar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CabinetState]
"FullPath"=dword:00000001

; disable show pop-up description for folder and desktop items
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowInfoTip"=dword:00000000

; disable show preview handlers in preview pane
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowPreviewHandlers"=dword:00000000

; disable show status bar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowStatusBar"=dword:00000000

; disable show sync provider notifications
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowSyncProviderNotifications"=dword:00000000

; disable use sharing wizard
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SharingWizardOn"=dword:00000000

; disable show network
[HKEY_CURRENT_USER\Software\Classes\CLSID\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}]
"System.IsPinnedToNameSpaceTree"=dword:00000000




; HARDWARE AND SOUND
; disable lock [ optional ]
; [HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]
; "ShowLockOption"=dword:00000000

; disable sleep [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FlyoutMenuSettings]
; "ShowSleepOption"=dword:00000000

; sound communications do nothing
[HKEY_CURRENT_USER\Software\Microsoft\Multimedia\Audio]
"UserDuckingPreference"=dword:00000003

; disable startup sound
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\BootAnimation]
"DisableStartupSound"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\EditionOverrides]
"UserSetting_DisableStartupSound"=dword:00000001

; sound scheme none
[HKEY_CURRENT_USER\AppEvents\Schemes]
@=".None"

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\.Default\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\CriticalBatteryAlarm\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceConnect\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceDisconnect\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\DeviceFail\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\FaxBeep\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\LowBatteryAlarm\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MailBeep\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\MessageNudge\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Default\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.IM\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Mail\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Proximity\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.Reminder\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\Notification.SMS\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\ProximityConnection\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemAsterisk\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemExclamation\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemHand\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\SystemNotification\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\.Default\WindowsUAC\.Current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\DisNumbersSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOffSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubOnSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\HubSleepSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\MisrecoSound\.current]
@=""

[HKEY_CURRENT_USER\AppEvents\Schemes\Apps\sapisvr\PanelSound\.current]
@=""

; disable autoplay
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers]
"DisableAutoplay"=dword:00000001

; disable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; mouse pointers scheme none
[HKEY_CURRENT_USER\Control Panel\Cursors]
"AppStarting"=hex(2):00,00
"Arrow"=hex(2):00,00
"ContactVisualization"=dword:00000000
"Crosshair"=hex(2):00,00
"GestureVisualization"=dword:00000000
"Hand"=hex(2):00,00
"Help"=hex(2):00,00
"IBeam"=hex(2):00,00
"No"=hex(2):00,00
"NWPen"=hex(2):00,00
"Scheme Source"=dword:00000000
"SizeAll"=hex(2):00,00
"SizeNESW"=hex(2):00,00
"SizeNS"=hex(2):00,00
"SizeNWSE"=hex(2):00,00
"SizeWE"=hex(2):00,00
"UpArrow"=hex(2):00,00
"Wait"=hex(2):00,00
@=""

; disable device installation settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001




; NETWORK AND INTERNET
; disable allow other network users to control or disable the shared internet connection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Network\SharedAccessConnection]
"EnableControl"=dword:00000000




; SYSTEM AND SECURITY
; prefer IPv4 over IPv6
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters]
"DisabledComponents"=dword:00000020

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters]
"EnablePMTUDiscovery"=dword:00000001
"EnablePMTUBHDetect"=dword:00000000
"Tcp1323Opts"=dword:00000001
"SackOpts"=dword:00000001
"DefaultTTL"=dword:00000040
"GlobalMaxTcpWindowSize"=dword:00007fff

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"MaxCacheEntryTtlLimit"=dword:0000fa00
"MaxNegativeCacheTtl"=dword:00000000

; set appearance options to custom
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects]
"VisualFXSetting"=dword:3

; Visual Effects
[HKEY_CURRENT_USER\Control Panel\Desktop]
"FontSmoothing"="2"
"UserPreferencesMask"=hex:90,12,03,80,10,00,00,00
"DragFullWindows"="1"

; animate windows when minimizing and maximizing
[HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
"MinAnimate"="0"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ListviewAlphaSelect"=dword:00000001
"IconsOnly"=dword:00000000
"TaskbarAnimations"=dword:00000000 ; animations in the taskbar
"ListviewShadow"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
"EnableAeroPeek"=dword:00000000
"AlwaysHibernateThumbnails"=dword:00000000

; adjust for best performance of programs
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl]
"ConvertibleSlateMode"=dword:00000000
"Win32PrioritySeparation"=dword:00000026

; disable remote assistance
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Remote Assistance]
"fAllowToGetHelp"=dword:00000000

; system responsiveness 100%
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile]
"NetworkThrottlingIndex"=dword:ffffffff
"SystemResponsiveness"=dword:00000000

; cpu priority for gaming
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Audio]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Capture]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000005
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\DisplayPostProcessing]
"Affinity"=dword:00000000
"Background Only"="True"
"BackgroundPriority"=dword:00000008
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000008
"Scheduling Category"="High"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Distribution]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000004
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games]
"Affinity"=dword:00000000
"Background Only"="False"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000006
"Scheduling Category"="High"
"SFIO Priority"="High"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Playback]
"Affinity"=dword:00000000
"Background Only"="False"
"BackgroundPriority"=dword:00000004
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000003
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Pro Audio]
"Affinity"=dword:00000000
"Background Only"="False"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000001
"Scheduling Category"="High"
"SFIO Priority"="Normal"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Window Manager]
"Affinity"=dword:00000000
"Background Only"="True"
"Clock Rate"=dword:00002710
"GPU Priority"=dword:00000008
"Priority"=dword:00000005
"Scheduling Category"="Medium"
"SFIO Priority"="Normal"

; enable virtual memory
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"ClearPageFileAtShutdown"=dword:00000000
"DisablePagingExecutive"=dword:00000001
"HotPatchTableSize"=dword:00001000
"LargeSystemCache"=dword:00000000
"NonPagedPoolQuota"=dword:00000000
"NonPagedPoolSize"=dword:00000000
"PagedPoolQuota"=dword:00000000
"PagedPoolSize"=dword:00000000
"PagingFiles"=hex(7):63,00,3a,00,5c,00,70,00,61,00,67,00,65,00,66,00,69,00,6c,\
  00,65,00,2e,00,73,00,79,00,73,00,20,00,31,00,36,00,20,00,38,00,31,00,39,00,\
  32,00,00,00,00,00
"SecondLevelDataCache"=dword:00000000
"SessionPoolSize"=dword:00000004
"SessionViewSize"=dword:00000030
"SystemPages"=dword:00000000
"SwapfileControl"=dword:00000000
"AutoReboot"=dword:00000000
"CrashDumpEnabled"=dword:00000000
"Overwrite"=dword:00000000
"LogEvent"=dword:00000000
"MinidumpsCount"=dword:00000020
"FeatureSettings"=dword:00000000
"FeatureSettingsOverrideMask"=dword:00000003
"FeatureSettingsOverride"=dword:00000003
"PhysicalAddressExtension"=dword:00000001
"ExistingPageFiles"=hex(7):5c,00,3f,00,3f,00,5c,00,43,00,3a,00,5c,00,70,00,61,\
  00,67,00,65,00,66,00,69,00,6c,00,65,00,2e,00,73,00,79,00,73,00,00,00,00,00

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters]
"EnablePrefetcher"=dword:00000000
"EnableBootTrace"=dword:00000000
"EnableSuperfetch"=dword:00000000
; "SfTracingState"=dword:00000001




; DISABLE WINDOWS SECURITY SETTINGS
; disable cloud delivered protection
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
; "SpyNetReporting"=dword:00000000

; disable automatic sample submission
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Spynet]
; "SubmitSamplesConsent"=dword:00000000

; disable firewall notifications
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Notifications]
"DisableEnhancedNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender Security Center\Virus and threat protection]
"NoActionNotificationDisabled"=dword:00000001
"SummaryNotificationDisabled"=dword:00000001
"FilesBlockedNotificationDisabled"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Defender Security Center\Account protection]
"DisableNotifications"=dword:00000001
"DisableDynamiclockNotifications"=dword:00000001
"DisableWindowsHelloNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Epoch]
"Epoch"=dword:000004cf

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile]
"DisableNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile]
"DisableNotifications"=dword:00000001

[HKEY_LOCAL_MACHINE\System\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile]
"DisableNotifications"=dword:00000001

; exploit protection, leaving control flow guard cfg on for vanguard anticheat
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\Session Manager\kernel]
"MitigationOptions"=hex:22,22,22,00,00,01,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00

; disable core isolation 
; memory integrity 
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; disable device guard
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceGuard]
"EnableVirtualizationBasedSecurity"=dword:00000000
"RequirePlatformSecurityFeatures"=-
"HypervisorEnforcedCodeIntegrity"=-
"HVCIMATRequired"=dword:00000000
"LsaCfgFlags"=-
"ConfigureSystemGuardLaunch"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceGuard]
"EnableVirtualizationBasedSecurity"=dword:00000000
"RequirePlatformSecurityFeatures"=-
"HypervisorEnforcedCodeIntegrity"=-
"HVCIMATRequired"=dword:00000000
"LsaCfgFlags"=-
"ConfigureSystemGuardLaunch"=-

; disable local security authority protection
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
"RunAsPPL"=dword:00000000
"RunAsPPLBoot"=dword:00000000

; disable microsoft vulnerable driver blocklist
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\CI\Config]
"VulnerableDriverBlocklistEnable"=dword:00000000

; disable Bitlocker
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\BitLocker]
"PreventDeviceEncryption"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\FVE]
"DisableExternalDMAUnderLock"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EnhancedStorageDevices]
"TCGSecurityActivationDisabled"=dword:00000001

; kernel-mode hardware-enforced stack protection
[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; spectre and meltdown
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\Memory Management]
"FeatureSettingsOverrideMask"=dword:00000003
"FeatureSettingsOverride"=dword:00000003

; other mitigations
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsMitigation]
"UserPreference"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SCMConfig]
"EnableSvchostMitigationPolicy"=hex(b):00,00,00,00,00,00,00,00

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\kernel]
; "MitigationAuditOptions"=hex:00,00,00,00,00,00,20,22,00,00,00,00,00,00,00,20,00,00,00,00,00,00,00,00
; "MitigationOptions"=hex:00,22,22,20,22,20,22,22,20,00,00,00,00,20,00,20,00,00,00,00,00,00,00,00
; "KernelSEHOPEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\System\ControlSet001\Control\DeviceGuard\Scenarios\KernelShadowStacks]
"ChangedInBootCycle"=-
"Enabled"=dword:00000000
"WasEnabledBy"=-

; disable uac
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
; "EnableLUA"=dword:00000000

; disable smartscreen
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"SmartScreenEnabled"="Off"

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"EnableSmartScreen"=dword:00000000
"ShellSmartScreenLevel"=-

; disable smartscreen in edge
[HKEY_CURRENT_USER\Software\Microsoft\Edge\SmartScreenEnabled]
"(Default)"="0"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenEnabled]
@=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Edge\SmartScreenPuaEnabled]
@=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter]
"EnabledV9"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\MicrosoftEdge\PhishingFilter]
"EnabledV9"=dword:00000000

; disable smartscreen for store apps
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost]
"EnableWebContentEvaluation"=dword:00000000
"PreventOverride"=dword:00000000

; disable fth
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\FTH]
"Enabled"=dword:00000000

; hide family options settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Family options]
"UILockdown"=dword:00000001

; hide account protection settings
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Account protection]
"UILockdown"=dword:00000001

; hide device security settings (optional)
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Device security]
; "UILockdown"=dword:00000001




; TROUBLESHOOTING
; disable automatic maintenance
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance]
"MaintenanceDisabled"=dword:00000001




; SECURITY AND MAINTENANCE
; disable report problems
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001
"DontSendAdditionalData"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\PCHealth\ErrorReporting]
"DoReport"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Error Reporting]
"Disabled"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\HandwritingErrorReports]
"PreventHandwritingErrorReports"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports]
"PreventHandwritingErrorReports"=dword:00000001

; dont send a windows error report when a generic driver is installed on a device
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendGenericDriverNotFoundToWER"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendGenericDriverNotFoundToWER"=dword:00000001

; prevent windows from sending an error report when a device driver requests additional software during installation
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableSendRequestAdditionalSoftwareToWER"=dword:00000001

; Increase System Restore Point Creation Frequency
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore]
"SystemRestorePointCreationFrequency"=dword:00000000

; Limiting Windows Defender CPU usage
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Scan]
"AvgCPULoadFactor"=dword:00000019
"ScanAvgCPULoadFactor"=dword:00000019




; --IMMERSIVE CONTROL PANEL--




; WINDOWS UPDATE
; disable automatic updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU]
"AUOptions"=dword:00000002
; Breaks 'Receive updates for other Microsoft products'
; "NoAutoUpdate"=dword:00000001
; enable notifications for security updates only (do not auto-download)
; "AutoInstallMinorUpdates"=dword:00000000

; prevent automatic upgrade to windows 11 and defer quality updates for 1 year
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"TargetReleaseVersion"=dword:00000001
"TargetReleaseVersionInfo"="22H2"
"ProductVersion"="Windows 10"
"DeferFeatureUpdates"=dword:00000001
"DeferFeatureUpdatesPeriodInDays"=dword:0000016d
"DeferQualityUpdates"=dword:00000001
"DeferQualityUpdatesPeriodInDays"=dword:00000007

; block workplace join prompt
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WorkplaceJoin]
"BlockAADWorkplaceJoin"=dword:00000001

; turn off driver updates via win update
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Update]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate]
"ExcludeWUDriversInQualityUpdate"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Update\ExcludeWUDriversInQualityUpdate]
"value"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata]
"PreventDeviceMetadataFromNetwork"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
"DontSearchWindowsUpdate"=dword:00000001

; disable delivery optimization
; gray out settings [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization]
; "DODownloadMode"=dword:00000000

[HKEY_USERS\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings]
"DownloadMode"=dword:00000000




; PRIVACY
; disable password reveal button
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CredUI]
"DisablePasswordReveal"=dword:00000001

; disable show me notification in the settings app
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SystemSettings\AccountNotifications]
"EnableAccountNotifications"=dword:00000000

; disable location
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location]
"Value"="Deny"

; disable allow location override
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CPSS\Store\UserLocationOverridePrivacySetting]
"Value"=dword:00000000

; enable camera
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam]
"Value"="Allow"

; enable microphone 
[Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone]
"Value"="Allow"

; disable voice activation
[HKEY_CURRENT_USER\Software\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps]
"AgentActivationEnabled"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Speech_OneCore\Settings\VoiceActivation\UserPreferenceForAllApps]
"AgentActivationLastUsed"=dword:00000000

; disable notifications
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userNotificationListener]
"Value"="Deny"

; disable action center [ optional ]
; [HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]
; "DisableNotificationCenter"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
; "DisableNotificationCenter"=dword:00000001

; disable account info
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userAccountInformation]
"Value"="Deny"

; disable contacts
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\contacts]
"Value"="Deny"

; disable calendar
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appointments]
"Value"="Deny"

; disable phone calls
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCall]
"Value"="Deny"

; disable call history
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\phoneCallHistory]
"Value"="Deny"

; disable email
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\email]
"Value"="Deny"

; disable tasks
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\userDataTasks]
"Value"="Deny"

; disable messaging
[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\chat]
"Value"="Deny"

; disable radios
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\radios]
"Value"="Deny"

; disable other devices 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\bluetoothSync]
"Value"="Deny"

; app diagnostics 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\appDiagnostics]
"Value"="Deny"

; disable documents
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\documentsLibrary]
"Value"="Deny"

; disable downloads folder 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\downloadsFolder]
"Value"="Deny"

; disable music library
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\musicLibrary]
"Value"="Deny"

; disable pictures
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\picturesLibrary]
"Value"="Deny"

; disable videos
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\videosLibrary]
"Value"="Deny"

; disable file system
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\broadFileSystemAccess]
"Value"="Deny"

; disable let websites show me locally relevant content by accessing my language list 
[HKEY_CURRENT_USER\Control Panel\International\User Profile]
"HttpAcceptLanguageOptOut"=dword:00000001

; disable let windows improve start and search results by tracking app launches  
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\EdgeUI]
"DisableMFUTracking"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\EdgeUI]
"DisableMFUTracking"=dword:00000001

; disable personal inking and typing dictionary
[HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization]
"RestrictImplicitInkCollection"=dword:00000001
"RestrictImplicitTextCollection"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\InputPersonalization\TrainedDataStore]
"HarvestContacts"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Personalization\Settings]
"AcceptedPrivacyPolicy"=dword:00000000

; disable sending required data
[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000

; feedback frequency never
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Siuf\Rules]
"NumberOfSIUFInPeriod"=dword:00000000
"PeriodInNanoSeconds"=-

; disable store my activity history on this device 
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"PublishUserActivities"=dword:00000000




; SEARCH
; disable search highlights
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsDynamicSearchBoxEnabled"=dword:00000000

; disable safe search
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\SearchSettings]
"SafeSearchMode"=dword:00000000

; disable cloud content search for work or school account
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsAADCloudSearchEnabled"=dword:00000000

; disable cloud content search for microsoft account
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SearchSettings]
"IsMSACloudSearchEnabled"=dword:00000000




; EASE OF ACCESS
; disable magnifier settings 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\ScreenMagnifier]
"FollowCaret"=dword:00000000
"FollowNarrator"=dword:00000000
"FollowMouse"=dword:00000000
"FollowFocus"=dword:00000000

; disable narrator settings
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator]
"IntonationPause"=dword:00000000
"ReadHints"=dword:00000000
"ErrorNotificationType"=dword:00000000
"EchoChars"=dword:00000000
"EchoWords"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NarratorHome]
"MinimizeType"=dword:00000000
"AutoStart"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Narrator\NoRoam]
"EchoToggleKeys"=dword:00000000

; disable use the print screen key to open screeen capture
[HKEY_CURRENT_USER\Control Panel\Keyboard]
"PrintScreenKeyForSnippingEnabled"=dword:00000000




; GAMING
; disable game bar
[HKEY_CURRENT_USER\System\GameConfigStore]
"GameDVR_Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]
"AppCaptureEnabled"=dword:00000000

; disable enable open xbox game bar using game controller
[HKEY_CURRENT_USER\Software\Microsoft\GameBar]
"UseNexusForGameBarEnabled"=dword:00000000

; enable game mode
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar]
"AllowAutoGameMode"=dword:00000001
"AutoGameModeEnabled"=dword:00000001

; other settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\GameDVR]
"AudioEncodingBitrate"=dword:0001f400
"AudioCaptureEnabled"=dword:00000000
"CustomVideoEncodingBitrate"=dword:003d0900
"CustomVideoEncodingHeight"=dword:000002d0
"CustomVideoEncodingWidth"=dword:00000500
"HistoricalBufferLength"=dword:0000001e
"HistoricalBufferLengthUnit"=dword:00000001
"HistoricalCaptureEnabled"=dword:00000000
"HistoricalCaptureOnBatteryAllowed"=dword:00000001
"HistoricalCaptureOnWirelessDisplayAllowed"=dword:00000001
"MaximumRecordLength"=hex(b):00,D0,88,C3,10,00,00,00
"VideoEncodingBitrateMode"=dword:00000002
"VideoEncodingResolutionMode"=dword:00000002
"VideoEncodingFrameRateMode"=dword:00000000
"EchoCancellationEnabled"=dword:00000001
"CursorCaptureEnabled"=dword:00000000
"VKToggleGameBar"=dword:00000000
"VKMToggleGameBar"=dword:00000000
"VKSaveHistoricalVideo"=dword:00000000
"VKMSaveHistoricalVideo"=dword:00000000
"VKToggleRecording"=dword:00000000
"VKMToggleRecording"=dword:00000000
"VKTakeScreenshot"=dword:00000000
"VKMTakeScreenshot"=dword:00000000
"VKToggleRecordingIndicator"=dword:00000000
"VKMToggleRecordingIndicator"=dword:00000000
"VKToggleMicrophoneCapture"=dword:00000000
"VKMToggleMicrophoneCapture"=dword:00000000
"VKToggleCameraCapture"=dword:00000000
"VKMToggleCameraCapture"=dword:00000000
"VKToggleBroadcast"=dword:00000000
"VKMToggleBroadcast"=dword:00000000
"MicrophoneCaptureEnabled"=dword:00000000
"SystemAudioGain"=hex(b):10,27,00,00,00,00,00,00
"MicrophoneGain"=hex(b):10,27,00,00,00,00,00,00




; TIME & LANGUAGE 
; disable show the voice typing mic button
[HKEY_CURRENT_USER\Software\Microsoft\input\Settings]
"IsVoiceTypingKeyEnabled"=dword:00000000

; disable capitalize the first letter of each sentence
; disable play key sounds as i type
; disable add a period after i double-tap the spacebar
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\1.7]
"EnableAutoShiftEngage"=dword:00000000
"EnableKeyAudioFeedback"=dword:00000000
"EnableDoubleTapSpace"=dword:00000000

; disable typing insights
[HKEY_CURRENT_USER\Software\Microsoft\input\Settings]
"InsightsEnabled"=dword:00000000




; ACCOUNTS
; disable use my sign in info after restart
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"DisableAutomaticRestartSignOn"=dword:00000001




; APPS
; disable automatically update maps
[HKEY_LOCAL_MACHINE\SYSTEM\Maps]
"AutoUpdateEnabled"=dword:00000000

; disable archive apps 
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Appx]
"AllowAutomaticAppArchiving"=dword:00000000

; turn off resume
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume\Configuration]
"IsResumeAllowed"=dword:00000000

; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CrossDeviceResume]  
; "DisableCrossDeviceResume"=dword:00000001  

; disable sync apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowSyncMySettings]
"value"=dword:00000000




; PERSONALIZATION
; don't show all taskbar icons
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
"EnableAutoTray"=-

; solid color personalize your background
; [HKEY_CURRENT_USER\Control Panel\Desktop]
; "Wallpaper"=""

; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
; "BackgroundType"=dword:00000001

; dark theme 
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000000
"SystemUsesLightTheme"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000000

; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent]
; "StartColorMenu"=dword:ff3d3f41
; "AccentColorMenu"=dword:ff484a4c
; "AccentPalette"=hex(3):DF,DE,DC,00,A6,A5,A1,00,68,65,62,00,4C,4A,48,00,41,\
; 3F,3D,00,27,25,24,00,10,0D,0D,00,10,7C,10,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"EnableWindowColorization"=dword:00000001
"AccentColor"=dword:ff484a4c
"ColorizationColor"=dword:c44c4a48
"ColorizationAfterglow"=dword:c44c4a48

; disable transparency
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000000

; always hide most used list in start menu
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"ShowOrHideMostUsedApps"=dword:00000002

[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"ShowOrHideMostUsedApps"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoStartMenuMFUprogramsList"=-
"NoInstrumentation"=-

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoStartMenuMFUprogramsList"=-
"NoInstrumentation"=-

; start menu hide recommended w11
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Start]
"HideRecommendedSection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Education]
"IsEducationEnvironment"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"HideRecommendedSection"=dword:00000001

; more pins personalization start
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_Layout"=dword:00000001

; disable show recently added apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"HideRecentlyAddedApps"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideRecentlyAddedApps"=dword:00000001

; disable show account-related notifications
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_AccountNotifications"=dword:00000000

; disable show recently opened items in start, jump lists and file explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_TrackDocs"=dword:00000000 
"Start_ShowRecentDocs"=dword:00000000

; left taskbar alignment
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarAl"=dword:00000000

; remove chat from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarMn"=dword:00000000

; remove task view from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowTaskViewButton"=dword:00000000

; remove search from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search]
"SearchboxTaskbarMode"=dword:00000000

; remove windows widgets from taskbar
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Dsh] 
"AllowNewsAndInterests"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Feeds]
"ShellFeedsTaskbarOpenOnHover"=dword:00000000

; remove copilot from taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"ShowCopilotButton"=dword:00000000

; remove meet now
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"HideSCAMeetNow"=dword:00000001

; remove news and interests
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds]
"EnableFeeds"=dword:00000000

; show all taskbar icons [ optional ]
; [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer]
; "EnableAutoTray"=dword:00000000

; remove security taskbar icon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run]
"SecurityHealth"=hex(3):07,00,00,00,05,DB,8A,69,8A,49,D9,01

; disable use dynamic lighting on my devices
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"AmbientLightingEnabled"=dword:00000000

; disable compatible apps in the forground always control lighting 
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"ControlledByForegroundApp"=dword:00000000

; disable match my windows accent color 
[HKEY_CURRENT_USER\Software\Microsoft\Lighting]
"UseSystemAccentColor"=dword:00000000

; disable show key background
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\1.7]
"IsKeyBackgroundEnabled"=dword:00000000

; disable show recommendations for tips shortcuts new apps and more
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_IrisRecommendations"=dword:00000000

; disable share any window from my taskbar
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"TaskbarSn"=dword:00000000

; disable online tips
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"AllowOnlineTips"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\EdgeUI]
"DisableHelpSticker"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DeviceInstall\Settings]
"DisableBalloonTips"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001




; DEVICES
; disable usb issues notify
[HKEY_CURRENT_USER\Software\Microsoft\Shell\USB]
"NotifyOnUsbErrors"=dword:00000000

; disable let windows manage my default printer
[HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows]
"LegacyDefaultPrinterMode"=dword:00000001

; disable write with your fingertip
[HKEY_CURRENT_USER\Software\Microsoft\TabletTip\EmbeddedInkControl]
"EnableInkingWithTouch"=dword:00000000




; SYSTEM
; 100% dpi scaling
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000060
"Win8DpiScaling"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM]
"UseDpiScaling"=dword:00000000

; disable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000000

; turn on hardware accelerated gpu scheduling
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\GraphicsDrivers]
"HwSchMode"=dword:00000002

; disable variable refresh rate & enable optimizations for windowed games
[HKEY_CURRENT_USER\Software\Microsoft\DirectX\UserGpuPreferences]
"DirectXUserGlobalSettings"="SwapEffectUpgradeEnable=1;VRROptimizeEnable=0;"

; disable notifications
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications]
"ToastEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\windows.immersivecontrolpanel_cw5n1h2txyewy!microsoft.windows.immersivecontrolpanel]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.CapabilityAccess]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.StartupApp]
"Enabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo]
"DisabledByGroupPolicy"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"RotatingLockScreenEnabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\UserProfileEngagement]
"ScoobeSystemSettingEnabled"=dword:00000000

; disable suggested actions
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SmartActionPlatform\SmartClipboard]
"Disabled"=dword:00000001

; disable focus assist
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\??windows.data.notifications.quiethourssettings\Current]
"Data"=hex(3):02,00,00,00,B4,67,2B,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,14,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,55,00,6E,00,72,00,65,00,73,00,74,00,72,\
00,69,00,63,00,74,00,65,00,64,00,CA,28,D0,14,02,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentfullscreen?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,97,1D,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,26,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,41,00,6C,00,61,00,72,00,6D,00,73,00,4F,\
00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentgame?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,6C,39,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,50,00,72,00,69,00,6F,00,72,00,69,00,74,\
00,79,00,4F,00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentpostoobe?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,06,54,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,50,00,72,00,69,00,6F,00,72,00,69,00,74,\
00,79,00,4F,00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentpresentation?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,83,6E,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,26,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,41,00,6C,00,61,00,72,00,6D,00,73,00,4F,\
00,6E,00,6C,00,79,00,C2,28,01,CA,50,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\?quietmomentscheduled?windows.data.notifications.quietmoment\Current]
"Data"=hex(3):02,00,00,00,2E,8A,2D,68,F0,0B,D8,01,00,00,00,00,43,42,01,00,\
C2,0A,01,D2,1E,28,4D,00,69,00,63,00,72,00,6F,00,73,00,6F,00,66,00,74,00,2E,\
00,51,00,75,00,69,00,65,00,74,00,48,00,6F,00,75,00,72,00,73,00,50,00,72,00,\
6F,00,66,00,69,00,6C,00,65,00,2E,00,50,00,72,00,69,00,6F,00,72,00,69,00,74,\
00,79,00,4F,00,6E,00,6C,00,79,00,C2,28,01,D1,32,80,E0,AA,8A,99,30,D1,3C,80,\
E0,F6,C5,D5,0E,CA,50,00,00

; battery options optimize for video quality
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\VideoSettings]
"VideoQualityOnBattery"=dword:00000001

; disable storage sense
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\StorageSense]
"AllowStorageSenseGlobal"=dword:00000000

; disable snap window settings
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"SnapAssist"=dword:00000000
"DITest"=dword:00000000
"EnableSnapBar"=dword:00000000
"EnableTaskGroups"=dword:00000000
"EnableSnapAssistFlyout"=dword:00000000
"SnapFill"=dword:00000000
"JointResize"=dword:00000000

; alt tab open windows only
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"MultiTaskingAltTabFilter"=dword:00000003

; disable share across devices
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\CDP]
"RomeSdkChannelUserAuthzPolicy"=dword:00000000
"CdpSessionUserAuthzPolicy"=dword:00000000

; disable Clipboard
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowCrossDeviceClipboard"=dword:00000000

; disable Clipboard history
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"AllowClipboardHistory"=dword:00000000




; --OTHER--




; STORE
; disable update apps automatically
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore]
"AutoDownload"=dword:00000002




; EDGE
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge]
"Edge3PSerpTelemetryEnabled"=dword:00000000
"EdgeAssetDeliveryServiceEnabled"=dword:00000000
"EdgeDiscoverEnabled"=dword:00000000
"EdgeEDropEnabled"=dword:00000000
"EdgeEnhanceImagesEnabled"=dword:00000000
"EdgeWalletCheckoutEnabled"=dword:00000000
"EdgeWalletEtreeEnabled"=dword:00000000
"ExperimentationAndConfigurationServiceControl"=dword:00000000
"ForceSync"=dword:00000000
"ImageEditorServiceEnabled"=dword:00000000
"InAppSupportEnabled"=dword:00000000
"InternetExplorerIntegrationLevel"=dword:00000000
"LiveCaptionsAllowed"=dword:00000000
"LiveTranslationAllowed"=dword:00000000
"MathSolverEnabled"=dword:00000000
"MicrosoftEdgeInsiderPromotionEnabled"=dword:00000000
"MicrosoftEditorSynonymsEnabled"=dword:00000000
"MicrosoftOfficeMenuEnabled"=dword:00000000
"OutlookHubMenuEnabled"=dword:00000000
"PersonalizeTopSitesInCustomizeSidebarEnabled"=dword:00000000
"PictureInPictureOverlayEnabled"=dword:00000000
"PromptForDownloadLocation"=dword:00000001
"SpeechRecognitionEnabled"=dword:00000000
"TextPredictionEnabled"=dword:00000000
"TranslateEnabled"=dword:00000001
"TravelAssistanceEnabled"=dword:00000000
"UploadFromPhoneEnabled"=dword:00000000
"UrlDiagnosticDataEnabled"=dword:00000000
"VisualSearchEnabled"=dword:00000000
"WalletDonationEnabled"=dword:00000000
"DefaultGeolocationSetting"=dword:00000002
"DefaultNotificationsSetting"=dword:00000002
"DefaultLocalFontsSetting"=dword:00000002
"DefaultSensorsSetting"=dword:00000002
"DefaultSerialGuardSetting"=dword:00000002
"CloudReportingEnabled"=dword:00000000
"DriveDisabled"=dword:00000001
"PasswordSharingEnabled"=dword:00000000
"PasswordLeakDetectionEnabled"=dword:00000000
"QuickAnswersEnabled"=dword:00000000
"SafeBrowsingExtendedReportingEnabled"=dword:00000000
"SafeBrowsingSurveysEnabled"=dword:00000000
"SafeBrowsingDeepScanningEnabled"=dword:00000000
"DeviceActivityHeartbeatEnabled"=dword:00000000
"DeviceMetricsReportingEnabled"=dword:00000000
"HeartbeatEnabled"=dword:00000000
"LogUploadEnabled"=dword:00000000
"ReportAppInventory"="00000000"
"ReportDeviceActivityTimes"=dword:00000000
"ReportDeviceAppInfo"=dword:00000000
"ReportDeviceSystemInfo"=dword:00000000
"ReportDeviceUsers"=dword:00000000
"ReportWebsiteTelemetry"=""
"BrowserGuestModeEnabled"=dword:0000000
"BuiltInDnsClientEnabled"=dword:00000000
"ParcelTrackingEnabled"=dword:00000000
"ShoppingListEnabled"=dword:00000000
"ControlDefaultStateOfAllowExtensionFromOtherStoresSettingEnabled"=dword:00000001
"BlockExternalExtensions"=dword:00000000
"GenAILocalFoundationalModelSettings"=dword:00000001
"LinkedAccountEnabled"=dword:00000000
"ProactiveAuthWorkflowEnabled"=dword:00000000
"WebToBrowserSignInEnabled"=dword:00000000
"EdgeManagementEnabled"=dword:00000000
"EdgeManagementExtensionsFeedbackEnabled"=dword:00000000
"MAMEnabled"=dword:00000000
"PasswordGeneratorEnabled"=dword:00000000
"PasswordRevealEnabled"=dword:00000000
"PasswordMonitorAllowed"=dword:00000000
"RelatedWebsiteSetsEnabled"=dword:00000000
"ScarewareBlockerProtectionEnabled"=dword:00000000
"SmartScreenEnabled"=dword:00000000
"SmartScreenPuaEnabled"=dword:00000000
"SmartScreenForTrustedDownloadsEnabled"=dword:00000000
"SmartScreenDnsRequestsEnabled"=dword:00000000
"NewTabPageAppLauncherEnabled"=dword:00000000
"NewTabPageBingChatEnabled"=dword:00000000
"NewTabPagePrerenderEnabled"=dword:00000000
"AADWebSiteSSOUsingThisProfileEnabled"=dword:00000000
"AccessibilityImageLabelsEnabled"=dword:00000000
"AIGenThemesEnabled"=dword:00000000
"AllowGamesMenu"=dword:00000000
"AmbientAuthenticationInPrivateModesEnabled"=dword:00000000
"AutomaticHttpsDefault"=dword:00000001
"BingAdsSuppression"=dword:00000001
"ComposeInlineEnabled"=dword:00000000
"CryptoWalletEnabled"=dword:00000000
"ExtensionManifestV2Availability"=dword:00000002
"ApplicationGuardTrafficIdentificationEnabled"=dword:00000000
"PasswordExportEnabled"=dword:00000000
"ExtensionsPerformanceDetectorEnabled"=dword:00000000
"PerformanceDetectorEnabled"=dword:00000000
"GamerModeEnabled"=dword:00000000
"SeamlessWebToBrowserSignInEnabled"=dword:00000000
"ImmersiveReaderGrammarToolsEnabled"=dword:00000000
"ImmersiveReaderPictureDictionaryEnabled"=dword:00000000
"ShoppingAssistantEnabled"=dword:00000000
"PriceComparisonEnabled"=dword:00000000
"SidebarEnabled"=dword:00000000
"PinnedToTaskbar"=dword:00000000
"CreateDesktopShortcutDefault"=dword:00000000
"RunAllTime"=dword:00000000
"MetricsReportingEnabled"=dword:00000000
"TrackingPrevention"=dword:00000003
"PromotionalTabsEnabled"=dword:00000000
"SpotlightExperiencesAndRecommendationsEnabled"=dword:00000000
"HardwareAccelerationModeEnabled"=dword:00000000
"NewTabPageLocation"="about:blank"
"EdgeHistoryAISearchEnabled"=dword:00000000
"BackgroundModeEnabled"=dword:00000000
"DiagnosticData"=dword:00000000
"ConfigureDoNotTrack"=dword:00000001
"ConfigureOnStartup"=dword:00000000
"PaymentMethodQueryEnabled"=dword:00000000
"PersonalizationReportingEnabled"=dword:00000000
"AddressBarMicrosoftSearchInBingProviderEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000
"AutofillCreditCardEnabled"=dword:00000000
"AutofillAddressEnabled"=dword:00000000
"LocalProvidersEnabled"=dword:00000000
"SearchSuggestEnabled"=dword:00000000
"EdgeShoppingAssistantEnabled"=dword:00000000
"WebWidgetAllowed"=dword:00000000
"HubsSidebarEnabled"=dword:00000000
"BrowserSignin"=dword:00000000
"MicrosoftEditorProofingEnabled"=dword:00000000
"ResolveNavigationErrorsUseWebService"=dword:00000000
"AlternateErrorPagesEnabled"=dword:00000000
"NetworkPredictionOptions"=dword:00000002
"PasswordManagerEnabled"=dword:00000000
"SiteSafetyServicesEnabled"=dword:00000000
"TyposquattingCheckerEnabled"=dword:00000000
"AutoImportAtFirstRun"=dword:00000004
"ShowRecommendationsEnabled"=dword:00000000
"HideFirstRunExperience"=dword:00000001
"FirstRunExperience"=dword:00000000
"PinBrowserEssentialsToolbarButton"=dword:00000000
"DefaultBrowserSettingEnabled"=dword:00000000
"EdgeFollowEnabled"=dword:00000000
"StandaloneHubsSidebarEnabled"=dword:00000000
"SyncDisabled"=dword:00000001
"HideRestoreDialogEnabled"=dword:00000001
"ShowMicrosoftRewards"=dword:00000000
"QuickSearchShowMiniMenu"=dword:00000000
"ImplicitSignInEnabled"=dword:00000000
"EdgeCollectionsEnabled"=dword:00000000
"SplitScreenEnabled"=dword:00000000
"SearchbarAllowed"=dword:00000000
"StartupBoostEnabled"=dword:00000000
"NewTabPageHideDefaultTopSites"=dword:00000001
"NewTabPageQuickLinksEnabled"=dword:00000000
"NewTabPageAllowedBackgroundTypes"=dword:00000003
"NewTabPageContentEnabled"=dword:00000000
"UpdateNotificationsAllowed"=dword:00000000
"ApplicationGuardFavoritesSyncEnabled"=dword:00000000
"ApplicationGuardPassiveModeEnabled"=dword:00000000
"ApplicationGuardUploadBlockingEnabled"=dword:00000000
"EdgeWorkspacesEnabled"=dword:00000000
"ReadAloudEnabled"=dword:00000000
"ShowAcrobatSubscriptionButton"=dword:00000000
"ShowOfficeShortcutInFavoritesBar"=dword:00000000
"SpellcheckEnabled"=dword:00000000
"TabServiceEnabled"=dword:00000000
"HttpsUpgradesEnabled"=dword:00000001
"NonRemovableProfileEnabled"=dword:00000000
"ProactiveAuthEnabled"=dword:00000000
"SearchInSidebarEnabled"=dword:00000002
"FavoritesBarEnabled"=dword:00000000
"GuidedSwitchEnabled"=dword:00000000
"EdgeDefaultProfileEnabled"="Default"
"BrowserAddProfileEnabled"=dword:00000000
"ConfigureOnPremisesAccountAutoSignIn"=dword:00000000
"ConfigureOnlineTextToSpeech"=dword:00000000
"ConfigureShare"=dword:00000000
"DefaultBrowserSettingsCampaignEnabled"=dword:00000000
"ImportOnEachLaunch"=dword:00000000
"LocalBrowserDataShareEnabled"=dword:00000000
"MSAWebSiteSSOUsingThisProfileAllowed"=dword:00000000
"PinningWizardAllowed"=dword:00000000
"QuickViewOfficeFilesEnabled"=dword:00000000
"RemoteDebuggingAllowed"=dword:00000000
"RoamingProfileSupportEnabled"=dword:00000000
"SearchForImageEnabled"=dword:00000000
"SearchFiltersEnabled"=dword:00000000
"SharedLinksEnabled"=dword:00000000
"TabServicesEnabled"=dword:00000000
"NewTabPageSearchBox"="redirect"
"PasswordProtectionWarningTrigger"=dword:00000000
"AskBeforeCloseEnabled"=dword:00000000
"AutofillMembershipsEnabled"=dword:00000000
"AADWebSSOAllowed"=dword:00000000
"AccessCodeCastEnabled"=dword:00000000
"AdsTransparencyEnabled"=dword:00000000
"EdgeAdminCenterEnabled"=dword:00000000
"SigninInterceptionEnabled"=dword:00000000
"SideSearchEnabled"=dword:00000000
"ShowPDFDefaultRecommendationsEnabled"=dword:00000000
"ShowHomeButton"=dword:00000000
"SafeBrowsingProxiedRealTimeChecksAllowed"=dword:00000000
"PasswordDismissCompromisedAlertEnabled"=dword:00000000
"DesktopSharingHubEnabled"=dword:00000000
"CopilotPageContextEnabled"=dword:00000000
"QRCodeGeneratorEnabled"=dword:00000000
"EdgeAutofillMlEnabled"=dword:00000000
"EdgeEntraCopilotPageContext"=dword:00000000
"MouseGestureEnabled"=dword:00000000
"DisableScreenshots"=dword:00000000
"WebCaptureEnabled"=dword:00000000
"AddressBarWorkSearchResultsEnabled"=dword:00000000
"AddressBarTrendingSuggestEnabled"=dword:00000000
"BuiltInAIAPIsEnabled"=dword:00000000
"AllowSystemNotifications"=dword:00000000
"AutoplayAllowed"=dword:00000000
"ClickOnceEnabled"=dword:00000000
"InternetExplorerIntegrationReloadInIEModeAllowed"=dword:00000000
"HideInternetExplorerRedirectUXForIncompatibleSitesEnabled"=dword:00000001
"Microsoft365CopilotChatIconEnabled"=dword:00000000
"HttpsOnlyMode"="force_enabled"
"LiveVideoTranslationEnabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\SyncTypesListDisabled]
"1"="favorites"
"2"="settings"
"3"="passwords"
"4"="addressesAndMore"
"5"="extensions"
"6"="history"
"7"="openTabs"
"8"="edgeWallet"
"9"="collections"
"10"="apps"
"11"="edgeFeatureUsage"

; block desktop shortcut for all edge channels
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"CreateDesktopShortcutDefault"=dword:00000000

; disable edge updates
[HKEY_CURRENT_USER\Software\Policies\Microsoft\EdgeUpdate]
"UpdateDefault"=dword:00000000

; disable auto-updates for all users
; prevent edge from staying up-to-date automatically
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"UpdateDefault"=dword:00000000
"AutoUpdateCheckPeriodMinutes"=dword:00000000

; block all update channels
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"Update{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}"=dword:00000000
"Update{2CD8A007-E189-4D47-B5A4-DD5A7A6D2766}"=dword:00000000
"Update{65C35B14-6C1D-4122-AC46-7148CC9D6497}"=dword:00000000

; disable Edge as default PDF viewer
[HKEY_CLASSES_ROOT\.pdf]
@="AcroExch.Document.DC"

[HKEY_CLASSES_ROOT\.pdf\OpenWithProgids]
"AppXd4nrz8ff68srnhf9t5a8sbjyar1cr723"=-

; Disable Edge update notifications
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\EdgeUpdate]
"UpdateDefault"=dword:00000000
"AutoUpdateCheckPeriodMinutes"=dword:00000000

; edge telemetry
[-HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run]
[-HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tree\Microsoft\Windows\UpdateOrchestrator\USO_UxBroker]

[HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\BooksLibrary]
"EnableExtendedBooksTelemetry"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\MicrosoftEdge\BooksLibrary]
"EnableExtendedBooksTelemetry"=dword:00000000

; dont send edge data
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection]
"MicrosoftEdgeDataOptIn"=dword:00000000

; edge preload
[HKEY_CURRENT_USER\Software\Policies\Microsoft\MicrosoftEdge\TabPreloader]
"AllowTabPreloading"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\TabPreloader]
"AllowTabPreloading"=dword:00000000

; force install uBlock origin and webrtc control extensions in edge
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge\ExtensionInstallForcelist]
"1"="odfafepnkmbhccpbejgmiehpchacaeak;https://edge.microsoft.com/extensionwebstorebase/v1/crx"
"2"="eepeadgljpkkjpbfecfkijnnliikglpl;https://edge.microsoft.com/extensionwebstorebase/v1/crx"




; CHROME
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Google\Chrome]
"StartupBoostEnabled"=dword:00000000
"HardwareAccelerationModeEnabled"=dword:00000000
"BackgroundModeEnabled"=dword:00000000
"HighEfficiencyModeEnabled"=dword:00000001
"DeviceMetricsReportingEnabled"=dword:00000000
"MetricsReportingEnabled"=dword:00000000
"ChromeCleanupReportingEnabled"=dword:00000000
"UserFeedbackAllowed"=dword:00000000
"WebRtcEventLogCollectionAllowed"=dword:00000000
"NetworkPredictionOptions"=dword:00000002 ; Disable DNS prefetching
"ChromeCleanupEnabled"=dword:00000000
"DefaultGeolocationSetting"=dword:00000002
"DefaultNotificationsSetting"=dword:00000002
"DefaultLocalFontsSetting"=dword:00000002
"DefaultSensorsSetting"=dword:00000002
"DefaultSerialGuardSetting"=dword:00000002
"CloudReportingEnabled"=dword:00000000
"DriveDisabled"=dword:00000001
"PasswordManagerEnabled"=dword:00000000
"PasswordSharingEnabled"=dword:00000000
"PasswordLeakDetectionEnabled"=dword:00000000
"QuickAnswersEnabled"=dword:00000000
"SafeBrowsingExtendedReportingEnabled"=dword:00000000
"SafeBrowsingSurveysEnabled"=dword:00000000
"SafeBrowsingDeepScanningEnabled"=dword:00000000
"DeviceActivityHeartbeatEnabled"=dword:00000000
"HeartbeatEnabled"=dword:00000000
"LogUploadEnabled"=dword:00000000
"ReportAppInventory"=""
"ReportDeviceActivityTimes"=dword:00000000
"ReportDeviceAppInfo"=dword:00000000
"ReportDeviceSystemInfo"=dword:00000000
"ReportDeviceUsers"=dword:00000000
"ReportWebsiteTelemetry"=""
"AlternateErrorPagesEnabled"=dword:00000000
"AutofillCreditCardEnabled"=dword:00000000
"BrowserGuestModeEnabled"=dword:00000000
"BrowserSignin"=dword:00000000
"BuiltInDnsClientEnabled"=dword:00000000
"DefaultBrowserSettingEnabled"=dword:00000000
"ParcelTrackingEnabled"=dword:00000000
"RelatedWebsiteSetsEnabled"=dword:00000000
"ShoppingListEnabled"=dword:00000000
"SyncDisabled"=dword:00000001
"ExtensionManifestV2Availability"=dword:00000002

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\GoogleChromeElevationService]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdate]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\gupdatem]
"Start"=dword:00000004




;FIREFOX
; Disable Firefox Telemetry
[HKEY_LOCAL_MACHINE\Software\Policies\Mozilla\Firefox]
"DisableTelemetry"=dword:00000001
"DisableDefaultBrowserAgent"=dword:00000001




; NVIDIA
; disable nvidia tray icon
[HKEY_CURRENT_USER\Software\NVIDIA Corporation\NvTray]
"StartOnLogin"=dword:00000000




; --CAN'T DO NATIVELY--




; UWP APPS
; disable background apps
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy]
"LetAppsRunInBackground"=dword:00000002

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications]
"GlobalUserDisabled"=dword:00000001

; disable windows input experience preload
[HKEY_CURRENT_USER\Software\Microsoft\input]
"IsInputAppPreloadEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Dsh]
"IsPrelaunchEnabled"=dword:00000000

; disable web search in start menu 
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer]
"DisableSearchBoxSuggestions"=dword:00000001

; disable copilot
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsCopilot]
"TurnOffWindowsCopilot"=dword:00000001

; disable Cortana
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\Windows Search]
"AllowCortana"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\Experience]
"AllowCortana"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortanaAboveLock"=dword:00000000

; disable widgets
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests]
"value"=dword:00000000

; disable ink workspace
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace]
"AllowWindowsInkWorkspace"=dword:00000000

; disable telemetry
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"AllowTelemetry"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics]
"EnabledExecution"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\Windows\DataCollection]
"LimitDiagnosticLogCollection"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Privacy]
"TailoredExperiencesWithDiagnosticDataEnabled"=dword:00000000

; disable activity history
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"EnableActivityFeed"=dword:00000000
"UploadUserActivities"=dword:00000000

; disbale Location [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
; "DisableLocation"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors]
; "DisableLocationScripting"=dword:00000001
; "DisableWindowsLocationProvider"=dword:00000001

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\System]
; "AllowExperimentation"=dword:00000000

; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}]
; "SensorPermissionState"=dword:00000000

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration]
; "Status"=dword:00000000

; Disable NCSI Active Probing
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\NetworkConnectivityStatusIndicator]
"NoActiveProbe"=dword:00000001




; NVIDIA
; enable old nvidia legacy sharpening
; old location
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\FTS]
"EnableGR535"=dword:00000000

; new location
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\nvlddmkm\Parameters\FTS]
"EnableGR535"=dword:00000000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\nvlddmkm\Parameters\FTS]
"EnableGR535"=dword:00000000




; POWER
; unpark cpu cores 
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583]
"ValueMax"=dword:00000000

; disable power throttling
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling]
; "PowerThrottlingOff"=dword:00000001

; disable hibernate
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
; "HibernateEnabled"=dword:00000000
; "HibernateEnabledDefault"=dword:00000000

; disable fast boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"HiberbootEnabled"=dword:00000000

; add maximum processor frequency
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\75b0ae3f-bce0-45a7-8c89-c9611c25e100]
"Attributes"=dword:00000002

; disable fast boot
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"HiberbootEnabled"=dword:00000000

; disable energy estimation & power saving
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
"EnergyEstimationEnabled"=dword:00000000
"EnergySaverPolicy"=dword:00000001

; disable connected standby
; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power]
; "CsEnabled"=dword:00000000

; disable away mode
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power]
"AwayModeEnabled"=dword:00000000




; DISABLE ADVERTISING & PROMOTIONAL
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager]
"ContentDeliveryAllowed"=dword:00000000
"FeatureManagementEnabled"=dword:00000000
"OemPreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEnabled"=dword:00000000
"PreInstalledAppsEverEnabled"=dword:00000000
"RotatingLockScreenEnabled"=dword:00000000
"RotatingLockScreenOverlayEnabled"=dword:00000000
"SilentInstalledAppsEnabled"=dword:00000000
"SlideshowEnabled"=dword:00000000
"SoftLandingEnabled"=dword:00000000
"SubscribedContent-310093Enabled"=dword:00000000
"SubscribedContent-314563Enabled"=dword:00000000
"SubscribedContent-338388Enabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000
"SubscribedContent-338389Enabled"=dword:00000000
"SubscribedContent-338393Enabled"=dword:00000000
"SubscribedContent-338393Enabled"=dword:00000000
"SubscribedContent-353694Enabled"=dword:00000000
"SubscribedContent-353694Enabled"=dword:00000000
"SubscribedContent-353696Enabled"=dword:00000000
"SubscribedContent-353696Enabled"=dword:00000000
"SubscribedContent-353698Enabled"=dword:00000000
"SubscribedContentEnabled"=dword:00000000
"SystemPaneSuggestionsEnabled"=dword:00000000




; OTHER
; remove 3d objects
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

[-HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}]

; remove quick access
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
; "HubMode"=dword:00000001

; remove home
[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{f874310e-b6b7-47dc-bc84-b9e6b38f5903}]

; remove gallery
[HKEY_CURRENT_USER\Software\Classes\CLSID\{e88865ea-0e1c-4e20-9aa6-edcd0212c87c}]
"System.IsPinnedToNameSpaceTree"=dword:00000000

; restore the classic context menu
[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; add "Take ownership" context menu to files and folders
[HKEY_CLASSES_ROOT\*\shell\TakeOwnership]
@="Take ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\*\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""
"IsolatedCommand"= "powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l & pause' -Verb runAs\""


[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership]
@="Take ownership"
"HasLUAShield"=""
"NoWorkingDirectory"=""
"NeverDefault"=""

[HKEY_CLASSES_ROOT\Directory\shell\TakeOwnership\command]
@="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" /r /d y && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause' -Verb runAs\""
"IsolatedCommand"="powershell -windowstyle hidden -command \"Start-Process cmd -ArgumentList '/c takeown /f \\\"%1\\\" /r /d y && icacls \\\"%1\\\" /grant *S-1-3-4:F /t /c /l /q & pause' -Verb runAs\""

; disable menu show delay
[HKEY_CURRENT_USER\Control Panel\Desktop]
"MenuShowDelay"="0"

; disable driver searching & updates
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching]
"SearchOrderConfig"=dword:00000000

; mouse fix (no accel with epp on)
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	C0,CC,0C,00,00,00,00,00,\
	80,99,19,00,00,00,00,00,\
	40,66,26,00,00,00,00,00,\
	00,33,33,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; enable endtask menu taskbar w11
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarDeveloperSettings]
"TaskbarEndTask"=dword:00000001

; enable win32 long paths
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"LongPathsEnabled"=dword:00000001

; remove 'Open in Windows Terminal' in win 11
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=""

; remove share context menu
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"="Share"

; remove add to favourites context menu
[-HKEY_CLASSES_ROOT\*\shell\pintohomefile]

; hide insider program page
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsSelfHost\UI\Visibility]
"HideInsiderPage"=dword:00000001

; remove shortcut arrow overlay icon 
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons]
"29"="C:\\Windows\\blanc.ico"

; Clear icon cache
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"Start_ShowRecentDocs"=dword:00000001
"Start_TrackDocs"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"Shell Icons"=-

; disable the " - shortcut" text for shortcuts
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\NamingTemplates]
"ShortcutNameTemplate"="\"%s.lnk\""

; set "Do this for all current items" checked by default
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager]
"ConfirmationCheckBoxDoForAll"=dword:00000001

; disable automatic folder type discovery
[-HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags]

[HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags\AllFolders\Shell]
"FolderType"="NotSpecified"

; Show Drive letters before labels
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"ShowDriveLettersFirst"=dword:00000004

; enable network drives over uac [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
; "EnableLinkedConnections"=dword:00000001
; "LocalAccountTokenFilterPolicy"=dword:00000001
; "EnableVirtualization"=dword:00000000

; [HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa]
; "DisableLoopbackCheck"=dword:00000001

; onedrive
; disable onedrive user folder backup [ optional ]
; [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\OneDrive]
; "KFMBlockOptIn"=dword:00000001

; hide onedrive folder
[-HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

[-HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}]
"System.IsPinnedToNameSpaceTree"=dword:0

; hide lock screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI\SessionData]
"AllowLockScreen"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Personalization]
"NoLockScreen"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search]
"AllowCortanaAboveLock"=dword:00000000

; disable automatic registry backup
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Configuration Manager]
"EnablePeriodicBackup"=dword:00000000

; disable "Look for an app in the Store" notification
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Explorer]
"NoUseStoreOpenWith"=dword:00000001

; disable downloaded files from being blocked in file explorer
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Attachments]
"SaveZoneInformation"=dword:00000001

; disable mark-of-the-web (MOTW) for downloaded files
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\AttachmentManager]
"ScanWithAntiVirus"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Associations]
"LowRiskFileTypes"=".exe;.msi;.bat;.cmd;.ps1;.js;.vbs"

; disable protected view for office files
[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Word\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000001

[HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Excel\Security\ProtectedView]
"DisableInternetFilesInPV"=dword:00000001

; disable malicious software removal tool from installing
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MRT]
"DontOfferThroughWUAU"=dword:00000001

; disable live tiles
[HKEY_CURRENT_USER\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications]
"NoTileApplicationNotification"=dword:00000001

; increase wallpaper quallity
[HKEY_CURRENT_USER\Control Panel\Desktop]
"JPEGImportQuality"=dword:00000063

; enable windows installer in safe Mode
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Network\MSIServer]
@="Service"

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SafeBoot\Minimal\MSIServer]
@="Service"

; change the timeout for disk auto check to 5 seconds
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager]
"AutoChkTimeout"=dword:00000005

; disable blur on sign-in screen
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System]
"DisableAcrylicBackgroundOnLogon"=dword:00000001

; disable settings home
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"SettingsPageVisibility"="hide:home"

; disable consumer features
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\CloudContent]
"DisableSoftLanding"=dword:00000001
"DisableConsumerFeatures"=dword:00000001
"DisableWindowsConsumerFeatures"=dword:00000001
"DisableConsumerAccountStateContent"=dword:00000001

; disable homegroup
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupListener]
"Start"=dword:00000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\HomeGroupProvider ]
"Start"=dword:00000004

; disable wifi-sense
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"AllowWiFiHotSpotReporting"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting]
"Value"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots]
"Value"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots]
"Enabled"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config]
"AutoConnectAllowedOEM"=dword:00000000

; disable ai features
[HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\WindowsAI]
"DisableAIDataAnalysis"=dword:00000001

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\WindowsAI]
"DisableAIDataAnalysis"=dword:00000001
"AllowRecallEnablement"=dword:00000000

; disable NumLock on startup
[HKEY_USERS\.DEFAULT\Control Panel\Keyboard]
"InitialKeyboardIndicators"=dword:"0"

; enable verbose messages during logon
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"VerboseStatus"=dword:00000001

; disable thumbnail cache
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced]
"DisableThumbnailCache"=dword:00000001

; close apps automatically on shutdown
[HKEY_CURRENT_USER\Control Panel\Desktop]
"AutoEndTasks"="1"
"HungAppTimeout"="1000"
"WaitToKillAppTimeout"="1000"
"LowLevelHooksTimeout"="1000"

; set audiodg priority to high
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\audiodg.exe\PerfOptions]
"CpuPriorityClass"=dword:00000003
"IoPriority"=dword:00000003

; fix mouse cursor dissapeiring
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System]
"EnableCursorSuppression"=dword:00000000

; disable tablet mode
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ImmersiveShell]
"TabletMode"=dword:00000000
"SignInMode"=dword:00000001

; disables push to install feature
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\PushToInstall]
"DisablePushToInstall"=dword:00000001

; Prevent Print Spooler to start automatically with windows
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\Spooler]
"Start"=dword:00000003

; Disable Windows Search Indexing
[HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\WSearch]
"Start"=dword:00000004

; Allow double-click execution of .ps1 files (Windows PowerShell)
[HKEY_CLASSES_ROOT\Applications\powershell.exe\shell\open\command]
@="C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -NoLogo -ExecutionPolicy Unrestricted -File \"%1\""

; Allow double-click execution of .ps1 files (PowerShell 7)
[HKEY_CLASSES_ROOT\Applications\pwsh.exe\shell\open\command]
@="C:\\Program Files\\PowerShell\\7\\pwsh.exe -NoLogo -ExecutionPolicy Unrestricted -File \"%1\""




; Created by: Shawn Brink
; Created on: September 28th 2015
; Updated on: August 28th 2019
; Tutorial: https://www.tenforums.com/tutorials/24412-add-remove-default-new-context-menu-items-windows-10-a.html


; Text Document
[-HKEY_CLASSES_ROOT\.txt\ShellNew]
[HKEY_CLASSES_ROOT\.txt\ShellNew]
"ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
  6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
  00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\
  2d,00,34,00,37,00,30,00,00,00
"NullFile"=""


[-HKEY_CLASSES_ROOT\.txt]

[HKEY_CLASSES_ROOT\.txt]
@="txtfile"
"Content Type"="text/plain"
"PerceivedType"="text"

[HKEY_CLASSES_ROOT\.txt\PersistentHandler]
@="{5e941d80-bf96-11cd-b579-08002b30bfeb}"

[HKEY_CLASSES_ROOT\.txt\ShellNew]
"ItemName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,\
  6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,\
  00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,2c,00,\
  2d,00,34,00,37,00,30,00,00,00
"NullFile"=""

[-HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]

[HKEY_CLASSES_ROOT\SystemFileAssociations\.txt]
"PerceivedType"="document"

[-HKEY_CLASSES_ROOT\txtfile]

[HKEY_CLASSES_ROOT\txtfile]
@="Text Document"
"EditFlags"=dword:00210000
"FriendlyTypeName"=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,\
  00,6f,00,6f,00,74,00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,\
  32,00,5c,00,6e,00,6f,00,74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,\
  00,2c,00,2d,00,34,00,36,00,39,00,00,00

[HKEY_CLASSES_ROOT\txtfile\DefaultIcon]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,69,00,6d,00,\
  61,00,67,00,65,00,72,00,65,00,73,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,31,\
  00,30,00,32,00,00,00

[HKEY_CLASSES_ROOT\txtfile\shell\open\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,4e,00,4f,00,\
  54,00,45,00,50,00,41,00,44,00,2e,00,45,00,58,00,45,00,20,00,25,00,31,00,00,\
  00

[HKEY_CLASSES_ROOT\txtfile\shell\print\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,4e,00,4f,00,\
  54,00,45,00,50,00,41,00,44,00,2e,00,45,00,58,00,45,00,20,00,2f,00,70,00,20,\
  00,25,00,31,00,00,00

[HKEY_CLASSES_ROOT\txtfile\shell\printto\command]
@=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
  00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,6e,00,6f,00,\
  74,00,65,00,70,00,61,00,64,00,2e,00,65,00,78,00,65,00,20,00,2f,00,70,00,74,\
  00,20,00,22,00,25,00,31,00,22,00,20,00,22,00,25,00,32,00,22,00,20,00,22,00,\
  25,00,33,00,22,00,20,00,22,00,25,00,34,00,22,00,00,00

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithList]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\OpenWithProgids]
"txtfile"=hex(0):

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.txt\UserChoice]
"Hash"="hyXk/CpboWw="
"ProgId"="txtfile"

[-HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Roaming\OpenWith\FileExts\.txt\UserChoice]
"Hash"="FvJcqeZpmOE="
"ProgId"="txtfile"




; MEDIA PLAYER

; Disabling Media Player telemetry
[HKEY_CURRENT_USER\Software\Policies\Microsoft\WindowsMediaPlayer]
"PreventCDDVDMetadataRetrieval"=dword:00000001
"PreventMusicFileMetadataRetrieval"=dword:00000001
"PreventRadioPresetsRetrieval"=dword:00000001


; Created by imribiy
; https://github.com/imribiy
; https://discord.gg/XTYEjZNPgX

; This reg file automatically applies Media Player setup phase as you would like to complete, no document history, no data sharing. Can be implemented to the ISOs.

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Health]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Skins]
"LastViewModeVTen"=dword:00000002
"SkinX"=dword:00000000
"SkinY"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Skins\res://wmploc/RT_TEXT/player.wsz]
"Prefs"="currentMetadataIconV11;0;FirstRun;0;ap;False;max;False"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Tasks]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Player\Tasks\NowPlaying]
"InitFlags"=dword:00000001
"ShowHorizontalSeparator"=dword:00000001
"ShowVerticalSeparator"=dword:00000001
"PlaylistWidth"=dword:000000ba
"PlaylistHeight"=dword:00000064
"SettingsWidth"=dword:00000064
"SettingsHeight"=dword:00000087
"MetadataWidth"=dword:000000ba
"MetadataHeight"=dword:000000a0
"CaptionsHeight"=dword:00000064

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences]
"AutoMetadataCurrent503ServerErrorCount"=dword:00000000
"AutoMetadataCurrentOtherServerErrorCount"=dword:00000000
"AutoMetadataCurrentNetworkErrorCount"=dword:00000000
"AutoMetadataLastResetTime"=dword:293e214e
"SyncPlaylistsAdded"=dword:00000001
"MLSChangeIndexMusic"=dword:00000000
"MLSChangeIndexVideo"=dword:00000000
"MLSChangeIndexPhoto"=dword:00000000
"MLSChangeIndexList"=dword:00000000
"MLSChangeIndexOther"=dword:00000000
"LibraryHasBeenRun"=dword:00000000
"FirstRun"=dword:00000000
"NextLaunchIndex"=dword:00000002
"XV11"="256"
"YV11"="144"
"WidthV11"="2048"
"HeightV11"="1152"
"Maximized"="0"
"Volume"=dword:00000032
"ModeShuffle"=dword:00000000
"DisableMRUMusic"=dword:00000001
"Mute"=dword:00000000
"Balance"=dword:00000000
"CurrentEffectType"="Bars"
"CurrentEffectPreset"=dword:00000003
"VideoZoom"=dword:00000064
"AutoMetadataCurrent500ServerErrorCount"=dword:00000000
"StretchToFit"=dword:00000001
"ShowEffects"=dword:00000001
"ShowFullScreenPlaylist"=dword:00000000
"NowPlayingQuickHide"=dword:00000000
"ShowTitles"=dword:00000001
"ShowCaptions"=dword:00000000
"NowPlayingPlaylist"=dword:00000001
"NowPlayingMetadata"=dword:00000001
"NowPlayingSettings"=dword:00000000
"CurrentDisplayView"="VideoView"
"CurrentSettingsView"="EQView"
"CurrentMetadataView"="MediaInfoView"
"CurrentDisplayPreset"=dword:00000000
"CurrentSettingsPreset"=dword:00000000
"CurrentMetadataPreset"=dword:00000000
"UserDisplayView"="VizView"
"UserWMPDisplayView"="VizView"
"UserWMPSettingsView"="EQView"
"UserWMPMetadataView"="MediaInfoView"
"UserDisplayPreset"=dword:00000000
"UserWMPDisplayPreset"=dword:00000000
"UserWMPSettingsPreset"=dword:00000000
"UserWMPMetadataPreset"=dword:00000000
"UserWMPShowSettings"=dword:00000000
"UserWMPShowMetadata"=dword:00000000
"ShowAlbumArt"=dword:00000000
"AutoMetadataCurrentDownloadCount"=dword:00000000
"MediaLibraryCreateNewDatabase"=dword:00000000
"TranscodedFilesCacheDefaultSizeSet"=dword:00000001
"TranscodedFilesCacheSize"=dword:00002a5e
"LastScreensaverTimeout"=dword:00003a98
"LastScreensaverState"=dword:00000005
"LastScreensaverSetThreadExecutionState"=dword:80000003
"AppColorLimited"=dword:00000000
"SQMLaunchIndex"=dword:00000001
"LaunchIndex"=dword:00000001
"DisableMRUVideo"=dword:00000001
"DisableMRUPlaylists"=dword:00000001
"ShrinkToFit"=dword:00000000
"DisableMRUPictures"=dword:00000001
"UsageTracking"=dword:00000000
"SilentAcquisition"=dword:00000000
"SendUserGUID"=hex(3):00
"MetadataRetrieval"=dword:00000000
"AcceptedPrivacyStatement"=dword:00000001
"ModeLoop"=dword:00000000

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\EqualizerSettings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\HME]
"LocalLibraryID"="{95ADD7BE-43A3-4FD9-A4C8-453B88711A10}"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\ProxySettings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\ProxySettings\HTTP]
"ProxyName"=""
"ProxyPort"=dword:00000050
"ProxyExclude"=""
"ProxyBypass"=dword:00000000
"ProxyStyle"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\ProxySettings\RTSP]
"ProxyStyle"=dword:00000000
"ProxyName"=""
"ProxyPort"=dword:0000022a
"ProxyBypass"=dword:00000000
"ProxyExclude"=""

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\Preferences\VideoSettings]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{1F32514F-1561-4922-A604-8A1F478B5A42}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{52903d79-f993-4de6-8317-20c9c176d823}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{5DF031B7-6A37-42D9-8802-E27F4F224332}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{5F4BB5C9-4652-489B-8601-EEC0C3C32E2E}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{7F2B1D6B-1357-402C-A1C8-67E59583B41D}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{93075F62-16B3-43EC-A53B-FFAD0E01D5E7}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{9695AEF9-9D03-4671-8F2F-FF49D1BB01C4}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{976ABECA-93F7-4d81-9187-2A6137829675}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{99DB05E3-F81E-4C8A-A252-F396306AB6FE}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{9F9562EB-15B6-46C6-A7CB-0A66FC65130E}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{9FA014E3-076F-4865-A73C-117131B8E292}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{C1B5977D-9801-4D80-8592-143A044568AF}]
"AttemptedAutoRun"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{D5E49195-ED19-40fb-9EE0-E6625A808B77}]
"AttemptedAutoRun"=dword:00000001

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{E641D09E-E500-4c09-8260-F1CD7B902E9C}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{F24A1BC2-2331-4B91-8A13-5A549DA56E9D}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\MediaPlayer\UIPlugins\{FD981763-B6BB-4d51-9143-6D372A0ED56F}]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media\WMSDK]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media\WMSDK\General]
"UniqueID"="{326EA348-9669-4511-8B5D-82373066F6FB}"
"VolumeSerialNumber"=dword:5acb5c10
"ComputerName"="XOS"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows Media\WMSDK\Namespace]
"DTDFile"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNS.DTD"
"LocalDelta"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNSD.XML"
"RemoteDelta"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNSR.XML"
"LocalBase"="C:\\Users\\Administrator\\AppData\\Local\\Microsoft\\Windows Media\\12.0\\WMSDKNS.XML"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\JumplistData]
"Microsoft.Windows.MediaPlayer32"=hex(b):E8,DF,57,F3,0D,E9,D7,01

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/vnd.ms-wpl]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/vnd.ms-wpl\UserChoice]
"Progid"="WMP11.AssocMIME.WPL"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-mplayer2]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-mplayer2\UserChoice]
"Progid"="WMP11.AssocMIME.ASF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmd]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmd\UserChoice]
"Progid"="WMP11.AssocMIME.WMD"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmz]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\application/x-ms-wmz\UserChoice]
"Progid"="WMP11.AssocMIME.WMZ"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp2]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp2\UserChoice]
"Progid"="WMP11.AssocMIME.3G2"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/3gpp\UserChoice]
"Progid"="WMP11.AssocMIME.3GP"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/aiff]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/aiff\UserChoice]
"Progid"="WMP11.AssocMIME.AIFF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/basic]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/basic\UserChoice]
"Progid"="WMP11.AssocMIME.AU"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mid]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mid\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/midi]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/midi\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp3]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp3\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp4]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mp4\UserChoice]
"Progid"="WMP11.AssocMIME.M4A"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpegurl]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpegurl\UserChoice]
"Progid"="WMP11.AssocMIME.M3U"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/mpg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/vnd.dlna.adts]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/vnd.dlna.adts\UserChoice]
"Progid"="WMP11.AssocMIME.ADTS"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/wav]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/wav\UserChoice]
"Progid"="WMP11.AssocMIME.WAV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-aiff]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-aiff\UserChoice]
"Progid"="WMP11.AssocMIME.AIFF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-flac]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-flac\UserChoice]
"Progid"="WMP11.AssocMIME.FLAC"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-matroska]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-matroska\UserChoice]
"Progid"="WMP11.AssocMIME.MKA"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mid]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mid\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-midi]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-midi\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mp3]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mp3\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpegurl]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpegurl\UserChoice]
"Progid"="WMP11.AssocMIME.M3U"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-mpg\UserChoice]
"Progid"="WMP11.AssocMIME.MP3"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wax]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wax\UserChoice]
"Progid"="WMP11.AssocMIME.WAX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wma]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-ms-wma\UserChoice]
"Progid"="WMP11.AssocMIME.WMA"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-wav]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\audio/x-wav\UserChoice]
"Progid"="WMP11.AssocMIME.WAV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\midi/mid]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\midi/mid\UserChoice]
"Progid"="WMP11.AssocMIME.MIDI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp2]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp2\UserChoice]
"Progid"="WMP11.AssocMIME.3G2"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/3gpp\UserChoice]
"Progid"="WMP11.AssocMIME.3GP"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/avi]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/avi\UserChoice]
"Progid"="WMP11.AssocMIME.AVI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mp4]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mp4\UserChoice]
"Progid"="WMP11.AssocMIME.MP4"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/mpg\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/msvideo]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/msvideo\UserChoice]
"Progid"="WMP11.AssocMIME.AVI"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/quicktime]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/quicktime\UserChoice]
"Progid"="WMP11.AssocMIME.MOV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/vnd.dlna.mpeg-tts]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/vnd.dlna.mpeg-tts\UserChoice]
"Progid"="WMP11.AssocMIME.TTS"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska-3d]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska-3d\UserChoice]
"Progid"="WMP11.AssocMIME.MK3D"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-matroska\UserChoice]
"Progid"="WMP11.AssocMIME.MKV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg2a]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg2a\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-mpeg\UserChoice]
"Progid"="WMP11.AssocMIME.MPEG"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf-plugin]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf-plugin\UserChoice]
"Progid"="WMP11.AssocMIME.ASX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-asf\UserChoice]
"Progid"="WMP11.AssocMIME.ASX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wm]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wm\UserChoice]
"Progid"="WMP11.AssocMIME.ASF"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmv]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmv\UserChoice]
"Progid"="WMP11.AssocMIME.WMV"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmx]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wmx\UserChoice]
"Progid"="WMP11.AssocMIME.ASX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wvx]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-ms-wvx\UserChoice]
"Progid"="WMP11.AssocMIME.WVX"

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-msvideo]

[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\MIMEAssociations\video/x-msvideo\UserChoice]
"Progid"="WMP11.AssocMIME.AVI"

; prevent-media-sharing
[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\WindowsMediaPlayer]
"PreventLibrarySharing"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsMediaPlayer]
"PreventLibrarySharing"=dword:00000001

;prevent-windows-media-drm-internet-access-reg
[HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WMDRM]
"DisableOnline"=dword:00000001

[HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Policies\Microsoft\WMDRM]
"DisableOnline"=dword:00000001




; POWERSHELL
; allow powershell scripts
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell]
"ExecutionPolicy"="Unrestricted"

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell]
"ExecutionPolicy"="Unrestricted"
'@

	# Signout Lockscreen
	Write-Output "Setting signout Lockscreen black..."
	# create new image
	Add-Type -AssemblyName System.Windows.Forms
	$screenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
	$screenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height
	Add-Type -AssemblyName System.Drawing
	$file = "C:\Windows\Black.jpg"
	$edit = New-Object System.Drawing.Bitmap $screenWidth, $screenHeight
	$color = [System.Drawing.Brushes]::Black
	$graphics = [System.Drawing.Graphics]::FromImage($edit)
	$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
	$graphics.Dispose()
	$edit.Save($file)
	$edit.Dispose()
	# set image settings
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v "LockScreenImagePath" /t REG_SZ /d "C:\Windows\Black.jpg" /f | Out-Null
	reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP" /v "LockScreenImageStatus" /t REG_DWORD /d "1" /f | Out-Null

	# Unpin all taskbar icons
	# Write-Output "Unpinning all taskbar icons..."
	# cmd /c "reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Taskband /f >nul 2>&1"
	# Remove-Item -Recurse -Force "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch" | Out-Null
	# New-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar" -ItemType Directory -Force | Out-Null
	# New-Item "$env:USERPROFILE\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\ImplicitAppShortcuts" -ItemType Directory -Force | Out-Null

	# Disable BitLocker
	Write-Output "Disabling BitLocker..."
	# Disable BitLocker on C:
	Disable-BitLocker -MountPoint "C:" 2>&1 | Out-Null
	# Disable Device Encryption via registry
	New-Item -Path "HKLM:\System\CurrentControlSet\Control" -Name "BitLocker" -Force 2>&1 | Out-Null
	Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\BitLocker" -Name "PreventDeviceEncryption" -Type DWord -Value 1
	# Disable EFS (Encrypting File System)
	fsutil behavior set disableencryption 1 | Out-Null
	# Additional BitLocker policy: Disable External DMA Under Lock
	New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft" -Name "FVE" -Force | Out-Null
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\FVE" -Name "DisableExternalDMAUnderLock" -Type DWord -Value 1

	# Disable Startup apps
 	Write-Output "Disabling Startup apps..."
 	cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\RunNotification`" /f >nul 2>&1"
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunNotification" /f | Out-Null
	cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`" /f >nul 2>&1"
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f | Out-Null
	cmd /c "reg delete `"HKCU\Software\Microsoft\Windows\CurrentVersion\Run`" /f >nul 2>&1"
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /f | Out-Null
	cmd /c "reg delete `"HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce`" /f >nul 2>&1"
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\RunOnce" /f | Out-Null
	cmd /c "reg delete `"HKLM\Software\Microsoft\Windows\CurrentVersion\Run`" /f >nul 2>&1"
	reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /f | Out-Null
	cmd /c "reg delete `"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce`" /f >nul 2>&1"
	reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\RunOnce" /f | Out-Null
	cmd /c "reg delete `"HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run`" /f >nul 2>&1"
	reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Run" /f | Out-Null
	cmd /c "reg delete `"HKLM\Software\Microsoft\Active Setup\Installed Components\{9459C573-B17A-45AE-9F64-1857B5D58CEE}`" /f >nul 2>&1"
	$startupApps = Get-WmiObject -Class Win32_StartupCommand | Select-Object -ExpandProperty Caption
	foreach ($app in $startupApps) {
	    if ([string]::IsNullOrWhiteSpace($app)) { continue }
	    $appTrimmed = $app.TrimEnd()
	    $regPaths = @(
	        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run",
	        "HKLM:\Software\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run"
	    )
	    foreach ($regPath in $regPaths) {
	        if (Get-ItemProperty -Path $regPath -Name $appTrimmed) {
	            $binaryValue = [byte[]](0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00)
	            Set-ItemProperty -Path $regPath -Name $appTrimmed -Value $binaryValue -Type Binary -Force
	        }
	    }
	} 

	# Unlock all power settings options
	Get-ChildItem 'HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerSettings' -Recurse | ForEach-Object { if (Get-ItemProperty $_.PSPath -Name Attributes) { Set-ItemProperty $_.PSPath -Name Attributes -Value 0 } }
	
	# Group svchost.exe processes
 	Write-Output "Grouping svchost.exe processes..."
	$ram = (Get-CimInstance -ClassName Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum / 1kb; Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control" -Name "SvcHostSplitThresholdInKB" -Type DWord -Value $ram -Force
	
	# Enable MSI Mode on all supported Drivers
	Write-Output "Enabling MSI Mode on all supported Drivers..."
	$gpuDevices = Get-PnpDevice -Class Display
	foreach ($gpu in $gpuDevices) {
		$instanceID = $gpu.InstanceId
		reg add "HKLM\SYSTEM\ControlSet001\Enum\$instanceID\Device Parameters\Interrupt Management\MessageSignaledInterruptProperties" /v "MSISupported" /t REG_DWORD /d "1" /f | Out-Null
	}
	
	# Fix VMware Tools if present
	if (Test-Path "C:\Program Files\VMware\VMware Tools\vmtoolsd.exe") { 
 		Write-Output "Fixing VMware Tools..."
  		Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "VMware User Process" -Value '"C:\Program Files\VMware\VMware Tools\vmtoolsd.exe" -n vmusr' | Out-Null
	}	
	
	# Disables automatic disk defragmentation
	Write-Output "Disabling automatic disk defragmentation..."
	schtasks /Change /DISABLE /TN "\Microsoft\Windows\Defrag\ScheduledDefrag" | Out-Null
 	
	# Allow double-click of .ps1 files
	Write-Output "Allowing double-click execution of .ps1 files ..."
	# powershell.exe
	if (-not (Test-Path $regPath)) {
    	New-Item -Path 'HKCR:\Applications\powershell.exe\shell\open\command' -Force | Out-Null
	}
 	Set-ItemProperty -Path 'HKCR:\Applications\powershell.exe\shell\open\command' -Name '(default)' -Value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -NoLogo -ExecutionPolicy Unrestricted -File "%1"'	

	# Set account password to never expires
	Write-Output "Setting account password to never expires..."
	Get-LocalUser | ForEach-Object { Set-LocalUser -Name $_.Name -PasswordNeverExpires $true | Out-Null }
  	
	Write-Output "Applying miscellaneous Registry tweaks..."
	# Download blanc.ico into C:\Windows
	Invoke-WebRequest -Uri "https://github.com/benzaria/remove_shortcut_arrow/raw/refs/heads/main/blanc.ico" -OutFile "C:\\Windows\\blanc.ico"

	Set-Content -Path "$env:TEMP\RegistryOptimize.reg" -Value $MultilineComment -Force	
  	# edit reg file
	$path = "$env:TEMP\RegistryOptimize.reg"
	(Get-Content $path) -replace "\?","$" | Out-File $path
	# import reg file
	Regedit.exe /S "$env:TEMP\RegistryOptimize.reg"
}