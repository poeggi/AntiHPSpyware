##############################################################################
# PowerShell script to disable and stop the HP Analytics (spyware) service(s)
##############################################################################
# Meant to be run on Windows 10 and later
if ([Environment]::OSVersion.Version.Major -lt 10) { exit }

# definition of service (by name) to disable
$ServicesToDisable = ('hpsvcsscan', 'HPNetworkCap', 'LanWlanWwanSwitchingServiceUWP', 'Hp*Analy*')

$ServiceList = [array[]]::new(0)
foreach ($ServiceName in $ServicesToDisable) {
	$Service = (Get-Service -Name $ServiceName) 2> $null
	if ($Service) {
		$ServiceList += $Service
	}
}

$LogFile = ".\DisableHPAnalytics.log"

$Date=(date)

if (!(Test-Path $LogFile)) {
	Write-Output "${Date}: Initial Execution" | Out-File $LogFile
}

foreach ($Service in $ServiceList) {
	Write-Verbose "Checking $($Service.Name)"
	$InitialStatus = ($Service.Name | Get-Service | Select-Object Status)
	$Service | Stop-Service
	Start-Sleep -Milliseconds 100

	$Service | Set-Service -StartupType 'Disabled'
	$Service | Stop-Service -Force
	$FinalStatus = ($Service.Name | Get-Service | Select-Object Status)
	
	if ($InitialStatus.Status -notmatch 'Stopped') {
		Write-Output "${Date}: Set service '$($Service.Name)' from status *$($InitialStatus.Status) to *$($FinalStatus.Status)" | Out-File $LogFile -Append
	}
}

Start-Sleep -Milliseconds 500
