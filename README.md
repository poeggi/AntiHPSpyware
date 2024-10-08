# Anti-HP-Spyware
## SYNOPSIS
Anti HP Analytics / Spyware / Bloatware Tool

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
The fundamental idea of this tool is to minimize any nuisance.

The script's execution is triggered
- once, directly after installation via the install script
- regularly after login of any user
- every time a relevant HP service is changing its state(**)

(**) As of v0.2, a "LiveHardcore" configuration was added that can be enabled during
installation, by uncommenting it in the install script.
"LiveHardcorr" behavior is considered more agressive (at the same time less tested),
so it is not yet enabled by default.
This specific configuration adds a "live" trigger that gets pulled when the
state of a relevant HP service changes, so it immediately switches the HP
services back off.

The whole tool is created in PowerShell, including the install script.
All scripts are lightweight and easy to read, as to simplify review and/or
adaption before installation.

To install the toolset (i.e. scheduled task), simply follow these steps:  
- Download the complete set of files (including the "source" directory)
- Copy (or unpack) to a directory of your choice on your system
- Open a PowerShell commandline, run as Administrator!
- "cd" to the target directory you chose to copy (or unpack) the files to
- Depending on your systems execution policy, you may need to allow scripts  
  (e.g. 'Set-Executionpolicy unresticted')
- optionally change the installation script to use e.g. "LiveHardcore" config
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

Alternative
For some, the issue of unsolicited re-surfacing may be resolved by disabling the
respective device in the BIOS. But the BIOS option is not available everywhere.
Alternatively, one could use a GPO based mechanism to disable the services
in question. But GPOs may not be an option for everyone either.

## NOTES
Author   : Kai P.  
Version  : 0.2 (2024-09-27) - "LiveHardcore" configuration added as option
