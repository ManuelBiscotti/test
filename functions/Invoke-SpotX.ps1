# Install or upgrade Spotify
function Invoke-SpotX {
    Write-Host "Installing Spotify (SpotX)..." -ForegroundColor Green

    # Download the script to temp
    $scriptPath = Join-Path $env:TEMP 'run-spotx.ps1'
    Invoke-WebRequest -UseBasicParsing -Uri 'https://spotx-official.github.io/run.ps1' -OutFile $scriptPath

    # Execute the downloaded script with parameters
    & $scriptPath `
        -m `
        -sp-over `
        -new_theme `
        -canvashome_off `
        -adsections_off `
        -podcasts_off `
        -block_update_on `
        -DisableStartup `
        -cl 500 `
        -no_shortcut
}