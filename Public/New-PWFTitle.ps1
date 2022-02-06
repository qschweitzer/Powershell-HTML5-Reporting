Function New-PWFTitle {
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
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$TitleText,
        [int]$Size,

        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$Center,
        [switch]$LightMode
    )

    $output = @"
    <H$($Size) style='$(if($LightMode){"color:#fff;"}if($Center){"text-align:center;"})'>$TitleText</H$($Size)>
"@
    return $output
}