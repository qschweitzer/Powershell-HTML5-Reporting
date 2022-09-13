Function New-PWFPage {
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
        [Parameter(Mandatory = $true, Position = 0)]
        $Title,
        $Content,
        [switch]$OnlineCSS,
        [switch]$OnlineJS,

        [Parameter(Mandatory = $false, Position = 1)]
        $Charset = "UTF-8",
        [switch]$Container,
        [switch]$DarkTheme
    )
    $output = @"
<!DOCTYPE html>
$(if($DarkTheme){'<html data-theme="dark" lang="en">'}else{'<html data-theme="light" lang="en">'})
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="$($charset)">
        $(if($OnlineCSS){
            '
            <!-- Compiled and minified CSS -->
            <!--Import Bootstrap-Table minified CSS -->
            <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css" >
            <!--Import Bootstrap minified CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
            <!--Import Custom PicoCSS minified CSS -->
            <link href="https://cdn.jsdelivr.net/gh/qschweitzer/Powershell-HTML5-Reporting/assets/css/113_PicoCssModified.min.css" rel="stylesheet" crossorigin="anonymous">
            <!--Import Table Export minified CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/css/tableexport.min.css" >
            '
        }
        else{
            "<style>
            $($AllCSS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\css" -Filter *.css)
            $($AllCSS | ForEach-Object {"$(Get-Content $_.fullname) $(write-output `r`n)"})
            </style>"
        })
        $(if($OnlineJS){
            '
            <!-- Compiled and minified JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
            <!-- Version of TableExport below. -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <!-- Minified version of TableExport below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/tableExport.min.js"></script>
            <!-- Minified version of jsPDF below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/jsPDF/jspdf.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
            <!-- Minified version of es6-promise-auto below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/es6-promise/es6-promise.auto.min.js"></script>
            <!-- Minified version of HTML2canvas below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/html2canvas/html2canvas.min.js"></script>
            <!-- Minified versions of Booststrap Table. -->
            <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.js"></script>
            <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/extensions/export/bootstrap-table-export.min.js"></script>
            '
        }
        else{
            "<script>
            $($AllJS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\js" -Filter *.min.* | Sort-Object Name)
            $($AllJS | ForEach-Object {"$(Get-Content $_.fullname) $(write-output `r`n)"})
            </script>"
        })
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
    try { $output += .$Content } catch { $_.Exception.Message }

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