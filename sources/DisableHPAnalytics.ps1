##############################################################################
# PowerShell script to disable and stop the HP Analytics (spyware) service(s)
##############################################################################
# Meant to be run on Windows 10 and later
if ([Environment]::OSVersion.Version.Major -lt 10) { exit }

# definition of service (by name) to disable. Wildcards can be used if needed.
$ServicesToDisable = ('hpsvcsscan', 'HpTouchpointAnalyticsService', 'HpAudioAnalytics', 'HPNetworkCap', 'LanWlanWwanSwitchingServiceUWP')

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
	$InitialStatus = (Get-Service -Name $Service.Name).Status
	$InitialStartType = (Get-Service -Name $Service.Name).StartType

	$Service | Stop-Service
	Start-Sleep -Milliseconds 100
	$Service | Set-Service -StartupType 'Disabled'
	$Service | Stop-Service -Force
	
	$FinalStatus = (Get-Service -Name $Service.Name).Status
	$FinalStartType = (Get-Service -Name $Service.Name).StartType
	if ($InitialStatus -notmatch 'Stopped') {
		Write-Output "${Date}: Set service '$($Service.Name)' from status *$($InitialStatus) to *$($FinalStatus)" | Out-File "$LogFile" -Append
	}
	if ($InitialStartType -notmatch 'Disabled') {
		Write-Output "${Date}: Set service '$($Service.Name)' from startup type *$($InitialStartType) to *$($FinalStartType)" | Out-File "$LogFile" -Append
	}
}

Start-Sleep -Milliseconds 500
