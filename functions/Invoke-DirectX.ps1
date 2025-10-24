###########
# DirectX #
function Invoke-DirectX { 

	<#
		.SYNOPSIS
			DirectX
		.LINK
			https://www.microsoft.com/en-us/download/details.aspx?id=35
		.LINK
			https://github.com/HakanFly/Windows-Tweaks/tree/main/DirectX%20Tweaks
	#>

 	Write-Host "Installing DirectX..." -ForegroundColor Green
	Remove-Item "$env:TEMP\DirectX","$env:SystemRoot\Temp\DirectX" -Recurse -Force
	Get-FileFromWeb -URL "https://download.microsoft.com/download/8/4/A/84A35BF1-DAFE-4AE8-82AF-AD2AE20B6B14/directx_Jun2010_redist.exe" -File "$env:TEMP\DirectX.exe"
	Start-Process "$env:TEMP\DirectX.exe" -ArgumentList "/Q /T:`"$env:TEMP\DirectX`"" -Wait
	Start-Process "$env:TEMP\DirectX\DXSETUP.exe" -ArgumentList "/silent" -Wait	
	
	# DirectX Registry Tweaks
	$MultilineComment = @"
Windows Registry Editor Version 5.00

; D3D11 - D3D12 Tweaks
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DirectX]
"D3D12_ENABLE_UNSAFE_COMMAND_BUFFER_REUSE"=dword:00000001
"D3D12_ENABLE_RUNTIME_DRIVER_OPTIMIZATIONS"=dword:00000001
"D3D12_RESOURCE_ALIGNMENT"=dword:00000001
"D3D11_MULTITHREADED"=dword:00000001
"D3D12_MULTITHREADED"=dword:00000001
"D3D11_DEFERRED_CONTEXTS"=dword:00000001
"D3D12_DEFERRED_CONTEXTS"=dword:00000001
"D3D11_ALLOW_TILING"=dword:00000001
"D3D11_ENABLE_DYNAMIC_CODEGEN"=dword:00000001
"D3D12_ALLOW_TILING"=dword:00000001
"D3D12_CPU_PAGE_TABLE_ENABLED"=dword:00000001
"D3D12_HEAP_SERIALIZATION_ENABLED"=dword:00000001
"D3D12_MAP_HEAP_ALLOCATIONS"=dword:00000001
"D3D12_RESIDENCY_MANAGEMENT_ENABLED"=dword:00000001

; DirectX Driver DXGKrnl Advanced Tweaks (2)
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\DXGKrnl]
"CreateGdiPrimaryOnSlaveGPU"=dword:00000001
"DriverSupportsCddDwmInterop"=dword:00000001
"DxgkCddSyncDxAccess"=dword:00000001
"DxgkCddSyncGPUAccess"=dword:00000001
"DxgkCddWaitForVerticalBlankEvent"=dword:00000001
"DxgkCreateSwapChain"=dword:00000001
"DxgkFreeGpuVirtualAddress"=dword:00000001
"DxgkOpenSwapChain"=dword:00000001
"DxgkShareSwapChainObject"=dword:00000001
"DxgkWaitForVerticalBlankEvent"=dword:00000001
"DxgkWaitForVerticalBlankEvent2"=dword:00000001
"SwapChainBackBuffer"=dword:00000001
"TdrResetFromTimeoutAsync"=dword:00000001
"@

	Set-Content -Path "$env:TEMP\DirectXTweaks.reg" -Value $MultilineComment -Force		
	# import reg file
	Regedit.exe /S "$env:TEMP\DirectXTweaks.reg"

}
###########