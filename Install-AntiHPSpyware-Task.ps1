#Requires -RunAsAdministrator

$TaskToUse=".\sources\DisableHPAnalytics-Task.xml"
#$TaskToUse=".\sources\DisableHPAnalytics-Task-LiveHardcore.xml" # alternative task definition, featuring a trigger that is triggered immediately as soon as the service is re-enabled

# meant to run only on Windows 10 or later
if ([Environment]::OSVersion.Version.Major -lt 10) {
	Write-Output "This Script is meant to be used on Windows 10 and later only"
	exit
}

$TargetPath = "$env:CommonProgramFiles\AntiHP"

if (!(Test-Path $TargetPath)) {
	mkdir $TargetPath > $null
} else {
	rm $TargetPath\*.log
}

# copy script that the recurring taks will execute, do so by creating own file to allow windows to execute it
(Get-Content .\sources\DisableHPAnalytics.ps1) > ${TargetPath}\DisableHPAnalytics.ps1

# read the recurring task file XML defintion
$TaskURI = ([xml](Get-Content -Path $TaskToUse)).Task.RegistrationInfo.URI

# set up the task
Write-Verbose "Deleting Existing Task (if any)"
schtasks.exe /Delete /F /TN $TaskURI > $null 2>&1

Write-Verbose "Creating Task (from the XML file):"
schtasks.exe /Create /XML $TaskToUse /TN $TaskURI

Start-Sleep -Milliseconds 500

Write-Verbose "Starting Task Initially (to run immediately):"
schtasks.exe /Run /I /TN $TaskURI
