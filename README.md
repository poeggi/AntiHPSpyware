# Anti-HP-Spyware
## SYNOPSIS
Anti HP Analytics / Spyware / Bloatware Tool

## DESCRIPTION
Ever tried to get rid of the HP bloat- and spyware HP calls "analytics"?
They always seems to resurface after some time.

This is because HP rolls out "services" via the windows update.
So even on a vanilla Windows, the infamous HP services (collecting your
information and/or interfering with Windows functions) will (re-)appear
at one point.

Also, once installed it is not trivial to get rid of the services in the
first place, they are not regular programs that can simply be uninstalled.

So this tool does not deinstall the HP services but disables them.
Installs and regularly runs a script as a scheduled tasks keep them disabled. 
Script execution is triggered once, after installation, and then repeatedly
after login. Additionally, a trigger is set up that actively supervises the
state of the Analytics services and responds to a service being re-enabled,
by immediately switching it back off.

The main idea of the tool is to minimize any nuisance caused by HP "tools"
but also by this tool, so it runs only when necessary.

The script's execution is triggered
- once, directly after installation via the install script
- regularly after login of any user
- every time a core HP analytics service is changing its state

The whole tool is created in PowerShell, including the install script.
All scripts are lightweight and easy to read, as to simplify review
and/or adaption before installation.

To install the tool (i.e. scheduled task), simply follow these steps:  
- Download the complete set of files (including the "source" directory)
- Copy (or unpack) to a directory of your choice on your system
- Open a PowerShell command-line, run as Administrator!
- "cd" to the target directory you chose to copy (or unpack) the files to
- Depending on your systems execution policy, you may need to allow scripts  
  (e.g. 'Set-Executionpolicy unresticted')
- optionally change the installation script to use e.g. the conservative config  
  or to add you own services to be disabled
- run the installation script '.\Install-AntiHPSpyware-Task.ps1'  
- files are automatically installed under '%CommonProgramFiles%\AntiHP'  
  (a log file created in the folder indicates that the tool is working)
- if you adapted your execution policy, you probably want to revert it  
  (e.g. 'Set-Executionpolicy Default')
- optionally delete the downloaded, copied and/or unpacked files

## SIDENOTES
Besides the Analytics "services", this tool also disables the totally
useless network services. (Windows10+ is already handling things itself).  
As of version 0.4, it furthermore disables some useless HP scheduled services.  
On the other hand, HP services that are actually coupled with real features,
e.g. updates and testing, are left untouched by this tool.

### Alternative Approaches  
For some users, the issue of unsolicited re-surfacing may be resolvable by
disabling the HP device in the BIOS (Advanced->System Options->[ ]HP Application Driver)  

But this BIOS option is not available on every HP system.  

Alternatively, one could use a GPO based mechanism to disable the specific
services or driver updates. But GPOs may not be an option for everyone either.  

Hence this tool.

## NOTES
Author   : Kai P.  
Version  : 0.4 (2025-05-12) - Add feature to disable HP scheduled tasks.
