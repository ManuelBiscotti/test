# Disable Mitigations
function Invoke-DisableMitigations {
	Write-Host "Disabling Mitigations..." -ForegroundColor Green
	$batchCode = @'
@echo off
setlocal EnableDelayedExpansion

:: Disable Spectre and Meltdown
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverride" /t REG_DWORD /d "3" /f > nul 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "FeatureSettingsOverrideMask" /t REG_DWORD /d "3" /f > nul

:: Disable Structured Exception Handling Overwrite Protection (SEHOP)
:: Exists in ntoskrnl strings, keep for now
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "DisableExceptionChainValidation" /t REG_DWORD /d "1" /f > nul

:: Disable Control Flow Guard (CFG)
:: Find correct mitigation values for different Windows versions
:: Initialize bit mask in registry by disabling a random mitigation
PowerShell -NoP -C "Set-ProcessMitigation -System -Disable CFG"

:: Get current bit mask
for /f "tokens=3 skip=2" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions"') do (
    set "mitigation_mask=%%a"
)

:: Set all bits to 2 (Disable all process mitigations)
for /l %%a in (0,1,9) do (
    set "mitigation_mask=!mitigation_mask:%%a=2!"
)
:: Fix Valorant with mitigations disabled - enable CFG
set "enableCFGApps=valorant valorant-win64-shipping vgtray vgc"
PowerShell -NoP -C "foreach ($a in $($env:enableCFGApps -split ' ')) {Set-ProcessMitigation -Name $a`.exe -Enable CFG}" > nul 

:: Apply mask to kernel
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationAuditOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel" /v "MitigationOptions" /t REG_BINARY /d "%mitigation_mask%" /f > nul

:: Disable file system mitigations
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager" /v "ProtectionMode" /t REG_DWORD /d "0" /f > nul

:: Disable Fault Tolerant Heap
reg add "HKLM\SOFTWARE\Microsoft\FTH" /v Enabled /t REG_DWORD /d 0 /f > nul 2>&1
'@
	$batPath = "$env:TEMP\DisableAllMitigations.bat"
	Set-Content -Path $batPath -Value $batchCode -Encoding ASCII
	cmd.exe /c "`"$batPath`""
}