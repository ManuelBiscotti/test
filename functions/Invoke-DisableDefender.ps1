function Invoke-DisableDefender {

	<#
	
		.SYNOPSIS
			Disable Windows Defender and Security
		
		.DESCRIPTION
			Disable Microsoft Defender and Security app completely without remove and broke Windows
		
		.LINK
			https://github.com/lostzombie/AchillesScript

	#>
	
	Invoke-WebRequest -Uri 'https://github.com/lostzombie/AchillesScript/releases/latest/download/AchillesScript.cmd' -OutFile "$env:TEMP\AchillesScript.cmd"
	& "$env:TEMP\AchillesScript.cmd" apply 4

}
	