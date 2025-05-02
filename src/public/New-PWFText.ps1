Function New-PWFText {
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
        [Parameter(Mandatory = $true, Position = 0)]
        $YourText,
        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$Center
    )

    if ($YourText -is [string]) {
        $YourText = @($YourText -split '\n')
    }

    $output = @"
    $(Foreach($line in $YourText){write-host $line; "$((Convert-MDtoHTML $line))"})
"@
    if ($output.trim() -match "^(\<.*\>)") { return $output }else { return "<p>$output</p>" }

}