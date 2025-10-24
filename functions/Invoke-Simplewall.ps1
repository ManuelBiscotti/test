function Invoke-Simplewall {
	Write-Output "Installing simplewall..."
	# Define paths
	$s = "$env:ProgramFiles\simplewall\simplewall.exe"

	# Get latest simplewall release URL
	$url = (Invoke-RestMethod "https://api.github.com/repos/henrypp/simplewall/releases/latest" -Headers @{ 'User-Agent' = 'PowerShell' }).assets |
		Where-Object { $_.name -like '*.exe' } |
		Select-Object -First 1 -ExpandProperty browser_download_url

	# Download installer
	$exe = "$env:TEMP\simplewall_latest.exe"
	Invoke-WebRequest $url -OutFile $exe -UseBasicParsing

	# Silent install
	Start-Process $exe -ArgumentList '/S' -Wait

	# Enable filters silently (no prompt)
	if (Test-Path $s) {
		Start-Process $s -ArgumentList "-install -silent" -Wait

		# Create Start Menu shortcut
		$WshShell = New-Object -ComObject WScript.Shell
		$Shortcut = $WshShell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\simplewall.lnk")
		$Shortcut.TargetPath = $s
		$Shortcut.WorkingDirectory = "C:\Program Files\simplewall"
		$Shortcut.Save()

		# Create Task Scheduler entry for autostart without UAC
		$taskXml = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.6" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Author>Henry++</Author>
    <URI>\simplewallTask</URI>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <RunLevel>HighestAvailable</RunLevel>
      <UserId>$env:USERDOMAIN\$env:USERNAME</UserId>
      <LogonType>InteractiveToken</LogonType>
    </Principal>
  </Principals>
  <Settings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command>$s</Command>
      <Arguments>-minimized</Arguments>
      <WorkingDirectory>C:\Program Files\simplewall</WorkingDirectory>
    </Exec>
  </Actions>
</Task>
"@

		$xmlFile = "$env:TEMP\simplewallTask.xml"
		$taskXml | Out-File -FilePath $xmlFile -Encoding Unicode

		schtasks /Create /TN "simplewallTask" /XML $xmlFile /F
	}

	# Define target path
	$iniPath = "C:\Users\Admin\AppData\Roaming\Henry++\simplewall\simplewall.ini"
	$iniFolder = Split-Path $iniPath

	# Ensure the folder exists
	if (-not (Test-Path $iniFolder)) {
    	New-Item -ItemType Directory -Path $iniFolder -Force | Out-Null
	}

# Define INI content
$iniContent = @"
[simplewall]
CurrentTab=106
CheckUpdatesLast=1757973471
BackupTimestamp=1757960368
WF_State=true
IsWUFixEnabled=true
IsStartMinimized=true
IsDarkThemeEnabled=false
CheckUpdatesPeriod=0
BlocklistUpdateState=1
[simplewall\notification]
Position=712,340
[simplewall\window]
IsMaximized=false
Position=691,327
Size=538,378
"@
	# Write INI file forcefully
	$iniContent | Set-Content -Path $iniPath -Encoding UTF8 -Force
}