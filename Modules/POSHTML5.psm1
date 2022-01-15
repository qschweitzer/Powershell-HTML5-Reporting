<#
.SYNOPSIS
These functions lets you create an HTML5  web page with dynamic table and charts, easily.
.DESCRIPTION
Create a new HTML5 page with dynamic tables and charts, easily. Som example at the end in the EXAMPLES section.
.NOTES
  Version:        2.2.1
  Author:         Quentin Schweitzer
  Creation Date:  28.11.2021
  Purpose/Change: Adding Alert function, fixing a bug with Firefox displaying (text in dark mode event if no theme selected), fixing some bugs.
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
          <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css" >
          <!--Import Bootstrap minified CSS -->
          <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
          <!--Import Custom PicoCSS minified CSS -->
          <link href="https://cdn.jsdelivr.net/gh/qschweitzer/Powershell-HTML5-Reporting/css/PicoCssModified.min.css" rel="stylesheet" crossorigin="anonymous">
          <!--Import Table Export minified CSS -->
          <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/css/tableexport.min.css" >
          <!--Import Google Icon Font-->
          <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
          <!-- CUSTOM STYLES -->
          <style>
          .btn-group {
            margin-bottom: 0;
          }
          .page-item .page-link {
            color: #fff;
            background-color: #6c757d;
            border-color: #6c757d;
          }
          .page-item.active .page-link {
            color: #fff;
            background-color: #5c636a;
            border-color: #5c636b;
          }
          .bootstrap-table .fixed-table-container .table {
              background-color: white;
          }
          article,
          .bootstrap-table {
            --block-spacing-horizontal: 0;
          }
          </style>
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

Function New-PWFTabContainer{
<#
.SYNOPSIS
Create a new Tab navigation bar with tabs.
.DESCRIPTION
Create a new Tab navigation bar with tabs.
.PARAMETER Tabs
Create a new tab with New-PWFTabs
.EXAMPLE
New-PWFTabContainer -Tabs { New-PWFTabs -Name "Tab1" -Content {}}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=0)]
    $Tabs
)
$Script:TabsNames = @()
$Script:TabsCount = 1
$Script:TabsID = @()
$RandomIDNavTab = "NavTab$(Get-Random)"

$TabsOutput = .$Tabs
$output = @"
<nav>
  <div class="nav nav-tabs" id="$($RandomIDNavTab)" role="tablist">
    $(try {
        for($i=0; $i -lt $TabsID.count; $i++){
            "<button class='nav-link$(if($i -eq 0){" active"})' id='nav-$($TabsID[$i])-tab' data-bs-toggle='tab' data-bs-target='#nav-$($TabsID[$i])' type='button' role='tab' aria-controls='nav-$($TabsID[$i])'$(if($i -eq 0){" aria-selected='true'"})>$($TabsNames[$i])</button>`r`n"
        }
    }
    catch
    {
        $_.Exception.Message
    })
  </div>
</nav>
<div class="tab-content" id="nav-tabContent">
    $($TabsOutput)
</div>
"@

return $output
}
Function New-PWFTab{
<#
.SYNOPSIS
Create a new Tab.
.DESCRIPTION
Create a new Tab. Create this tab in the TabContainer.
.PARAMETER Name
Create a new tab with New-PWFTabs
.PARAMETER Content
Add a Content like a scriptblock.
.EXAMPLE
New-PWFTabs -Name "Tab1" -Content {...}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=0)]
    $Name,
    $Content,
    [Parameter(Mandatory=$false,Position=1)]
    [switch]$Container
)
$Script:TabsNames += $Name
$idName = "tab$(Get-Random)"
$Script:TabsID+=$idName

$output = @"
  <div class="tab-pane fade show$(if($TabsCount -eq 1){" active"})$(if($Container){" container"}else{" container-fluid"})" id="nav-$($idName)" role="tabpanel" aria-labelledby="nav-$($idName)-tab">
  $(try {.$Content} catch {$_.Exception.Message})
  </div>
"@
$Script:TabsCount++
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
      <H$($Size) style='$(if($LightMode){"color:#fff;"}if($Center){"text-align:center;"})'>$TitleText</H$($Size)>
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
  function LoopFormat {
      param (
          $Text,
          $Type,
          $ColorHexa
      )
      $Result = @"
          <$($Type) style='$(if($ColorHexa){"color:$($ColorHexa);"})'>$($Text -split '\n' | ForEach-Object {"$_"})</$($Type)>
"@

      return $Result
  }

  $output = $YourText
  $type = ""

  if($Abbreviation){
      $type += "abbr;"
  }
  if($Highlight){
      $type += "mark;"
  }
  if($Bold){
      $type += "strong;"
  }
  if($Strikethrough){
      $type += "s;"
  }
  if($Italic){
      $type += "em;"
  }
  if($Deleted){
      $type += "del;"
  }
  if($SubText){
      $type += "sub;"
  }
  if($SupText){
      $type += "sup;"
  }
  if($Inserted){
      $type += "ins;"
  }
  if($Keyboard){
      $type += "kbd;"
  }
  if($Underline){
      $type += "u;"
  }
  if($type -eq ""){
      $type += "span;"
  }

  $type = $type -split ";"


  $type | Where-Object { $_ -ne ""} | ForEach-Object {
      $output = LoopFormat -Text $output -Type $_ -ColorHexa $ColorHexa
  }

  return $output
}
Function New-PWFText{
  <#
  .SYNOPSIS
  Create a text.
  .DESCRIPTION
  Create a simple text.
  .PARAMETER YourText
  Type the text you want to display in your report. Support string or single array.
  .PARAMETER Center
  Move your text to the center of the web page. It's a switch option.
  .EXAMPLE
  New-PWFText -YourText "My text" -Center
  .LINK
  https://github.com/qschweitzer/Powershell-HTML5-Reporting
  #>
  param(
      [Parameter(Mandatory=$true,Position=0)]
      $YourText,
      [Parameter(Mandatory=$false,Position=1)]
      [switch]$Center
  )

  switch($YourText.gettype().Name){
      "Object[]" {
          $output = @"
          <p$(if($Center){" style='text-align:center;'"})>
              $(For($i=0; $i -le $YourText.count; $i++){if($i -lt $YourText.count){"$($YourText[$i]) <br>"}else{$($YourText[$i])}})
          </p>
"@
      }
      "String" {
          $output = @"
          <p$(if($Center){" style='text-align:center;'"})>
              $($Splitted = ($YourText -split '\n'))
              $(For($i=0; $i -le $Splitted.count; $i++){if($i -lt $splitted.count){"$($Splitted[$i]) <br>"}else{$($Splitted[$i])} })
          </p>
"@
      }
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
Function New-PWFAlert{
  <#
  .SYNOPSIS
  Create a new HTML alert.
  .DESCRIPTION
  Create a new HTML alert.
  .PARAMETER YourText
  Your text in alert.
  .PARAMETER ContextualColor
  A color from the validate set.
  .EXAMPLE
  New-PWFAlert -YourText "Your computer isn't up to date" -ContextualColor warning
  .LINK
  https://github.com/qschweitzer/Powershell-HTML5-Reporting
  #>
  param(
      [Parameter(Mandatory=$true,Position=0)]
      $YourText,

      [Parameter(Mandatory=$false,Position=1)]
      [ValidateSet("default", "primary", "secondary", "success", "danger", "warning","info","light","dark", IgnoreCase = $false)]
      [string]$ContextualColor="default"
  )

  $output = @"
  <div class="alert $(if($ContextualColor){"alert-$($ContextualColor)"})" role="alert">
    $($YourText)
  </div>
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
  .PARAMETER BackgroundColor
  The Content background. 
  .EXAMPLE
  New-PWFCard -Content { ... } -BackgroundColor "#f9fafb"
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
Function New-PWFCardHeader{
  <#
  .SYNOPSIS
  Create a new HTML <header>.
  .DESCRIPTION
  Create a new HTML <header>.
  .PARAMETER Content
  The Content is a scriptblock that will contain next blocks parts.
  .EXAMPLE
  New-PWFCardHeader -Content { ... }
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
Function New-PWFCardFooter{
  <#
  .SYNOPSIS
  Create a new HTML <footer>.
  .DESCRIPTION
  Create a new HTML <footer>.
  .PARAMETER Content
  The Content is a scriptblock that will contain next blocks parts.
  .EXAMPLE
  New-PWFCardFooter -Content { ... }
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
  Array or string (separate by comma) entries. Select certain properties to not use the totality of the object's properties.
  .PARAMETER EnableSearch
  Enable a search bar that helps you to find any word on the table.
  .PARAMETER Exportbuttons
  Add a XLSX button to export table to XLSX file.
  .PARAMETER Pagination
  Limit the size of your table and add pagination system.
  .PARAMETER ShowTooltip
  Add a toolbar with some options like fullscreen your tab, enable/disable pagination...
  .PARAMETER DetailsOnClick
  Use it to large objects, it will limit the width size of your table and add all other properties in a details pane. Just click on the row to display details.
  .PARAMETER EnableConditionnalFormat
  Enable addition of condition with next parameters ConditionProperties,COnditionOperators,ConditionValues,ConditionBackgroundColors. Each of them nedd to have same number of properties,operators,values.
  .PARAMETER ConditionProperties
  Add the different properties where you want to add a condition, in a string format and joined by comma: "Property1,Property2"
  .PARAMETER ConditionOperators
  Add the different operators of the conditions, in powershell format: "-lt,-gt"
  .PARAMETER ConditionValues
  Add the different values to control condition: "1,8"
  .PARAMETER ConditionBackgroundColors
  Add a background color if the condition match
  .PARAMETER ColorForHeader
  Color the table's header
  .PARAMETER ColorForRows
  Color the table's rows
  .PARAMETER ColorForEverySecondRow
  Color the table's rows each second line with another color (better visibility)
  .EXAMPLE
  New-PWFTable -ToTable (Get-Process | Group-Object -Property Name -NoElement | Sort-Object Count -Descending | select Name, Count) -SelectProperties "Name,Count" -EnableConditionnalFormat -ConditionProperties "Count,Name" -ConditionOperators "-gt,-match" -ConditionValues "2,svchost" -ConditionBackgroundColors "#ff0000,#FFFF00"
  .LINK
  https://github.com/qschweitzer/Powershell-HTML5-Reporting
  #>
  param(
      [Parameter(Mandatory=$true,Position=0)]
      $ToTable,

      [Parameter(Mandatory=$false,Position=1)]
      $SelectProperties,
      [switch]$EnableSearch,
      [switch]$Exportbuttons,

      [Parameter(Mandatory = $false,
      ParameterSetName='Conditionnal',
      HelpMessage = "Enable conditionnal format on certain values.",
      Position = 2)]
      [switch]$EnableConditionnalFormat,
      [Parameter(ParameterSetName='Conditionnal', Position = 3)]
      $ConditionProperties,
      $ConditionOperators,
      $ConditionValues,
      $ConditionBackgroundColors,

      [Parameter(Mandatory=$false,Position=4)]
      [switch]$Pagination,
      [switch]$ShowTooltip,
      [switch]$DetailsOnClick,
      [switch]$SortByColumn,
      [switch]$Striped,
      [switch]$Dark,
      [switch]$Small,
      [ValidateSet("default", "primary", "secondary", "success", "danger", "warning","info","light","dark", IgnoreCase = $false)]
      [string]$ContextualColor

      # Classes: class="striped highlight centered responsive-table"
  )

  $RandomIDTable = ("table$(Get-Random)")
  $RandomIDFuncDetailFormatter = "detailFormatter$(Get-Random)"
  $RandomIDFuncCustomSort = "customSort$(Get-Random)"
  $ConditionnalObjects = @()
  if($SelectProperties -and $SelectProperties.gettype().Name -eq "String"){
    $SelectProperties = $SelectProperties.split(',')
  }
  if($ConditionProperties -match ","){$ConditionProperties = $ConditionProperties.split(",")}else{$ConditionProperties= [array]$ConditionProperties}
  if($ConditionOperators -match ","){$ConditionOperators = $ConditionOperators.split(",")}else{$ConditionOperators= [array]$ConditionOperators}
  if($ConditionValues -match ","){$ConditionValues = $ConditionValues.split(",")}else{$ConditionValues= [array]$ConditionValues}
  if($ConditionBackgroundColors -match ","){$ConditionBackgroundColors = $ConditionBackgroundColors.split(",")}else{$ConditionBackgroundColors= [array]$ConditionBackgroundColors}
  if($EnableConditionnalFormat){
    For($e =0; $e -lt ($ConditionProperties | Measure-Object).count; $e++) {
      $ConditionnalObject = New-Object psobject
      $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "PropertyName" -Value $ConditionProperties[$e]
      $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "Operator" -Value $ConditionOperators[$e]
      $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "Value" -Value $ConditionValues[$e]
      $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "ColorHexa" -Value $ConditionBackgroundColors[$e]
      $ConditionnalObjects += $ConditionnalObject
    }
  }
  if($SelectProperties){
      $AllColumnsHeader = $SelectProperties
  }
  else{
      $AllColumnsHeader = ($ToTable | Get-Member -MemberType Properties).Name
  }

  $output += @"
      <table class='$(if($Striped){" table-striped"}if($Dark){" table-dark"}if($Small){" table-sm"}if($ContextualColor){" table-$($ContextualColor)"})' id='$($RandomIDTable)' data-toggle='table' $(if($EnableSearch){
        '
        data-search="true"
        '
      })
        $(if($Pagination){'data-pagination="true"'})
        $(if($Exportbuttons){
          '
          data-show-export="true"
          '
        })
        $(if($ShowTooltip){
          '
          data-show-columns="true"
          data-show-columns-toggle-all="true"
          data-show-pagination-switch="true"
          data-show-toggle="true"
          data-show-fullscreen="true"
          data-buttons="buttons"
          '
        })
        $(if($DetailsOnClick){
          "
          data-detail-view='true'
          data-detail-formatter='$($RandomIDFuncDetailFormatter)'
          data-detail-view-icon='false'
          data-detail-view-by-click='true'
          "
        })
        $(if($SortByColumn){
          "
          data-custom-sort='$($RandomIDFuncCustomSort)'
          "
        })
      >
      <thead>
      <tr>
        $($AllColumnsHeader | ForEach-Object { Write-Output "<th$(if($ColorForHeader){write-output " style=background-color:'$($ColorForHeader);'"}) data-field="$($_)"$(if($SortByColumn){" data-sortable='true'"})>" $_ "</th>" })
      </tr>
      </thead>

      <tbody>
          $(for ($i = 0; $i -lt ($ToTable | Measure-Object).count; $i++) {
              if($ColorForEverySecondRow){
                  if($i % 2 -eq 0 ){
                      $RowColor = $ColorForEverySecondRow
                  }
                  else{
                      $RowColor = $ColorForRows
                  }
              }
              else{
                $RowColor = $ColorForRows
              }
              $Row = $ToTable[$i]
              $RandomIDBodyTR = ("tr-id-$(Get-Random)")
              Write-Output "<tr id='$($RandomIDBodyTR)' $(if($ColorForRows){write-output " style=background-color:$($RowColor)"})>"

              $AllColumnsHeader | ForEach-Object {
                  $RandomIDBodyTD = ("tr-id-$(Get-Random)")
                  $ActualProperty = $_
                  if(($ActualProperty -in $ConditionnalObjects.PropertyName)){
                    $ConditionnalObjects | ForEach-Object {
                      if($_.PropertyName -eq $ActualProperty){
                      $ActualCondition = $_
                      try{
                        $ActualValue = [int]$Row.$ActualProperty
                      }catch{
                        $ActualValue = $Row.$ActualProperty
                      }
                      try{
                        $ConditionCmd = ('[int]$ActualValue' + " " + $ActualCondition.Operator + " " + '[int]$ActualCondition.Value')
                        $ConditionResult = (Invoke-Expression $ConditionCmd)
                      }catch{
                        $ConditionCmd = ('$ActualValue' + " " + $ActualCondition.Operator + " " + '$ActualCondition.Value') 
                        $ConditionResult = (Invoke-Expression $ConditionCmd)
                      }
                      if($ConditionResult -eq "True"){
                        $ConditionnalValidated = Write-Output "<td id='$($RandomIDBodyTD)' style='background-color: $($ActualCondition.ColorHexa)'> $($ActualValue) </td>"
                      }
                    }
                  }
                  if($ConditionnalValidated){
                    Write-Output $ConditionnalValidated
                  }else{
                    Write-Output "<td id='$($RandomIDBodyTD)'> $($Row.$ActualProperty) </td>"
                  }
                  $ConditionnalValidated = $null
                }
                else{
                  Write-Output "<td id='$($RandomIDBodyTD)'> $($Row.$ActualProperty) </td>"
                }
              }
          Write-Output "</tr>"})
      </tbody>
  </table>
  <script>
  var `$table1$($RandomIDTable) = `$('#$($RandomIDTable)')

  `$(function() {
    `$table1$($RandomIDTable).bootstrapTable({
      columns: [$(for($m=0; $m -lt $SelectProperties.count; $m++){
        "{
          title: '$($SelectProperties[$m])',
          field: '$($SelectProperties[$m])'
        }$(if($m -ne $SelectProperties.count){","})"
      })]
    })
  })
  </script>
  $(if($DetailsOnClick){
    "<script>
      function $($RandomIDFuncDetailFormatter)(index, row) {
        var html = []
        $.each(row, function (key, value) {
          html.push('<p><b>' + key + ':</b> ' + value + '</p>')
        })
        return html.join('')
      }
    </script>"
  })
  $(if($SortByColumn){
    $RandomIDvarOrder = "order$(Get-random)"
    $RandomIDvaraa = "aa$(Get-random)"
    $RandomIDvarbb = "bb$(Get-random)"
    "<script>
    function $($RandomIDFuncCustomSort)(sortName, sortOrder, data) {
      var $($RandomIDvarOrder) = sortOrder === 'desc' ? -1 : 1
      data.sort(function (a, b) {
        var $($RandomIDvaraa) = +((a[sortName] + '').replace(/[^\d]/g, ''))
        var $($RandomIDvarbb) = +((b[sortName] + '').replace(/[^\d]/g, ''))
        if ($($RandomIDvaraa) < $($RandomIDvarbb)) {
          return $($RandomIDvarOrder) * -1
        }
        if ($($RandomIDvaraa) > $($RandomIDvarbb)) {
          return $($RandomIDvarOrder)
        }
        return 0
      })
    }
    </script>"
  })
  $(if($Exportbuttons){
    "
    <script>
    var `$table$($RandomIDTable) = `$('#$($RandomIDTable)')
    `$(function() {
      `$table$($RandomIDTable).bootstrapTable('destroy').bootstrapTable({
        exportTypes: ['json', 'xml', 'png', 'csv', 'txt', 'excel', 'pdf'],
        columns: [
          $(for ($p=0; $p -lt ($AllColumnsHeader | Measure-Object).count; $p++){
            if($p -eq ($AllColumnsHeader | Measure-Object).count){
              Write-Output "
              {
                field: '$($AllColumnsHeader[$p])'
              }
            "
            }else{
              Write-Output "
              {
                field: '$($AllColumnsHeader[$p])'
              },
              "
            }
          })
        ]
      })
    })
    </script>
    "
  })
"@

  return $output
}

Function New-PWFChart{
<#
.SYNOPSIS
Create a new ChartJS chart.
.DESCRIPTION
Create a new Chart. Enter your data and tadaaa.
.PARAMETER ChartTitle
Your chart title.
.PARAMETER ChartType
"bar", "doughnut", "pie", "line", "radar", "polar"
.PARAMETER ChartLabels,
Your labels, from an object/array or in a string format separate by semi-colon: "Label1;Label2;LabelRouge"
.PARAMETER ChartValues
Your data [int], from an object/array or in a string format separate by semi-colon: "1;2;3"
.PARAMETER Stacked
Enable the stacked chart format.
.PARAMETER StackedContent
Use when Stacked selected. Scriptblock that contains the New-PWFChartStackedDataset functions
.PARAMETER Legends
Use when Stacked selected. Your legends, from an object/array or in a string format separate by semi-colon: "Label1;Label2;LabelRouge"
.PARAMETER Horizontal
The color to color y
.PARAMETER ChartColors
The color to color your data set in the chart. Default is colors generated automatically from a custom defined list with flat colours.
.PARAMETER LightMode
In lightmode all the chart text's color is white.
.PARAMETER DontShowTitle
Hide the chart's title.
.EXAMPLE
New-PWFChart -ChartTitle "Line Chart 1" -ChartType "line" -ChartLabels $ChartDataset.Name -ChartValues ($ChartDataset | select -ExpandProperty count)
New-PWFChart -Stacked -ChartTitle "Stacked Bars" -ChartType "bar" -Legends "Janvier;Fevrier;Mars;Avril" -StackedContent {
  New-PWFChartStackedDataset -Name "Dataset1" -Values "1;2;3;4"
  New-PWFChartStackedDataset -Name "Dataset2" -Values "4;3;2;1"
}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
  [Parameter(Mandatory = $true,ParameterSetName='Stacked',Position = 0)]
  [Parameter(Mandatory = $true,ParameterSetName='NotStacked',Position = 0)]
  $ChartTitle,
  [ValidateSet("bar", "doughnut", "pie", "line", "radar", "polar", IgnoreCase = $false)]
  $ChartType,

  [Parameter(
  ParameterSetName='Stacked',
  HelpMessage = 'If Stacked selected, you have to create a hashtable with datasets.',
  Position = 1)]
  [switch]$Stacked,

  [Parameter(
  ParameterSetName='NotStacked',
  HelpMessage = 'Classic chart.',
  Position = 2)]
  $ChartLabels,

  [Parameter(Mandatory = $true,ParameterSetName='NotStacked',Position = 3)]
  $ChartValues,

  [Parameter(Mandatory = $true,ParameterSetName='Stacked',Position = 2)]
  $Legends,

  [Parameter(Mandatory = $false,ParameterSetName='Stacked',Position = 3)]
  [Parameter(Mandatory = $false,ParameterSetName='NotStacked',Position = 4)]
  [switch]$Horizontal,
  $ChartColors,
  [switch]$LightMode,
  [switch]$DontShowTitle,

  [Parameter(Mandatory = $true,ParameterSetName='Stacked',Position = 2)]
  $StackedContent
  )
  if(!$Stacked){
    #Switch ChartLabels from string to array, splitted by comma
    if($ChartLabels.gettype().Name -eq "String"){
      $ChartLabels = $ChartLabels.split(";")
    }
    #Switch ChartValues from string to array, splitted by comma
    if($ChartValues.gettype().Name -eq "String"){
      $ChartValues = $ChartValues.split(";")
    }
    #Switch ChartColors from string to array, splitted by comma
    if($ChartColors -and ($ChartColors.gettype().Name -eq "String")){
      $ChartColors = $ChartColors.split(";")
    }
  }

  if(!$Stacked){
    $ChartCount = ($ChartValues | Measure-Object).count
    $ChartDatasets = $ChartLabels
  }else{
    if($Legends.gettype().Name -eq "String"){
      $Legends = $Legends.split(";s")
    }
  }

  if($null -eq $ChartColors){
    $ChartColors = $script:ChartColorsPalette
  }

  $ID = "ID$(Get-Random -Maximum 9999)"
  $data = "data$(Get-Random -Maximum 9999)"
  $config = "config$(Get-Random -Maximum 9999)"
  $labels = "labels$(Get-Random -Maximum 9999)"
  $Script:StackedColorsCount = 0
  

  $output = @"
  <div>
      <canvas id="$($ID)"></canvas>
  </div>

  <script>
"@
  if($Stacked){
    $Script:StackedChartName = @()
    $StackedContent = .$StackedContent
    $output += @"
          const $($labels) = ['$($Legends -join "','")'];
          const $($data) = {
            labels: $($labels),
            datasets: [
              $(try{ $StackedContent }catch{ })
            ]
          };
"@
    $Script:StackedChartName = @()
  }else
  {
    $output += @"
          const $($data) = {
            labels: [
            $(
                For ($i = 0; $i -lt ($ChartLabels | Measure-Object).count; $i++) {
                  Write-Output "'$($ChartLabels[$i])'$(if($i -ne (($ChartLabels | Measure-Object).count)-1){","})"
                }
            )
            ],
          datasets: [{
            label: '$($ChartTitle)',
            data: [$(
                For ($j = 0; $j -lt ($ChartValues | Measure-Object).count; $j++) {
                  Write-Output "'$($ChartValues[$j])'$(if($j -ne (($ChartValues | Measure-Object).count)-1){","})"
                })
            ],
            backgroundColor: [
                $(For ($k = 0; $k -lt ($ChartColors | Measure-Object).count; $k++) {
                  Write-Output "'$($ChartColors[$k])'$(if($k -lt (($ChartColors | Measure-Object).count)){","})"
                })
            ],
            hoverOffset: 5,
            tension: 0.5
          }]
      };
"@
  }
    $output += @"
    
      const $($config) = {
        type: '$(if("" -ne $ChartType){write-output $ChartType}else{write-output "doughnut"})',
        data: $($data),
        options: {
          $(if($Horizontal -and ($ChartType -eq "bar")){
          "indexAxis: 'y',"
          })
          plugins: {
            legend: {
              display: true,
              labels: {
                $(if($LightMode){"color: '#fff'"})
              }
            },
            title: {
              display: $(if($DontShowTitle){"false"}else{"true"}),
              $(if($LightMode){"color: '#fff',"})
              text: '$($ChartTitle)'
            }
          },
          responsive: true,
          scales: {
            x: {
              $(if($Stacked){"stacked: true,"})
              ticks: {
                $(if($LightMode){"color: '#fff'"})
              }
            },
            y: {
              $(if($Stacked){"stacked: true,"})
              ticks: {
                $(if($LightMode){"color: '#fff'"})
              }
            }
          }
        }
      };

      var $($ID) = new Chart(
          document.getElementById('$($ID)'),
          $($config)
      );
  </script>
"@
  
return $output
}
Function New-PWFChartStackedDataset{
<#
.SYNOPSIS
Create a new chart Dataset for stacked chart only.
.DESCRIPTION
Create a new chart Dataset for stacked chart only.
.PARAMETER Name
The name of your data set.
.PARAMETER Values
The [int] values of your dataset. You could use an object/array or type values as a string, separated by semi-colon like "1;9;3"
.PARAMETER Color
The color to color your data set in the chart. Default is colors generated automatically from thecolorapi.com.
.EXAMPLE
New-PWFChartStackedDataset -Name "January" -Values 1..31
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
  [Parameter(Mandatory = $true,Position = 0)]
  $Name,
  $Values,
  [Parameter(Mandatory = $false,Position = 1)]
  $Color
)
if($Values.gettype().name -eq "String"){
  $Values = $Values.split(";")
}
if(!$Color){
  $ColorGenerated = $script:ChartColorsPalette
}

$Script:StackedChartName += $Name
Write-Output @"
    {
      label: '$($Name)',
      data: ['$($Values -join "','")'],
      backgroundColor: '$(if($ColorGenerated){$ColorGenerated[($Script:StackedColorsCount)]}else{$Color})',
    },
"@
$Script:StackedColorsCount++
}

Export-ModuleMember -Function *