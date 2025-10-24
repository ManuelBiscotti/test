function Invoke-DisableDefender {

	<#
	
		.SYNOPSIS
			Disable Windows Defender and Security
		
		.DESCRIPTION
			Disable Microsoft Defender and Security app completely without remove and broke Windows
		
		.LINK
			https://github.com/lostzombie/AchillesScript

		.PARAMETER apply 4
		
			4. Policies + Settings + Disabling Services and drivers + Block launch executables
			
				█ ⓘ Note
				█
				█ Hacker-style. Excessive.
				█
				█ Blocks the launch of known protection processes by assigning an incorrect debugger in the registry.
				█
				█ Helps reduce the risk of enabling the defender after Windows update.
			
	#>
	
	Invoke-WebRequest -Uri 'https://github.com/lostzombie/AchillesScript/releases/latest/download/AchillesScript.cmd' -OutFile "$env:TEMP\AchillesScript.cmd"
	& "$env:TEMP\AchillesScript.cmd" apply 4

}
	