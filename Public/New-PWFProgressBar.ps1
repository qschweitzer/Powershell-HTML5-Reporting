Function New-PWFProgressBar {
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
        [Parameter(Mandatory = $true, Position = 0)]
        [int]$CurrentValue,
        [Parameter(Mandatory = $true, Position = 1)]
        [int]$MaxValue
    )

    $output = @"
<progress value="$($CurrentValue)" max="$($MaxValue)"></progress>
"@
    return $output
}