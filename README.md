# Anti-HP-Spyware
## SYNOPSIS
Anti HP Analytics / Spyware / Bloatware Toolset

## DESCRIPTION

Ever tried to get rid of the HP bloat- and spyware, which HP calles "analytics"?

They always seems to resurface after some time.
This is due to the fact that HP rolls out "services" via the windows update.
So even on a virgin windows, the infamous HP services (collecting your
information and/or interfering with the built-in windows functions) will
(re-)appear at one point.

Also, at the time of this writing, it is not trivial to get rid of the services
in the first place, as they are not regular apps that can simply be uninstalled.

So this toolset disables the HP services and makes sure they stay disabled,
by installing (and regularly running) a script as a windows scheduled task.  
Script execution is only triggered once, after installation, and then
repeatedly after login. The core concept is to minimize any nuisance.

The toolset is created in PowerShell, including a script to aid installation.
All scripts are lightweight and easy to read, as to simplify review and/or
adaption before installation.

To install the toolset (i.e. scheduled task), simply follow these steps:  
- Download the complete set of files (including the "source" directory)
- Copy (or unpack) to a directory of your choice on your system
- Open a PowerShell commandline, run as Administrator!
- "cd" to the target directory you chose to copy (or unpack) the files to
- Depending on your systems execution policy, you may need to allow scripts  
  (e.g. 'Set-Executionpolicy unresticted')
- run the installation script '.\Install-AntiHPSpyware-Task.ps1'  
- files are automatically installed under '%CommonProgramFiles%\AntiHP'  
  (a log file created in the folder indicates that the toolset is working)
- if you adapted your execution policy, you probably want to revert it  
  (e.g. 'Set-Executionpolicy Default')
- optionally delete the downloaded, copied and/or unpacked files

## SIDENOTES
Besides the Analytics "services", this toolset also disables the totally
useless network services. (Windows10+ is already handling things itself).  
In contrast, any services that are actually coupled with real features,
e.g. updates and testing, are left untouched by this toolset.

For some, the issue of unsolicited re-surfacing may be resolved by disabling the
respective device in the BIOS. But the BIOS option is not available everywhere.
Alternatively, one could use a GPO based mechanism to disable the services
in question. But GPOs may not be an option for everyone either.

## NOTES
Author   : Kai P.  
Version  : 0.1 (2024-09-25) - Initial Release
