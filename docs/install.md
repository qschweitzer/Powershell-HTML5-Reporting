## Install quickly (actually not available from Powershell Gallery, I'm working on it)
1. Install module with commands below. Module isn't published on NuGet, for the moment, so that's why the install is "manual"
```
New-Item -Path "C:\Program Files\WindowsPowerShell\Modules\POSHTML5" -ItemType Directory
Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/gh/qschweitzer/Powershell-HTML5-Reporting@master/Modules/POSHTML5.psm1" -OutFile "C:\Program Files\WindowsPowerShell\Modules\POSHTML5\POSHTML5.psm1"
```
2. Import the .psm1 file of the Master branch like (think to delete example part before so), or simply edit the script and build your own report !