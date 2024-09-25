# Anti-HP-Spyware
## SYNOPSIS
Anti HP Analytics / Spyware / Bloatware Toolset

## DESCRIPTION

Ever tried to get rid of the HP bloat- and spyware, which HP calles "analytics"?

They always seems to resurface after some time.
This is due to the fact that HP rolls out "services" via the windows update.
So even on a virgin windows, the infamous HP services (collecting your
information and/or interfering with the built-in windows functions) will
(re-)appear at one point

This toolset disables the HP services and makes sure they stay disabled,
by installing and regularly running a script, as a windows scheduled task.  
Script execution is only triggered once after installation and then
repeatedly after login, as to minimize any nuisance.

The toolset is created in PowerShell, including a script to aid installation.
All scripts are lightweight and easy to read, as to simplify review and/or
adaption before installation.

To install follow these steps:  
- Download the complete set of files (including the "source" directory)
- Copy (or unpack) to a directory of your choice on your system
- Open a PowerShell, run as Administrator!
- "cd" to the target directory you chose to copy (or unpack) the files to
- Depending on your Systems Execution Policy, you might need to change it  
  (e.g. "Set-Executionpolicy unresticted")
- execute the installation script ".\Install-AntiHPSpyware-Task.ps1"  
- files are created under %CommonProgramFiles%\AntiHP  
  (a log file should be created and indicates everything is working)
- optionally revert your execution policy
- optionally delete the downloaded, copied and/or unpacked files

## SIDENOTES
Besides the Analytics "services", this toolset also disables the totally
useless Network services. (As Windows10+ is already handling things itself).  
In contrast, any services that are actually coupled with real features,
e.g. updates and testing, are left untouched by this toolset.

## NOTES
Author   : Kai P.  
Version  : 0.1 (2024-09-25) - Initial Release
