## :material-download: Install quickly (actually not available from Powershell Gallery, I'm working on it)
1. Install module with commands below. Module isn't published on NuGet, for the moment, so that's why the install is "manual"
```
Install-Module -Name PSReport
```
3. Begin with building a page in a variable:
```
$MyReport = New-WEBPage -Title "MY FIRST TEST" -Charset UTF8 -Container -DarkTheme -Content {
    New-WEBCardHeader -BackgroundColor "#fff" -Centered -Content {
        New-WEBTitles -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1
    }
}
```

## :fire: To build the content of your report, refer to the Functions tab of the doc.
1. :construction_site: [Structure](/Powershell-HTML5-Reporting/Functions/1-%20Structure/New-WEBPage/) your page
2. :material-palette: [Format](/Powershell-HTML5-Reporting/Functions/3-%20Format%20Data/New-WEBCard/) your data
3. :bar_chart: [Tables and Charts](/Powershell-HTML5-Reporting/Functions/2-%20Tables%20and%20Charts/New-WEBTable/)
4. :octicons-alert-16: Others functions to add [titles](/Powershell-HTML5-Reporting/Functions/4-%20Typography/New-WEBTitles/), [formated text](/Powershell-HTML5-Reporting/Functions/4-%20Typography/New-WEBTextFormat/), [icons](/Powershell-HTML5-Reporting/Functions/4-%20Typography/New-WEBIcon/), [alerts and badges](/Powershell-HTML5-Reporting/Functions/5-%20Badges%20and%20alerts/New-WEBAlert/)...
