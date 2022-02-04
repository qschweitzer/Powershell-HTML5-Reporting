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