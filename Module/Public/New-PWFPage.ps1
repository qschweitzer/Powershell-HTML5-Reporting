Function New-PWFPage{
<#
.SYNOPSIS
Create a new HTML page.
.DESCRIPTION
Create a new HTML page with pre-configured settings, and an empty body tag which will contain other blocks.
.PARAMETER Title
Title of your WebPage.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.PARAMETER Charset
Choose your Web Charset encoding.
.PARAMETER Container
If added, this parameter will configure the page to have a Container div. Refer to Materialize to understand all the concept of container. https://materializecss.com/getting-started.html
.EXAMPLE
New-PWFPage -Title "TEST" -Chartset UTF8 -Content { New-PWFRow -Content {}}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=0)]
    $Title,
    $Content,

    [Parameter(Mandatory=$false,Position=1)]
    $Charset="UTF-8",
    [switch]$Container,
    [switch]$DarkTheme
)
$output = @"
<!DOCTYPE html>
$(if($DarkTheme){'<html data-theme="dark" lang="en">'}else{'<html data-theme="light" lang="en">'})
    
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="$($charset)">
        <!-- Compiled and minified CSS -->
        <!--Import Bootstrap-Table minified CSS -->
        <!--<link href="assets/css/bootstrap-table.min.css" rel="stylesheet">-->
        <!--Import Bootstrap minified CSS -->
        <!--<link href="assets/css/bootstrap_poshtml5.min.css" rel="stylesheet">-->
        <!--Import Custom PicoCSS minified CSS -->
        <!--<link href="assets/css/PicoCssModified.css" rel="stylesheet" crossorigin="anonymous">-->
        <!--Import Table Export minified CSS -->
        <!--<link href="assets/css/tableexport.min.css" rel="stylesheet">-->
        <!--Import Google Icon Font-->
        <!--<link href="assets/css/icon.css" rel="stylesheet">-->
        <style>
        $($AllCSS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\css" -Filter *.css)
        $($AllCSS | ForEach-Object {"$(Get-Content $_.fullname) $(write-output `r`n)"})
        </style>
    
        <!-- Compiled and minified JavaScript -->
        <!--<script src="assets/js/jquery.min.js"></script>-->
        <!--<script src="assets/js/bootstrap.bundle.min.js"></script>-->
        <!-- Version of TableExport below. -->
        <!--<script src="assets/js/chart.min.js"></script>-->
        <!-- Minified version of TableExport below. -->
        <!--<script src="assets/js/tableExport.min.js"></script>-->
        <!-- Minified version of jsPDF below. -->
        <!--<script src="assets/js/jspdf.min.js"></script>-->
        <!--<script src="assets/js/jspdf.plugin.autotable.min.js"></script>-->
        <!-- Minified version of es6-promise-auto below. -->
        <!--<script src="assets/js/es6-promise.auto.min.js"></script>-->
        <!-- Minified version of HTML2canvas below. -->
        <!--<script src="assets/js/html2canvas.min.js"></script>-->
        <!-- Minified versions of Booststrap Table. -->
        <!--<script src="assets/js/bootstrap-table.min.js"></script>-->
        <!--<script src="assets/js/bootstrap-table-export.min.js"></script>-->
        <script>
        $($AllJS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\js" -Filter *.min.* | Sort-Object Name)
        $($AllJS | ForEach-Object {"$(Get-Content $_.fullname) $(write-output `r`n)"})
        </script>
        <title>$($title)</title>
    </head>
<body>
<!-- $(if($Container){'<main class="container">'}else{'<main class="container-fluid">'}) -->
"@
    $Script:ChartColorsPalette = @(
      "#264653",
      "#2A9D8F",
      "#E9C46A",
      "#F4A261",
      "#E76F51",
      "#E63946",
      "#F1FAEE",
      "#A8DADC",
      "#457B9D",
      "#1D3557",
      "#555B6E",
      "#89B0AE",
      "#BEE3DB",
      "#FAF9F9",
      "#FFD6BA",
      "#355070",
      "#6D597A",
      "#B56576",
      "#E56B6F",
      "#EAAC8B",
      "#16697A",
      "#489FB5",
      "#82C0CC",
      "#EDE7E3",
      "#FFA62B"
    )
    try {$output += .$Content} catch {$_.Exception.Message}

$output += @"
    <footer>
    </footer>
</div>
<!--</main>-->
</body>
</html>

"@
return $output
}