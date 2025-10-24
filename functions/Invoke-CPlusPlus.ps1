###########################
# Visual Studio 2015-2022 #
function Invoke-CPlusPlus {
	Write-Host "Installing Latest supported Visual C++ Redistributable (Visual Studio 2015-2022)"	-ForegroundColor Green
	Get-FileFromWeb -URL "https://aka.ms/vs/17/release/vc_redist.x86.exe" -File "$env:TEMP\vcredist2015_2017_2019_2022_x86.exe"	    	
	Get-FileFromWeb -URL "https://aka.ms/vs/17/release/vc_redist.x64.exe" -File "$env:TEMP\vcredist2015_2017_2019_2022_x64.exe"	
	Start-Process -wait "$env:TEMP\vcredist2015_2017_2019_2022_x86.exe" -ArgumentList "/passive /norestart"	    	
	Start-Process -wait "$env:TEMP\vcredist2015_2017_2019_2022_x64.exe" -ArgumentList "/passive /norestart" 	
}
###########################