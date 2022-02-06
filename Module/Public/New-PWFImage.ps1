Function New-PWFImage {
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
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$ImageURL,
        [Parameter(Mandatory = $false, Position = 1)]
        [int]$WidthInPercent
    )

    $output = @"
<img src="$($ImageURL)" $(if($WidthInPercent){"width=$($WidthInPercent)%"})>
"@
    return $output
}