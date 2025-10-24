# Install or upgrade WebCord (Discord client)
function Invoke-WebCord {
	Write-Host "Installing WebCord..." -ForegroundColor Green
    # Download and install WebCord
    $installerPath = "$env:TEMP\webcord-squirrel-x64.exe"
    Get-FileFromWeb -URL "https://github.com/SpacingBat3/WebCord/releases/latest/download/webcord-squirrel-x64.exe" -File $installerPath
    
    # Install silently if possible (Squirrel installers typically use --silent)
    Start-Process -FilePath $installerPath -ArgumentList '--silent' -Wait -PassThru | Out-Null
    
    # Create icon directory if needed
    $iconDir = "$env:APPDATA\Local\webcord"
    if (-not (Test-Path $iconDir)) { 
        New-Item -Path $iconDir -ItemType Directory -Force | Out-Null
    }
    
    # Download icon
    Get-FileFromWeb -URL "https://github.com/ManueITest/Accel/raw/refs/heads/main/ico/Discord.ico" -File "$iconDir\Discord.ico"
    
    # Wait a bit for installation to complete
    Start-Sleep -Seconds 10
    
    # Find WebCord executable with better error handling
    $possiblePaths = @(
        "$env:LOCALAPPDATA\Programs\WebCord\app-*\WebCord.exe",
        "$env:LOCALAPPDATA\webcord\WebCord.exe"
    )
    
    $webcordExe = $null
    foreach ($path in $possiblePaths) {
        $found = Get-ChildItem -Path $path | Select-Object -First 1
        if ($found) {
            $webcordExe = $found.FullName
            break
        }
    }
    
    # Create shortcut if executable was found
    if ($webcordExe) {
        $shortcutPath = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs\Discord.lnk"
        $shell = New-Object -ComObject WScript.Shell
        $shortcut = $shell.CreateShortcut($shortcutPath)
        $shortcut.TargetPath = $webcordExe
        $shortcut.WorkingDirectory = Split-Path $webcordExe
        $shortcut.IconLocation = "$iconDir\Discord.ico"
        $shortcut.Save()
        # Write-Host "WebCord shortcut created successfully."
    } else {
        Write-Warning "WebCord executable not found! Shortcut not created."
        # Additional debugging: Check if installation directories exist
        Write-Debug "Checking installation directories:"
        $possibleDirs = @("$env:LOCALAPPDATA\Programs\WebCord", "$env:LOCALAPPDATA\webcord")
        foreach ($dir in $possibleDirs) {
            if (Test-Path $dir) {
                Write-Debug "Found directory: $dir"
                Get-ChildItem $dir -Recurse | ForEach-Object { Write-Debug "Found: $($_.FullName)" }
            }
        }
    }
}