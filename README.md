![My image](https://github.com/qschweitzer/Powershell-HTML5-Reporting/blob/gh-pages/medias/logo.png)
# :fire: Powershell Web Framework

# Full documentation online
### [Online POSHTML Doc](https://qschweitzer.github.io/Powershell-HTML5-Reporting)

### :exclamation: Compatibility

All web browsers are compatible with 
# :grey_question: Install
1. Install module with commands below.
```
Install-Module -Name POSHTML5
```

# :rocket: What to know ?
The framework has been optimized to be easily used.
All the functions are commented.
All arguments for each of them are explained.
The most interesting is that (almost) all functions are concatainable.
All functions were having a Content argument can contain some other functions and code.
```
$MyReport = New-PWFPage -Title "MY FIRST TEST" -Charset UTF8 -Container -DarkTheme -Content {
    New-PWFCardHeader -BackgroundColor "#fff" -Centered -Content {
        New-PWFTitles -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1
    }
    New-PWFRow -Content {
        New-PWFColumn -Content {
            New-PWFCard -Content {
                New-PWFTitles -Size 2 -TitleText "This HTML skin is based on $(New-PWFTextFormat -Bold "PicoCSS framework") and $(New-PWFTextFormat -Bold "Charts.JS") for the $(New-PWFTextFormat -ColorHexa "#BF0413" -Highlight "charts")."
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -Content {
                New-PWFTitles -Size 2 -TitleText "Progress bar"
                New-PWFProgressBar -CurrentValue ((((get-volume -DriveLetter C).Size)/1GB)-((get-volume -DriveLetter C).SizeRemaining)/1GB) -MaxValue (((get-volume -DriveLetter C).Size)/1GB)
            }
        }
    }
}
```

Save your New-PWFPage in a variable, next you just have to export it in an HTML file to save your most beautiful report.
```
$MyReport | Out-File -Encoding UTF8 -FilePath "C:\Windows\Temp\Test.html"
```

# :page_with_curl: Create a new HTML Page
That's the base:
```
New-PWFPage -Title "MY FIRST TEST" -Content {
...some code...
}
```
A __dark__ theme switch can be used.
A __container__  switch can be used to center the content and limit the width size.
A __charset__ option can be used to specify your charset. Default: __UTF8__

# :pushpin: Add a Header
```
New-PWFHeader -BackgroundColor "#fff" -Centered -Content {
    ...some code...
}
```
# :hash: Grid system
Like a web page, grid system is used.
With the New-PWFRow you create a new row of a grid.
With the New-PWFColumn you create a new object, autosized, on the row. More column you have, less larger they are. If you have two, they will do 50/50 of the total width.
Like:
```
New-PWFRow {
  New-PWFColumn {
    ...some code...
  }
  New-PWFColumn {
    ...some code...
  }
}
```
# :gem: Card system
Cards can now contains what you want. No limit. A table ? A chart ? No prob.
```
New-PWFCard -Content {
    ...some code...
}
```
# :gem: Title !
To create a title:
```
New-PWFTitles -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1
```

# :abcd: Simple text
```
New-PWFText -YourText "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
```

# :abcd: :star: Colored and/or specificaly formated text
```
$(New-PWFTextFormat -ColorHexa "#BF0413" -Highlight "WITH A COLOR")
$(New-PWFTextFormat -Highlight -YourText "You could highlight a text")
$(New-PWFTextFormat -ColorHexa "#BF0413" -Highlight -Bold -YourText "Multiple options")
```

# :camera: Add an Image and (optional) define a size
```
New-PWFImage -ImageURL "https://cdn.britannica.com/71/103171-050-BD1B685A/Bill-Gates-Microsoft-Corporation-operating-system-press-2001.jpg" -WidthInPercent 30
```

# :gem: Create a table and (optional) add a search bar to find specific text
```
New-PWFTable -ToTable (Get-Process | Select-Object Name, Handle -First 10) -SelectProperties @("Name","Handle")
New-PWFTable -ToTable (Get-Process | Select-Object Name, Handle -First 10) -SelectProperties @("Name","Handle") -EnableFilter
```
Use -EnableFilter to add a search input bar.
Use -ExportButtons to add XLSX export button. This will convert your HTML table to XLSX file and download it.

# :chart: Create a custom chart !
Create a chart automaticaly, function will count each same value of the PropertyFilter property and create a chart with count values.
```
New-PWFChart -AutomaticObject (Get-Process | Select-Object -first 15) -PropertyFilter Name -ChartType doughnut
```
Create a custom chart. Define which columns the function will use for Labels and which one for Values.
```
New-PWFChart -Object (Get-Disk | Select-Object FriendlyName,@{Name='Size in GB'; Expression={[math]::Round(($_.Size/1GB),2)}}) -LabelProperty "FriendlyName" -ValueProperty "Size in GB" -ChartType bar -ChartName "DiskSpaceinGB"
```

# Create a load bar
Create an horizontal loading bar.
```
New-PWFProgressBar -CurrentValue ((((get-volume -DriveLetter C).Size)/1GB)-((get-volume -DriveLetter C).SizeRemaining)/1GB) -MaxValue (((get-volume -DriveLetter C).Size)/1GB)
```

# EXAMPLE AT THE END OF FILE !
You have the screenshoted example at the end of the script. This will let you starting use and create your own.

![My image](https://github.com/qschweitzer/Powershell-HTML5-Reporting/blob/master/docs/2021-10-26%2018_03_10-Clipboard.jpg)


# LATEST UPDATES

* **New-PWFTitles deprecated**, replaced by New-PWFTitle as recommanded by Invoke-ScriptAnalyzer.
* Project now available on PowershellGallery

POSHTML5.

### Like My Work? Buy Me a Coffee!

* <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Bitcoin.svg/1024px-Bitcoin.svg.png" width="30"> 3DNRNqQk7VS7nFjVxJpXEriZPS8ZeCTEje
* <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Ethereum_logo_2014.svg/1200px-Ethereum_logo_2014.svg.png" width="30"> 0x9e79b5D816d8F0C52FFa1bBD657AdaB86f6F77dd
