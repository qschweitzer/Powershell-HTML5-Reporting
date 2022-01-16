## :material-download: Install quickly (actually not available from Powershell Gallery, I'm working on it)
1. Install module with commands below. Module isn't published on NuGet, for the moment, so that's why the install is "manual"
```
New-Item -Path "C:\Program Files\WindowsPowerShell\Modules\POSHTML5" -ItemType Directory
Invoke-WebRequest -Uri "https://cdn.jsdelivr.net/gh/qschweitzer/Powershell-HTML5-Reporting@master/Modules/POSHTML5.psm1" -OutFile "C:\Program Files\WindowsPowerShell\Modules\POSHTML5\POSHTML5.psm1"
```
2. Import the .psm1 file of the Master branch like (think to delete example part before so), or simply edit the script and build your own report !
3. Begin with building a page in a variable:
```
$MyReport = New-PWFPage -Title "MY FIRST TEST" -Charset UTF8 -Container -DarkTheme -Content {
    New-PWFCardHeader -BackgroundColor "#fff" -Centered -Content {
        New-PWFTitles -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1
    }
}
```

## :fire: To build the content of your report, refer to the Functions tab of the doc.
1. :construction_site: [Structure](/Powershell-HTML5-Reporting/Functions/1-%20Structure/New-PWFPage/) your page
2. :material-palette: [Format](/Powershell-HTML5-Reporting/Functions/3-%20Format%20Data/New-PWFCard/) your data
3. :bar_chart: [Tables and Charts](/Powershell-HTML5-Reporting/Functions/2-%20Tables%20and%20Charts/New-PWFTable/)
4. :octicons-alert-16: Others functions to add [titles](/Powershell-HTML5-Reporting/Functions/4-%20Typography/New-PWFTitles/), [formated text](/Powershell-HTML5-Reporting/Functions/4-%20Typography/New-PWFTextFormat/), [icons](/Powershell-HTML5-Reporting/Functions/4-%20Typography/New-PWFIcon/), [alerts and badges](/Powershell-HTML5-Reporting/Functions/5-%20Badges%20and%20alerts/New-PWFAlert/)...
