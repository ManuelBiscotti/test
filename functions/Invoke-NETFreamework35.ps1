###################################################
# .NET Freamework 3.5 (includes .NET 2.0 and 3.0) #

function Invoke-NETFreamework35 {   

	<#
		.SYNOPSIS
			.NET Freamework 3.5 (includes .NET 2.0 and 3.0)
	#>
	
	Write-Host "Installing .NET Freamework 3.5..." -ForegroundColor Green
	
 	if ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -le 19045) {
		Get-FileFromWeb -URL "https://github.com/abbodi1406/dotNetFx35W10/releases/download/v0.20.01/dotNetFx35_WX_9_x86_x64.zip" -File "$env:TEMP\dotNetFx35_WX_9_x86_x64.zip"
		Expand-Archive "$env:TEMP\dotNetFx35_WX_9_x86_x64.zip" $env:TEMP -Force
		Start-Process "$env:TEMP\dotNetFx35_WX_9_x86_x64.exe" -ArgumentList "/ai /S /NORESTART" -Wait
	}

	elseif ((Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion').CurrentBuild -ge 22000) {
		Get-FileFromWeb -Url "https://github.com/ionuttbara/dotNet2035onW1X/releases/download/release_tag/dotNet2035_W11.exe" -File "$env:TEMP\dotNet.exe"
		& "$env:TEMP\dotNet.exe"
	}
	else {	
	}
}
###################################################