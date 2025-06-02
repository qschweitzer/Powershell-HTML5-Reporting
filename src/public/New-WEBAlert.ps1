Function New-WEBAlert {
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
New-WEBAlert -YourText "Your computer isn't up to date" -ContextualColor warning
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $YourText,

        [Parameter(Mandatory = $false, Position = 1)]
        [ValidateSet("primary", "success", "danger", "warning", "info", IgnoreCase = $false)]
        [string]$ContextualColor = "primary"
    )

    $output = @"
<span class="status $(if($ContextualColor){"status-$($ContextualColor)"})">
    $($YourText)
</span>
"@

    return $output
}