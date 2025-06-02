Function New-WEBProgressBar {
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
New-WEBProgressBar -CurrentValue 25 -MaxValue 200
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
    <div class="progress">
        <div role="progressbar" aria-valuenow="$($CurrentValue)" aria-valuemax="$($MaxValue)" style="width: $($CurrentValue)%"></div>
    </div>
"@
    return $output
}