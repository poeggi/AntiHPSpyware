#############################################################################
# PowerShell script to stop and disable unwanted HP tasks and service(s)
##############################################################################

# Enable standard PowerShell parameters
[CmdletBinding()]
param()

# Meant to be run on Windows 10 and later
if ([Environment]::OSVersion.Version.Major -lt 10) { exit }

# Definition of service (by name) to disable. 
$ServicesToDisable = @('hpsvcsscan', 'HpTouchpointAnalyticsService', 'HpAudioAnalytics')

# Definition of tasks (task planner name) to disable.
$TasksToDisable = @('HP Support Solutions Framework Report', 'Consent Manager Launcher')

#
# Further tasks and services to disable. Add your own here. Wildcards can be used if needed.
# -> Add your own services or tasks here!
#
$FurtherServicesToDisable = @('HPNetworkCap')
# NOTE: Apparently 'LanWlanWwanSwitchingServiceUWP' from the Services cannot be
#       disabled without creating fallout, as that service seems to implement
#       quirk management of the Qualcomm Snapdragon X55 5G Cellular Modem
#       Without it service (tested on Windows11) a X55 WWAN Device did
#       reproducibly crash and not recover (Windows log Code 43).

$FurtherTasksToDisable = @('SmartCheckTest')


$ServicesToDisable = $ServicesToDisable + $FurtherServicesToDisable
$TasksToDisable = ($TasksToDisable) + ($FurtherTasksToDisable)

# create clean lists that contain only existing services and tasks
$ServiceList = [array[]]::new(0)
foreach ($ServiceName in $ServicesToDisable) {
	Write-Debug "Checking if there is a service named $ServiceName"
	$Service = (Get-Service -Name $ServiceName) 2> $null
	if ($Service) { $ServiceList += $Service }
}

$TaskList = [array[]]::new(0)
foreach ($TaskName in $TasksToDisable) {
	Write-Debug "Checking if there is a Task named $TaskName"
	$Task = (Get-ScheduledTask -TaskName $TaskName) 2> $null
	if ($Task) { $TaskList += $Task }
}

$LogFile = ".\DisableHPAnalytics.log"

$Date=(date)

if (!(Test-Path $LogFile)) {
	Write-Output "${Date}: Initial Execution" | Out-File $LogFile
}

# clean services
foreach ($Service in $ServiceList) {
	Write-Verbose "Checking service $($Service.Name)"
	$InitialStatus = $Service.Status
	$InitialStartType = $Service.StartType

	$Service | Stop-Service
	Start-Sleep -Milliseconds 100
	$Service | Set-Service -StartupType 'Disabled'
	$Service | Stop-Service -Force
	
	$FinalStatus = (Get-Service -Name $Service.Name).Status
	$FinalStartType = (Get-Service -Name $Service.Name).StartType
	if ($InitialStatus -notmatch 'Stopped') {
		Write-Verbose "Stopped service $($Service.Name)"
		Write-Output "${Date}: Set service '$($Service.Name)' from status *$($InitialStatus) to *$($FinalStatus)" | Out-File "$LogFile" -Append
	}
	if ($InitialStartType -notmatch 'Disabled') {
		Write-Verbose "Disabled service $($Service.Name)"
		Write-Output "${Date}: Set service '$($Service.Name)' from startup type *$($InitialStartType) to *$($FinalStartType)" | Out-File "$LogFile" -Append
	}
}

# clean tasks
foreach ($Task in $TaskList) {
	Write-Verbose "Checking scheduled task $($Task.TaskName)"
	$InitialState = $Task.State

	$Task | Disable-ScheduledTask > $null
	Start-Sleep -Milliseconds 100
	
	$FinalState = ($Task | Get-ScheduledTask).State
	if ($InitialState -notmatch 'Disabled') {
		Write-Verbose "Disabled scheduled task $($Task.TaskName)"
		Write-Output "${Date}: Set scheduled tasks '$($Task.TaskName)' from state *$($InitialState) to *$($FinalState)" | Out-File "$LogFile" -Append
	}
}

Start-Sleep -Milliseconds 500
