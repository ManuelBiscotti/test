# BCDEDIT Tweaks
function Invoke-BCDEdit {
	Write-Output "BCDEdit Tweaks..."
	# disable security / virtualization
	bcdedit /set nx AlwaysOff | Out-Null              # disable DEP
	bcdedit /set integrityservices disable | Out-Null # disable code integrity
	bcdedit /set hypervisorlaunchtype off | Out-Null  # disable hypervisor
	bcdedit /set vsmlaunchtype Off | Out-Null         # disable VSM
	bcdedit /set vm No | Out-Null                     # disable virtual memory features
	
	# performance tweaks
	bcdedit /set isolatedcontext No | Out-Null        # disable Credential Guard
	bcdedit /set useplatformclock no | Out-Null       # disable forced platform clock
	bcdedit /set tscsyncpolicy Legacy | Out-Null      # legacy TSC sync
	# bcdedit /set usephysicaldestination no | Out-Null # forces Windows to use logical destination mode for interrupts
	
	# boot tweaks / faster boot
	bcdedit /set bootmenupolicy Legacy | Out-Null     # legacy boot menu
	bcdedit /set quietboot yes | Out-Null             # hide boot logo
	bcdedit /set bootux disabled | Out-Null           # disable boot animation
	bcdedit /set bootlog no | Out-Null                # disable boot logging
	bcdedit /timeout 3 | Out-Null                     # boot menu timeout (change to 10 if you dual-boot)
	bcdedit /event off | Out-Null                     # disable boot event logging
	bcdedit /bootdebug off | Out-Null                 # disable boot debugging
	bcdedit /set debug no | Out-Null                  # disable kernel debugging
	bcdedit /set ems no | Out-Null                    # disable emergency management services
	bcdedit /set bootems no | Out-Null                # disable EMS during boot
	# bcdedit /set uselegacyapicmode no | Out-Null      # disable legacy APIC
	bcdedit /set sos no | Out-Null                    # disable driver debug info
}