# Activate Windows
function Invoke-WinActivation {
<#
.SYNOPSIS
    Activates a permanent Microsoft Digital License for Windows 10/11.
.DESCRIPTION
    Downloads (irm) and executes (iex) the activation script from the official URL (https://get.activated.win) with the default specified argument (/Z-Windows)
	Check Windows activation status and only proceeds with activation if Windows is not already activated
	Fully Open Source and based on Batch scripts
.EXAMPLE
    iex "& {$((irm https://get.activated.win))} /Z-Windows"
	Arguments:
	Z-Windows - TSforge Permanent Activation for Win 10/11 (Offline)
	HWID      - Permanent HWID Digital License for Win 10/11
	KMS38     - KMS Activation for Win 10/11/Server until 2038
	K-Windows - Online KMS Activation (180-day renewable)
.NOTES
	Name: Microsoft Activation Scripts
	About: Open-source Windows and Office activator
    Version: Always uses the latest release (https://massgrave.dev/#mas-latest-release)
    Author: MASSGRAVE
.LINK
    Website: https://massgrave.dev/
	Source: https://github.com/massgravel/Microsoft-Activation-Scripts 
#>
	Write-Host "Activating Windows..." -ForegroundColor Green
	# Permanently activates Windows using the TSforge activation method, 100% open-source and works completely offline. (suitable for older systems and VMs)
	Invoke-Expression "& {$((Invoke-RestMethod https://get.activated.win))} /Z-Windows"
}