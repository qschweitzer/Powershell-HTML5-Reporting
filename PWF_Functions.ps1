<#
.SYNOPSIS
These functions lets you create an HTML5  web page with dynamic table and charts, easily.
.DESCRIPTION
Create a new HTML5 page with dynamic tables and charts, easily. Som example at the end in the EXAMPLES section.
.NOTES
  Version:        2.1.1
  Author:         Quentin Schweitzer
  Creation Date:  04.11.2021
  Purpose/Change: Add -Scrollbar option to Table function. Add -Center option to all text functions. Add colorize param to colorize background of Table function.
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>

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
    New-PWFPage { New-PWFRow -Content {}}
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
    $(if($DarkTheme){'<html data-theme="dark">'}else{"<html>"})
        
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <meta charset="$($charset)">
            <!-- Compiled and minified CSS -->
            <link rel="stylesheet" href="https://unpkg.com/@picocss/pico@latest/css/pico.min.css">
            <!--Import Google Icon Font-->
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
            <!-- Compiled and minified JavaScript -->
            <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script lang="javascript" src="https://unpkg.com/xlsx/xlsx.mini.js"></script>
            <style>
                input[type="submit"].exportbutton{
                    background-color: #1095c1;
                    max-width: 10em;
                    padding: 0px 0px 0px 0px !important;
                }
            </style>
            <title>$($title)</title>
        </head>
    <body>
    $(if($Container){'<main class="container">'}else{'<main class="container-fluid">'})
"@
        try {$output += .$Content} catch {$_.Exception.Message}

    $output += @"
        <footer>
        </footer>
    </div>
    </main>
    </body>

    </html>

"@
return $output
}
Function New-PWFRow{
    <#
    .SYNOPSIS
    Create a new HTML div with Row class.
    .DESCRIPTION
    Create a new HTML div with Row class.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFRow -Content { ... }
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $Content
    )

    $output = @"
        <div class="grid">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </div>
"@

return $output

}
Function New-PWFColumn{
    <#
    .SYNOPSIS
    Create a new HTML div column without class.
    .DESCRIPTION
    Create a new HTML div column without class. The size of each column is relative to number of column in 100% width.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFColumn -Content { ... }
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $Content
    )

        $output = @"
        <div>
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </div>
"@

return $output

}
Function New-PWFHorizontalScroller{
    <#
    .SYNOPSIS
    Create a new HTML figure without class.
    .DESCRIPTION
    Create a new HTML figure without class. Use it to have an horizontal scroller, for example, of your large table.
    See more at: https://picocss.com/docs/#scroller
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFHorizontalScroller -Content { ... }
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $Content,
        [switch]$Scrollbar
    )

        $outputa = @"
        <figure$(if($Scrollbar){write-output " style=height:25em;"})>
"@
        $(try {$outputa += .$Content} catch {$_.Exception.Message})

    $outputa += @"
        </figure>
"@

return $outputa

}
Function New-PWFTitles{
    <#
    .SYNOPSIS
    Create a new HTML Title with custom size.
    .DESCRIPTION
    Create a new HTML Title with custom size
    .PARAMETER TitleText
    The TitleText is your string text.
    .PARAMETER Size
    The Size of the title. From 1 to 5. 1 is the biggest.
    .PARAMETER Center
    Use Center to center your text in the parent division.
    .PARAMETER LightMode
    The Lightmode will color your text in white.
    .EXAMPLE
    New-PWFTitles -TitleText "MyTitle" -Size 1 -Center -Lightmode
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$TitleText,
        [int]$Size,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Center,
        [switch]$LightMode
    )

    $output = @"
        <H style='$($Size)$(if($LightMode){"color:#fff;"}elseif($Center){"text-align:center;"})'>$TitleText</H$($Size)>
"@
    return $output
}
Function New-PWFTextFormat{
    <#
    .SYNOPSIS
    Create a new HTML text with customized format.
    .DESCRIPTION
    Create a new HTML Title with customized format. You can use multiple format options at the same time.
    .PARAMETER YourText
    Your string text.
    .PARAMETER Center
    Center your text.
    .PARAMETER ColorHexa
    Color your text with custom hexadecimal color.
    .PARAMETER Abbreviation
    Add Abreviation mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Highlight
    Add Highlight mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Bold
    Add Bold mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Strikethrough
    Add Strikethrough mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Italic
    Add Italic mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Deleted
    Add Deleted mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER SubText
    Add SubText mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER SupText
    Add SupText mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Inserted
    Add Inserted mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Keyboard
    Add Keyboard mode to your text. Look sample at https://picocss.com/docs/#typography
    .PARAMETER Underline
    Add Underline mode to your text. Look sample at https://picocss.com/docs/#typography
    .EXAMPLE
    New-PWFTextFormat -YourText "My Text is Awesome" -ColorHexa "#D94020" -Bold -Underline
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$YourText,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Center,
        [string]$ColorHexa,
        [switch]$Abbreviation,
        [switch]$Highlight,
        [switch]$Bold,
        [switch]$Strikethrough,
        [switch]$Italic,
        [switch]$Deleted,
        [switch]$SubText,
        [switch]$SupText,
        [switch]$Inserted,
        [switch]$Keyboard,
        [switch]$Underline
    )

    $output = $YourText

    if($Abbreviation){
        $output = @"
        <abbr style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</abbr>
"@
    }
    if($Highlight){
        $output = @"
        <mark style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</mark>
"@
    }
    if($Bold){
        $output = @"
        <strong style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</strong>
"@
    }
    if($Strikethrough){
        $output = @"
        <s style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</s>
"@
    }
    if($Italic){
        $output = @"
        <em style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</em>
"@
    }
    if($Deleted){
        $output = @"
        <del style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</del>
"@
    }
    if($SubText){
        $output = @"
        <sub style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</sub>
"@
    }
    if($SupText){
        $output = @"
        <sup style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</sup>
"@
    }
    if($Inserted){
        $output = @"
        <ins style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</ins>
"@
    }
    if($Keyboard){
        $output = @"
        <kbd style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</kbd>
"@
    }
    if($Underline){
        $output = @"
        <u style='$(if($ColorHexa){"color:$($ColorHexa);"}if($Center){"text-align:center;"})'>$output</u>
"@
    }
    
    return $output

}
Function New-PWFList{
    <#
    .SYNOPSIS
    Create a new HTML list.
    .DESCRIPTION
    Create a new HTML list.
    .PARAMETER List
    Your array.
    .PARAMETER Numbered
    Create a numbered list.
    .EXAMPLE
    New-PWFList -List $myarray
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $List,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Numbered
    )

    $output = @"
    <$(if($Numbered){"o"}else{"u"})l>
        $($List | ForEach-Object{ "<li>$($_)</li>"})
    </$(if($Numbered){"o"}else{"u"})l>
"@

    return $output
}
Function New-PWFHeader{
    <#
    .SYNOPSIS
    Create a new HTML <header>.
    .DESCRIPTION
    Create a new HTML <header>.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFHeader -Content { ... }
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true)]
        $Content,

        [Parameter(Mandatory=$false)]
        [string]$BackgroundColor,
        [switch]$Center
    )
    $output = @"
        <header style="$(if($BackgroundColor){"background-color:$($BackgroundColor);"})$(if($Center){"text-align:center"})">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

        $output += @"
        </header>
"@
    return $output
}
Function New-PWFFooter{
    <#
    .SYNOPSIS
    Create a new HTML <footer>.
    .DESCRIPTION
    Create a new HTML <footer>.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFFooter -Content { ... }
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $Content
    )
    $output = @"
        <footer>
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})
        
        $output += @"
        </footer>
"@
    return $output
}
Function New-PWFCard{
    <#
    .SYNOPSIS
    Create a new HTML <article>.
    .DESCRIPTION
    Create a new HTML <article>.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFCard -Content { ... }
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=1)]
        $Content,

        [Parameter(Mandatory=$false,Position=0)]
        [string]$BackgroundColor="#f9fafb"
    )

            $output = @"
            <article $(write-output "style='background-color:$($BackgroundColor)'")>
"@
            $(try {$output += .$Content} catch {$_.Exception.Message})

            $output += @"
            </article>
"@
    return $output
}
Function New-PWFIcon{
    <#
    .SYNOPSIS
    Create a new icon.
    .DESCRIPTION
    Create a new icon based on Google Material icons database.
    .PARAMETER IconName
    The name of the icon. Choose it here: https://fonts.google.com/icons?selected=Material+Icons
    .PARAMETER Size
    The size of the icon. (18,24,36,48 are defaults about Material guidelines)
    .EXAMPLE
    New-PWFIcon -IconName Settings -SizeInPixel 24
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$IconName,

        [Parameter(Mandatory=$false,Position=1)]
        [string]$SizeinPixel
    )

    $output = @"
        <i class="$(if($SizeinPixel){write-output "style=font-size: $($SizeinPixel)px;"}) material-icons">$IconName</i>
"@

    return $output

}
Function New-PWFText{
    <#
    .SYNOPSIS
    Create a text.
    .DESCRIPTION
    Create a simple text.
    .PARAMETER YourText
    Type the text you want to display in your report.
    .PARAMETER Center
    Move your text to the center of the web page. It's a switch option.
    .EXAMPLE
    New-PWFText -YourText "My text" -Center
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$YourText,
        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Center
    )

    $output = @"
        <p $(if($Center){"'style=text-align:center;'"})>
            $YourText
        </p>
"@

    return $output

}
Function New-PWFBlockQuote{
    <#
    .SYNOPSIS
    Create a blockquote.
    .DESCRIPTION
    Create a blockquote.
    .PARAMETER YourText
    Type the text you want to display in a blockquote.
    .EXAMPLE
    New-PWFBlockQuote -YourText "My text in a blockquote"
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$YourText
    )

    $output = @"
        <blockquote>
            $YourText
        </blockquote>
"@
    return $output
}
Function New-PWFImage{
    <#
    .SYNOPSIS
    Insert an image.
    .DESCRIPTION
    INsert an image a set the size.
    .PARAMETER ImageURL
    You have to type the URL of your Image. Prefer image on a web access.
    .PARAMETER WidthInPercent
    Type the percent you want to define image size. 100% is the width of the parent div.
    .EXAMPLE
    New-PWFImage -ImageURL "https://myimage.." -WidthInPercent 50
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$ImageURL,
        [Parameter(Mandatory=$false,Position=1)]
        [int]$WidthInPercent
    )

    $output = @"
    <img src="$($ImageURL)" $(if($WidthInPercent){"width=$($WidthInPercent)%"})>
"@
    return $output
}
Function New-PWFProgressBar{
    <#
    .SYNOPSIS
    Insert a progress bar.
    .DESCRIPTION
    Insert a progress bar.
    .PARAMETER CurrentValue
    The value of the progress.
    .PARAMETER MaxValue
    The maximum value. Max value is 100% of the progress.
    .EXAMPLE
    New-PWFProgressBar -CurrentValue 25 -MaxValue 200
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [int]$CurrentValue,
        [Parameter(Mandatory=$true,Position=1)]
        [int]$MaxValue
    )

    $output = @"
    <progress value="$($CurrentValue)" max="$($MaxValue)"></progress>
"@
    return $output
}
Function New-PWFTable{
    <#
    .SYNOPSIS
    Create a table from object.
    .DESCRIPTION
    Create a table from a powershell object.
    .PARAMETER ToTable
    The object you want to conver to an HTML table
    .PARAMETER SelectProperties
    Array entry. Select certain properties to not use the totality of the object's properties.
    .PARAMETER EnableFilter
    Enable a search bar that helps you to find any word on the table.
    .PARAMETER Exportbuttons
    Add a XLSX button to export table to XLSX file.
    .PARAMETER Scrollbars
    Limit the size of your table and add vertical and horizontal scrollers
    .PARAMETER ColorForHeader
    Color the table's header
    .PARAMETER ColorForRows
    Color the table's rows
    .PARAMETER ColorForEverySecondRow
    Color the table's rows each second line with another color (better visibility)
    .EXAMPLE
    New-PWFTable -ToTable (Get-PhysicalDisk | Select-Object FriendlyName,Size -SelectProperties @("FriendlyName","Size") -EnableFilter
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $ToTable,

        [Parameter(Mandatory=$false,Position=1)]
        $SelectProperties,
        [switch]$EnableFilter,
        [switch]$Exportbuttons,
        [switch]$Scrollbars,
        [string]$ColorForHeader,
        [string]$ColorForRows,
        [string]$ColorForEverySecondRow

        # Classes: class="striped highlight centered responsive-table"
    )
    $RandomIDTable = ("table$(Get-Random)")

    if($SelectProperties){
        $AllColumnsHeader = ( $ToTable | Select-Object $SelectProperties | Sort-Object $SelectProperties | Get-Member | Where-Object { $_.MemberType -match "Noteproperty"}).Name
    }
    else{
        $AllColumnsHeader = ($ToTable | Get-Member).Name
    }

    if($EnableFilter){
        $RandomIDInput = ("a$(Get-Random)")
        $RandomIDFunction = ("a$(Get-Random)")
        $output = @"
        <input type="text" id="$($RandomIDInput)" placeholder="Search..">
"@
    }
    if($Exportbuttons){
        $RandomIDpExportXLSX = ("p$(Get-Random)")
        $RandomIDpbuttonExportXLSX = ("p$(Get-Random)")
        # Export XLSX
        $output += @"
        <p id="$($RandomIDpExportXLSX)" class="xport">
            <input type="submit" value="XLSX" class="exportbutton" onclick="doit('xlsx');">
        </p>
        <p id="$($RandomIDpbuttonExportXLSX)" class="btn"></p>
"@
    }

    $output += @"
        <table $(if($EnableFilter -or $Exportbuttons){"id='$($RandomIDTable)'"})>
        <thead>
        <tr>
            $($AllColumnsHeader | ForEach-Object { Write-Output "<th$(if($ColorForHeader){write-output " style=background-color:$($ColorForHeader);"})>" $_ "</th>" })
        </tr>
        </thead>

        <tbody>
            $(for ($i = 0; $i -lt $ToTable.Count; $i++) {
                if($ColorForEverySecondRow){
                    if($i % 2 -eq 0 ){
                        $RowColor = $ColorForEverySecondRow
                    }
                    else{
                        $RowColor = $ColorForRows
                    }
                }
                $Row = $ToTable[$i]
                Write-Output "<tr$(if($ColorForRows){write-output " style=background-color:$($RowColor)"})>"
                $AllColumnsHeader | ForEach-Object {
                    Write-Output '<td>' ($Row.$_) '</td>'
                }
            Write-Output "</tr>"})
        </tbody>
    </table>
"@
    if($EnableFilter){
        $output += @"
    <script>
        function SearchFunction$($RandomIDFunction)() {
            var filter = event.target.value.toUpperCase();
            var rows = document.querySelector("#$($RandomIDTable) tbody").rows;
            
            for (var i = 0; i < rows.length; i++) {
                $(for ($i = 0; $i -lt ($ToTable | get-member -MemberType Properties).count; $i++) {
                        Write-Output "var Col$($i) = rows[i].cells[$($i)].textContent.toUpperCase();`r`n"
                    }
                )
                if ($(for ($e = 0; $e -lt ($ToTable | get-member -MemberType Properties).count; $e++) {
                            if($e -eq 0){
                                Write-Output "Col$($e).indexOf(filter) > -1"
                            }else{
                                Write-Output "|| Col$($e).indexOf(filter) > -1"
                            }
                        }
                    )) {
                    rows[i].style.display = "";
                } else {
                    rows[i].style.display = "none";
                }
            }
        }
        document.querySelector('#$($RandomIDInput)').addEventListener('keyup', SearchFunction$($RandomIDFunction), false);
    </script>
"@
    }
    if($Exportbuttons){
        $output += @"
        <script>
        function doit(type, fn, dl) {
            var elt = document.getElementById('$($RandomIDTable)');
            var wb = XLSX.utils.table_to_book(elt, {sheet:"Sheet JS"});
            return dl ?
                XLSX.write(wb, {bookType:type, bookSST:true, type: 'base64'}) :
                XLSX.writeFile(wb, fn || ('YourExportedTable.' + (type || 'xlsx')));
        }

        function tableau(pid, iid, fmt, ofile) {
            if(typeof Downloadify !== 'undefined') Downloadify.create(pid,{
                    swf: 'downloadify.swf',
                    downloadImage: 'download.png',
                    width: 100,
                    height: 30,
                    filename: ofile, data: function() { return doit(fmt, ofile, true); },
                    transparent: false,
                    append: false,
                    dataType: 'base64',
                    onComplete: function(){ alert('Your File Has Been Saved!'); },
                    onCancel: function(){ alert('You have cancelled the saving of this file.'); },
                    onError: function(){ alert('You must put something in the File Contents or there will be nothing to save!'); }
            }); else document.getElementById(pid).innerHTML = "";
        }
        tableau('$($RandomIDpbuttonExportXLSX)', '$($RandomIDpExportXLSX)', 'xlsx', 'YourExportedTable.xlsx');
        
    </script>
"@
    }
    if($Scrollbars){
        return (New-PWFHorizontalScroller -Content { $output} -Scrollbar)
    }else{
        return $output
    }
}
Function New-PWFChart{
    <#
    .SYNOPSIS
    Create a charts from a single object's properties.
    .DESCRIPTION
    Create a charts from a single object's properties. You have to mode. An Automatic count and sum of all values in the specified properties.
    With a Get-Process example, it will group all same process's names and sum them. Next the chart will use the sum of each process's name.
    .PARAMETER AutomaticObject
    The object you want to convert to a chart, you have to specify the property to count and sum.
    .PARAMETER PropertyFilter
    Apply with the AutomaticObject parameter. Use it to specify the property the chart have to use.
    .PARAMETER Object
    The object you want to convert to a chart with custom labels and values filtering.
    .PARAMETER LabelProperty
    The Property of the object chart will use to define labels.
    .PARAMETER ValueProperty
    The Property of the object chart will use to define values to build graphs.
    .PARAMETER ChartName
    Optional. The name of your chart. MUST BE UNIQUE. If name is not unique, all of charts with same name will crash.
    .PARAMETER ChartType
    Optional. Default: doughnut. The type of the chart: Bar, Line, Doughnut, Pie, PolarArea
    .EXAMPLE
    New-PWFChart -Object (Get-Disk | Select-Object FriendlyName,@{Name='Size in GB'; Expression={[math]::Round(($_.Size/1GB),2)}}) -LabelProperty "FriendlyName" -ValueProperty "Size in GB" -ChartType bar -ChartName "DiskSpaceinGB"
    New-PWFChart -AutomaticObject (Get-Process | Select-Object -first 15) -PropertyFilter Name
    .LINK
    https://github.com/qschweitzer/Powershell-HTML5-Reporting
    #>

    [CmdletBinding(DefaultParameterSetName = 'AutomaticSum')]
    param(
        [Parameter(Mandatory = $true,
        ParameterSetName='AutomaticSum',
        HelpMessage = 'Automatic sum of values in a property with a Group-Object; example: Get-Process | Select Name',
        Position = 0)]
        $AutomaticObject,

        [Parameter(Mandatory = $true,
        ParameterSetName='CompleteObject',
        HelpMessage = "Use object's values and labels properties that you indicate.",
        Position = 0)]
        $Object,
        
        [Parameter(Mandatory = $true,
        ParameterSetName = 'AutomaticSum')]
        [string]$PropertyFilter,

        
        [Parameter(Mandatory = $true,
        ParameterSetName = 'CompleteObject')]
        [string]$LabelProperty,
        [string]$ValueProperty,

        [Parameter(ParameterSetName = 'AutomaticSum')]
        [Parameter(ParameterSetName = 'CompleteObject')]
        [Parameter(Mandatory=$false,Position=2)]
        [string]$ChartName,
        [string]$ChartType="doughnut"
        

        # Classes: class="striped highlight centered responsive-table"
    )

    $data = "data$(Get-Random -Maximum 9999)"
    $config = "config$(Get-Random -Maximum 9999)"

    if(!($ChartName)){
        $ChartName = "Chart$(Get-Random)"
    }

    if(!$Object){
        $ChartObject = $AutomaticObject | Group-Object -NoElement -Property $PropertyFilter

        $output = @"
        <div>
            <canvas id="$($ChartName)"></canvas>
        </div>
    
        <script>
            const $($data) = {
                labels: [
                $(
                    For ($i = 0; $i -lt $ChartObject.count; $i++) {
                        if($i -ne ($ChartObject.count)-1){
                            Write-Output "'$($ChartObject[$i].Name)',"
                        }else{
                            Write-Output "'$($ChartObject[$i].Name)'"
                        }
                    }
                )
                ],
                datasets: [{
                label: '$($ChartName)',
                data: [$(
                    For ($j = 0; $j -lt $ChartObject.count; $j++) {
                        if($j -ne ($ChartObject.count)-1){
                            Write-Output "'$($ChartObject[$j].Count)',"
                        }else{
                            Write-Output "'$($ChartObject[$j].Count)'"
                        }
                    }
                )],
                backgroundColor: [
                    'rgb(242, 4, 24)',
                    'rgb(4, 218, 242)',
                    'rgb(242, 202, 4)',
                    'rgb(242, 155, 48)',
                    'rgb(3, 135, 165)'
                ],
                hoverOffset: 50
                }]
            };
    
            const $($config) = {
                type: '$(if("" -ne $ChartType){write-output $ChartType}else{write-output "doughnut"})',
                data: $($data),
              };
    
            var $($ChartName) = new Chart(
                document.getElementById('$($ChartName)'),
                $($config)
            );
        </script>
"@
    }
    else{
        $ChartLabels = $Object."$LabelProperty"
        $ChartValues = $Object."$ValueProperty"

        $output = @"
        <div>
            <canvas id="$($ChartName)"></canvas>
        </div>
    
        <script>
            const $($data) = {
                labels: [
                $(
                    For ($i = 0; $i -lt $ChartLabels.count; $i++) {
                        if($i -ne ($ChartLabels.count)-1){
                            Write-Output "'$($ChartLabels[$i])',"
                        }else{
                            Write-Output "'$($ChartLabels[$i])'"
                        }
                    }
                )
                ],
                datasets: [{
                label: '$($ChartName)',
                data: [$(
                    For ($j = 0; $j -lt $ChartValues.count; $j++) {
                        if($j -ne ($ChartValues.count)-1){
                            Write-Output "'$($ChartValues[$j])',"
                        }else{
                            Write-Output "'$($ChartValues[$j])'"
                        }
                    }
                )],
                backgroundColor: [
                    'rgb(242, 4, 24)',
                    'rgb(4, 218, 242)',
                    'rgb(242, 202, 4)',
                    'rgb(242, 155, 48)',
                    'rgb(3, 135, 165)'
                ],
                hoverOffset: 50
                }]
            };
    
            const $($config) = {
                type: '$(if("" -ne $ChartType){write-output $ChartType}else{write-output "doughnut"})',
                data: $($data),
              };
    
            var $($ChartName) = new Chart(
                document.getElementById('$($ChartName)'),
                $($config)
            );
        </script>
"@
    }
    
return $output
}


######################
#####  EXAMPLES  #####
######################
<#
$TestPage = New-PWFPage -Title "MY FIRST TEST" -Content {
    New-PWFHeader -BackgroundColor "#fff" -Centered -Content {
        New-PWFTitles -TitleText "Hi, I'm generated on a Windows PC with a Powershell script." -Size 1
    }
    New-PWFRow -Content {
        New-PWFColumn -Content {
            New-PWFCard -Content {
                New-PWFTitles -Size 2 -TitleText "This HTML skin is based on $(New-PWFTextFormat -Bold "PicoCSS framework") and $(New-PWFTextFormat -Bold "Charts.JS") for the $(New-PWFTextFormat -ColorHexa "#BF0413" -Highlight "charts")."
                New-PWFText -YourText "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                $(New-PWFTextFormat -Highlight -YourText "You could highlight a text") Nullam ut fermentum lorem, in facilisis ex. Sed nec tristique ex, a posuere tortor.
                Integer laoreet rutrum ante eget ultrices. $(New-PWFTextFormat -Bold "Write a bold text") Proin mi quam, pulvinar eget magna eu, tristique euismod orci.
                $(New-PWFBlockQuote -YourText "You also could display informations in a blockquote")
                $(New-PWFTitles -Size 2 -TitleText (New-PWFTextFormat -YourText "Built with only 75 lines of code !" -Highlight -Keyboard))"
            }
        }
    }
    New-PWFRow -Content {
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#F2EADF" -Content {
                New-PWFTitles -Size 3 -TitleText "That's a card"
                New-PWFText -YourText "You could include some text, or another PWF function.
                Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                Nam ut malesuada lectus, non semper tellus. Proin faucibus ornare erat nec vestibulum.
                Integer laoreet rutrum ante eget ultrices. $(New-PWFTextFormat -Bold "Proin mi quam"), pulvinar eget magna eu, tristique euismod orci.
                Vestibulum nec mauris a ante lobortis molestie vel id tellus"
                New-PWFImage -ImageURL "https://cdn.britannica.com/71/103171-050-BD1B685A/Bill-Gates-Microsoft-Corporation-operating-system-press-2001.jpg" -WidthInPercent 30
                New-PWFTextFormat -YourText "Yup, you could insert image. Hey, Bill !" -Bold
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#243540" -Content {
                New-PWFTitles -Size 3 -TitleText "Let's create some charts - Disks capacity" -LightMode
                New-PWFChart -Object (Get-Disk | Select-Object FriendlyName,@{Name='Size in GB'; Expression={[math]::Round(($_.Size/1GB),2)}}) -LabelProperty "FriendlyName" -ValueProperty "Size in GB" -ChartType bar -ChartName "DiskSpaceinGB"
            }
        }
    }
    New-PWFRow -Content {
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#243540" -Content {
                New-PWFTitles -Size 3 -TitleText "Bar Chart" -LightMode
                New-PWFChart -AutomaticObject (Get-Process | Select-Object -first 15) -PropertyFilter Name -ChartType bar
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#243540" -Content {
                New-PWFTitles -Size 3 -TitleText "Line Chart" -LightMode
                New-PWFChart -AutomaticObject (Get-Process | Select-Object -first 15) -PropertyFilter Name -ChartType line
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#243540" -Content {
                New-PWFTitles -Size 3 -TitleText "Doughnut Chart" -LightMode
                New-PWFChart -AutomaticObject (Get-Process | Select-Object -first 15) -PropertyFilter Name -ChartType doughnut
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#243540" -Content {
                New-PWFTitles -Size 3 -TitleText "Pie Chart" -LightMode
                New-PWFChart -AutomaticObject (Get-Process | Select-Object -first 15) -PropertyFilter Name -ChartType pie
            }
        }
    }
    New-PWFRow -Content {
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#F2935C" -Content {
                New-PWFTitles -Size 3 -TitleText "What about my disks ?" -LightMode
                New-PWFTable -ToTable (Get-PhysicalDisk | Select-Object FriendlyName,@{Name='Size in GB'; Expression={[math]::Round(($_.Size/1GB),2)}}) -SelectProperties @("FriendlyName","Size in GB")
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#011526" -Content {
                New-PWFTitles -Size 3 -TitleText "Search in a table" -LightMode
                New-PWFTable -ToTable (Get-Process | Select-Object Name, Handle -First 10) -SelectProperties @("Name","Handle") -EnableFilter -Exportbuttons
            }
        }
    }
    New-PWFRow -Content {
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#243540" -Content {
                New-PWFTitles -Size 1 -TitleText "Title Size 1 and in LightMode" -LightMode
                New-PWFTitles -Size 2 -TitleText "Title Size 2 and in LightMode" -LightMode
                New-PWFTitles -Size 3 -TitleText "Title Size 3 and in LightMode" -LightMode
                New-PWFTitles -Size 4 -TitleText "Title Size 4 and in LightMode" -LightMode
                New-PWFTitles -Size 5 -TitleText "Title Size 5 and in LightMode" -LightMode
                New-PWFTitles -Size 1 -TitleText "Title Size 1 without LightMode"
            }
        }
        New-PWFColumn -Content {
            New-PWFCard -BackgroundColor "#DFF2F2" -Content {
                New-PWFTitles -Size 3 -TitleText "List first 10 process"
                New-PWFList -List (Get-Process | Select-Object -First 10).Name
            }
        }
    }
}
$TestPage | out-file -Encoding UTF8 -FilePath "C:\Windows\Temp\TestFramework.html"
Start-Process "C:\Windows\Temp\TestFramework.html"
#>
