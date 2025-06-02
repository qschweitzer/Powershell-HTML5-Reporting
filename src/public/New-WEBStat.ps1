Function New-WEBStat {
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
New-WEBCard -Content { ... } -BackgroundColor "#f9fafb"
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>

        [CmdletBinding(DefaultParameterSetName = "stat")]
        param (
                [Parameter(Mandatory,ParameterSetName = "stat", Position = 0, ValueFromPipeline)]
                [string]$statNumber,
                [Parameter(ParameterSetName = "set")]
                [string]$title,
                [Parameter(Mandatory, ParameterSetName = "stat")]
                [string]$statLabel
        )
        [string]$output = @"
        <div class="card">
"@
        if ($title) {
                $output += @"
                <div class="card-header">
                        <h3 class="card-title">$($title | Convert-MDtoHTML)</h3>
                </div>
"@
        }

        $output += @"
                <div class="card-body $(if($statNumber){"stats-card"})">
"@
        try {
                $output += @"
                        <div class="stats-number">$statNumber</div>
                        <div class="stats-label">$statLabel</div>
"@
        }
        catch { $_.Exception.Message }

        $output += @"
                </div>
        </div>
"@
        return $output
}