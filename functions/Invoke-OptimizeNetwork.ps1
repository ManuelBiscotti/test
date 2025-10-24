function Invoke-OptimizeNetwork {
	# WINDOWS NETWORK OPTIMIZATIONS
	Write-Host "Optimizing Network..." -ForegroundColor Green
	Invoke-RestMethod "https://github.com/HakanFly/WINDOWS-NETWORK-OPTIMIZATIONS/raw/refs/heads/main/W10ANDW11-NETWORK-TCP-DESUBOPTIMIZATION.ps1" | Invoke-Expression *> $null
	
	# Disable Teredo
	Write-Output "Disabling Teredo..."
	netsh interface teredo set state disabled | Out-Null
	
	# Disable unnecessary network protocols
	Write-Output "Disabling Network Adapters..."
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_lldp
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_lltdio
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_implat
	Enable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_rspndr
	Enable-NetAdapterBinding -Name "*" -ComponentID ms_tcpip6
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_server
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_msclient
	Disable-NetAdapterBinding -Name "*" -ComponentID ms_pacer
}