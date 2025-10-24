# Install or upgrade 7-Zip
function Invoke-7Zip {
    Write-Host "Installing 7-Zip..." -ForegroundColor Green

    $exePath = Join-Path $env:TEMP '7z-x64.exe'

    # Download latest 7-Zip x64 release from GitHub
    $url = (Invoke-RestMethod "https://api.github.com/repos/ip7z/7zip/releases/latest").assets |
           Where-Object { $_.name -like "*x64.exe" } |
           Select-Object -First 1 -ExpandProperty browser_download_url
    Invoke-WebRequest -Uri $url -OutFile $exePath -UseBasicParsing

    # Silent install
    Start-Process -FilePath $exePath -ArgumentList '/S' -Wait

    # 7-Zip file associations
	Write-Output "Configuring 7-Zip file associations..."
    $7zExe = Join-Path $env:ProgramFiles '7-Zip\7zFM.exe'
    if (Test-Path $7zExe) {
        $exts = '7z','xz','bzip2','gzip','tar','zip','wim','apfs','ar','arj','cab','chm','cpio','cramfs','dmg','ext','fat','gpt','hfs','ihex',
                'lzh','lzma','mbr','nsis','ntfs','qcow2','rar','rpm','squashfs','udf','uefi','vdi','vhd','vhdx','vmdk','xar','z' # ,'msi'

        foreach ($ext in $exts) {
            cmd /c "assoc .$ext=7zFM.exe" > $null
        }

        cmd /c "ftype 7zFM.exe=`"$7zExe`" `"%1`" `"%*`"" > $null
    }

	# Remove "New > Compressed (zipped) Folder" context menu entry
	Remove-Item -Path "HKCR:\.zip\CompressedFolder\ShellNew" -Recurse -Force
}