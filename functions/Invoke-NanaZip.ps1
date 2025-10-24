###########
# NanaZip #
function Invoke-NanaZip {
	
	<#
		.SYNOPSIS
		
		.DESCRIPTION
	#>
	
	Get-FileFromWeb -Url "https://github.com/M2Team/NanaZip/releases/download/5.0.1263.0/NanaZip_5.0.1263.0.msixbundle" -File "$env:TEMP\NanaZip_5.0.1263.0.msixbundle"
	PowerShell -NoLogo -NoProfile -NonInteractive -InputFormat None -ExecutionPolicy Bypass Add-AppxPackage -DeferRegistrationWhenPackagesAreInUse -ForceUpdateFromAnyVersion -Path "$env:TEMP\NanaZip_5.0.1263.0.msixbundle"
}

# Install or upgrade VLC Media Player
function Invoke-VLC {
    Write-Host "Installing VLC..." -ForegroundColor Green

    $vlcPath = Join-Path $env:TEMP 'vlc-win64.exe'

    # Download VLC
    Get-FileFromWeb -URL 'https://download.videolan.org/pub/videolan/vlc/last/win64/vlc-3.0.21-win64.exe' -File $vlcPath

    # Silent install
    Start-Process -FilePath $vlcPath -ArgumentList '/S' -Wait

    # Delete VLC desktop shortcut
    $shortcut = Join-Path $env:PUBLIC 'Desktop\VLC media player.lnk'
    if (Test-Path $shortcut) { Remove-Item $shortcut -Force }

    # Optional: remove Windows Media Player legacy features
    # Start-Process dism.exe -ArgumentList '/Online','/NoRestart','/Disable-Feature','/FeatureName:MediaPlayback' -Wait
}