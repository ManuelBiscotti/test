################################
# Widgets (News and interests) #
function Invoke-RemWidgetsN&I {
	
	# Windows 10
	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -le 19045) {
		
		Write-Host "Removing News and interests .	. ."
		
		# Disable News and interests (Win 10)
		New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -Force | Out-Null
		Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Feeds' -Name 'EnableFeeds' -Value 0 -Type DWord | Out-Null

	}
	
	# Windows 11
	elseif ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
		
		Write-Host "Removing Widgets . . ."	
		
		# Remove Widgets related apps
		Get-AppxPackage -AllUsers | Where-Object {$_.Name -like "*WebExperience*" -or $_.Name -like "*Widgets*"} | Remove-AppxPackage

		# Disable Widgets
		reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "value" /t REG_DWORD /d "0" /f | Out-Null
		# remove windows widgets from taskbar regedit
		reg add "HKLM\SOFTWARE\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f | Out-Null
	
	}
	
}