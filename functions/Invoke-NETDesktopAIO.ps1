function Invoke-NETDesktopAIO {

	# Winget
	Invoke-Winget

	# install latest .net desktop runtimes
	foreach($id in "Microsoft.DotNet.DesktopRuntime.3_1","Microsoft.DotNet.DesktopRuntime.5","Microsoft.DotNet.DesktopRuntime.6","Microsoft.DotNet.DesktopRuntime.7","Microsoft.DotNet.DesktopRuntime.8","Microsoft.DotNet.DesktopRuntime.9"){
		winget.exe install --id=$id -a x64 --exact --source winget --accept-source-agreements --accept-package-agreements --force
	}   	
}