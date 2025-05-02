Function New-PWFBadge {
    <#
.SYNOPSIS
Insert a badge.
.DESCRIPTION
Insert a badge.
.PARAMETER YourText
The text to display.
.PARAMETER Type
Type of badge: Primary, Secondary, Success, Danger, Warning, Info, Light, Dark. Default is Primary.
.EXAMPLE
New-PWFBadge -YourText "Hello" -Type Success
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$YourText,
        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateSet("default", "primary", "secondary", "success", "danger", "warning", "info", "light", "dark", IgnoreCase = $false)]
        [string]$Type,
        [switch]$PillMode
    )

    $output = @"
<span class='badge$(if($PillMode){" rounded-pill"}) bg-$($Type)'>$($YourText)</span>
"@
    return $output
}