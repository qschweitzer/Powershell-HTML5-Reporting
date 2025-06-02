Function New-PWFCard {
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
New-PWFCard -Content { ... } -BackgroundColor "#f9fafb"
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>

        param (
                [Parameter(Mandatory,Position = 0, ValueFromPipeline)]
                $Content,
                [Parameter(Position = 1)]
                [string]$title
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
        else{
                $script:noheader = $true
        }

        $output += @"
                <div class="card-body $(if($statNumber){"stats-card"})">
"@
        try {
                if ($Content -is [string]) {
                        $output += $Content  | Convert-MDtoHTML
                }
                elseif($Content -is [scriptblock]) {
                        $output += .$Content 
                }
        }
        catch { $_.Exception.Message }

        $output += @"
                </div>
        </div>
"@
        return $output
}