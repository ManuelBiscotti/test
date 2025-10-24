function Invoke-EnableDefender {

	<#
	
		.SYNOPSIS
			Enable Windows Defender and Security
		
		.DESCRIPTION
			Enable Microsoft Defender and Security app completely without remove and broke Windows
		
		.LINK
			https://github.com/lostzombie/AchillesScript
			
		.PARAMETER restore
			Restoring default settings

	#>
	
	Invoke-WebRequest -Uri 'https://github.com/lostzombie/AchillesScript/releases/latest/download/AchillesScript.cmd' -OutFile "$env:TEMP\AchillesScript.cmd"
	& "$env:TEMP\AchillesScript.cmd" restore

}
	