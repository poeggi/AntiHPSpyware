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
in the first place, as they are not regular apps that can simply be uninstalled
and connected to the fake hardware devices.

So instead of trying to deinstall, this toolset disables the HP services and
makes sure they stay disabled, by setting up (and regularly running) a script
as a windows scheduled task.  
Script execution is triggered once, after installation, and then only after login.
The core idea is to minimize any nuisance.

As of v0.2, a configuration named 'LiveHardcore' configuration was added that can
be used for installation by uncommenting it in the install script.
It's behavior is considered more agressive (at the same time less tested),
so it is not yet enabled by default.
This specific configuration adds a "live" trigger that gets pulled when the
state of the Analytics services changes (e.g. by new updates). It then
runce once to immediately switches the HP services back off.

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
- optionally change the installation script to use e.g. 'LiveHardcore' config
- run the installation script '.\Install-AntiHPSpyware-Task.ps1'  
- files are automatically installed under '%CommonProgramFiles%\AntiHP'  
  (a log file created in the folder indicates that the toolset is working)
- if you adapted your execution policy, you probably want to revert it  
  (e.g. 'Set-Executionpolicy Default')
- optionally delete the downloaded, copied and/or unpacked files

## SIDENOTES
Besides the Analytics "services", this toolset also disables the totally
useless network services. (Windows10+ is already handling things itself).  
Also disabled is a service called 'hpsvcsscan', which seems to manage
(re-)installation of drivers and services. 
On the other hand, any services that is actually coupled with real features,
e.g. updates and testing, is left untouched by this toolset.

Alternative solutions or supplemental measures (to using this toolset):  
The issue of unsolicited re-surfacing of services may be (partially) resolved
by disabling the respective device in the HP BIOS.  
(BIOS Setting to disable: Advances->System Options->[ ]HP Application Driver)  
But the BIOS option is not available on all systems.  
Alternatively, a GPO based mechanism could be used to disable the services
in question and/or to prevent driver updates for specific devices.  
GPOs may not be an option for everyone either.

## NOTES
Author   : Kai P.  
Version  : 0.2 (2024-09-27) - 'LiveHardcore' configuration added as option
