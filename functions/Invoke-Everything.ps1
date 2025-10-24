# Install or upgrade Everything Search
function Invoke-Everything {
    Write-Host "Installing Everything (Search)..." -ForegroundColor Green

    $installer = "$env:TEMP\EverythingSetup.exe"
    Get-FileFromWeb "https://www.voidtools.com/Everything-1.4.1.1019.x64-Setup.exe" -File $installer

    Start-Process -FilePath $installer -ArgumentList '/S' -Wait -PassThru | Out-Null

    # Rename Start Menu shortcut and remove desktop shortcut
	$startMenu = Join-Path $env:ProgramData 'Microsoft\Windows\Start Menu\Programs'
	$search     = Join-Path $startMenu 'Search.lnk'
	$everything = Join-Path $startMenu 'Everything.lnk'

	if (Test-Path $search) {Remove-Item $everything -Force}
	elseif (Test-Path $everything) {Rename-Item $everything 'Search.lnk' -Force}

    $f2 = "$env:PUBLIC\Desktop\Everything.lnk"
    if (Test-Path $f2) { Remove-Item $f2 -Force }
<#
	Pin Everything.exe to the Taskbar Using PS-TBPin https://github.com/DanysysTeam/PS-TBPin (Flag by AV)
	powershell -ExecutionPolicy Bypass -command "& { 
		[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
		Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/DanysysTeam/PS-TBPin/main/TBPin.ps1'))
		Add-TaskbarPin 'C:\Program Files\Everything\Everything.exe' 
	}"
#>
    # Disable Windows Search
    Stop-Service -Name WSearch -Force
    Set-Service -Name WSearch -StartupType Disabled

	# Disable Search Engine (breaks Search App)
	# Dism /Online /NoRestart /Disable-Feature /FeatureName:SearchEngine-Client-Package | Out-Null
}