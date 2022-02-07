Function New-PWFBlockQuote {
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
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$YourText
    )

    $output = @"
    <blockquote>
        $YourText
    </blockquote>
"@
    return $output
}