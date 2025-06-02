Function New-WEBPage {
    <#
.SYNOPSIS
Create a new HTML page.
.DESCRIPTION
Create a new HTML page with pre-configured settings, and an empty body tag which will contain other blocks.
.PARAMETER Title
Title of your WebPage.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.PARAMETER Path
Path to export to.
.PARAMETER Charset
Choose your Web Charset encoding.
.PARAMETER Container
If added, this parameter will configure the page to have a Container div. Refer to Materialize to understand all the concept of container. https://materializecss.com/getting-started.html
.EXAMPLE
New-WEBPage -Title "TEST" -Chartset UTF8 -Content { New-WEBRow -Content {}}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Title,
        $Content,
        [switch]$OnlineJS,
        [string]$Path,

        [Parameter(Mandatory = $false, Position = 1)]
        $Charset = "UTF-8",
        [switch]$Container,
        [switch]$DarkTheme
    )
    $script:ChartColorsPalette = @(
        "#6A0DAD",
        "#00ACC1",
        "#FFC107",
        "#8E24AA",
        "#03A9F4",
        "#FF9800",
        "#5C6BC0",
        "#9C27B0",
        "#E91E63",
        "#BA68C8",
        "#21D96D",
        "#AA00FF",
        "#00BFA5",
        "#CE93D8",
        "#8A2BE2",
        "#1DE9B6",
        "#FF5722",
        "#512DA8",
        "#AEEA00",
        "#D500F9",
        "#FDD835",
        "#F06292",
        "#F44336",
        "#FFEB3B",
        "#FFCA28",
        "#00E676",
        "#E91E63"
    )
    $Content = . $Content
    $AllCSS = Get-ChildItem "$((Get-Module PSReport).ModuleBase)\assets\css" -Filter *.css
    $JSCode = Get-Content ("$((Get-Module PSReport).ModuleBase)\assets\js\pwf.js") -Raw
    $output = @"
<!DOCTYPE html>
$(if($DarkTheme){'<html data-theme="dark" lang="en">'}else{'<html data-theme="light" lang="en">'})
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="$($charset)">
        <style>
        $($AllCSS | ForEach-Object {write-host $_.name;"$(Get-Content $_.fullname) $(write-output `r`n)"})
        </style>
        <script>
            // Store charts graph instances
            let charts = [];
            charts.push($(if($script:AllCharts){"'$($script:AllCharts -join "', '")'"}));
        </script>
        $(if($OnlineJS){
            '
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
            '
        }
        else{
            "<script>
                $(Get-Content ("$((Get-Module PSReport).ModuleBase)\assets\js\chart.min.js") -Raw) $(write-output `r`n)
            </script>"
        })
        <title>$($title)</title>
    </head>
<body>
<!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="logo">AI</div>
                <div class="header-title">
                    <h1>$Title</h1>
                    <div class="header-subtitle">Generated on <span id="current-date"></span></div>
                </div>
            </div>
            <div class="header-right">
                <div class="search-container">
                    <input type="text" class="search-input" placeholder="Search... (Ctrl+K)" id="global-search">
                    <span class="search-icon">🔍</span>
                </div>
                <button class="theme-toggle" id="theme-toggle" title="Switch theme">🌙</button>
            </div>
        </div>
    </header>

   <!-- Navigation -->
    <nav class="nav-container">
        <div class="nav-tabs" id="nav-tabs">
            $(
            foreach ($tab in $Script:TabsNames){
                if($tab -eq $script:TabsNames[0]){
                    $firstTab = $tab
                    "<button class=""nav-tab active"" data-tab=""$($tab.tolower() | Remove-StringSpecialCharactere)"">$tab</button>"
                }
                else{
                    "<button class=""nav-tab"" data-tab=""$($tab.tolower() | Remove-StringSpecialCharactere)"">$tab</button>"
                }
            })
        </div>
    </nav>

     <!-- Main Content -->
    <main class="main-container">
"@
    try {
        if (-not $Script:tabUsed) {
            $output += @"
        <div class="tab-content active" id="dashboard">
            <h2>Dashboard</h2>
            $($output += $Content )
        </div>
"@
        }
        else {
            $output += $Content 
        }
    }
    catch { $_.Exception.Message }

    $output += @"
    <footer>
        <div>
            <p>Powershell generated report.</p>
        </div>
    </footer>
    </main>
    <script>
    // === DATA ===
    $($script:allTableData)
    $($JSCode)
    </script>
<!--</main>-->
</body>
</html>
"@
    if ($path) {
        $output | out-file $path -Encoding utf8
    }
    else {
        return $output
    }
    $Script:TabsNames = $null
    $script:AllCharts = $null
    $script:allTableData = $null
}