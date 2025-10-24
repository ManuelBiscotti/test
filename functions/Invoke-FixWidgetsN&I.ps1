################################
# Widgets (News and interests) #
function Invoke-FixWidgetsN&I {
	
	# Windows 10
	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -le 19045) {
		Write-Host "Fixing News and interests .	. ."
		# Install Edge
		# enable edge updates regedit
		cmd /c "reg delete `"HKLM\SOFTWARE\Microsoft\EdgeUpdate`" /f >nul 2>&1"		
		# download edge installer
		Get-FileFromWeb -URL "https://go.microsoft.com/fwlink/?linkid=2109047&Channel=Stable&language=en&brand=M100" -File "$env:TEMP\Edge.exe"
		# start edge installer
		Start-Process -wait "$env:TEMP\Edge.exe"
		# install uwp edge
		Get-AppXPackage -AllUsers *Microsoft.MicrosoftEdge.Stable* | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register -ErrorAction SilentlyContinue "$($_.InstallLocation)\AppXManifest.xml"}		
		
		# Re-enable News and interests
		Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -Name 'EnableFeeds' -ErrorAction SilentlyContinue
		Remove-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -ErrorAction SilentlyContinue
	}
	
	# Windows 11
	elseif ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
		Write-Host "Fixing Widgets . . ."		
		# download edge webview installer
		Get-FileFromWeb -URL "https://msedge.sf.dl.delivery.mp.microsoft.com/filestreamingservice/files/304fddef-b073-4e0a-b1ff-c2ea02584017/MicrosoftEdgeWebview2Setup.exe" -File "$env:TEMP\EdgeWebView.exe"
		# start edge webview installer
		Start-Process -wait "$env:TEMP\EdgeWebView.exe"
		
		# Reinstall Widgets related apps
		Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*WebExperience*" -or $_.Name -like "*Widgets*"} | ForEach-Object {
			Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml" -ErrorAction SilentlyContinue
		}
	
		# Re-enable Widgets
		# Remove the disable registry entries
		reg delete "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /f 2>$null
		reg delete "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /f 2>$null	
	}
	
}