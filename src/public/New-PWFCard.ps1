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
        param(
                [Parameter(Mandatory = $true, Position = 1)]
                $Content,
                [string]$Header,
                [Parameter(Mandatory = $false, Position = 0)]
                [string]$BackgroundColor = "#f9fafb"
        )
        [string]$output = @"
        <div class="card">
"@
        if ($Header) {
                $output += @"
                <div class="card-header">
                        <h3>$($Header | Convert-MDtoHTML)</h3>
                </div>
"@
        }
        try {
                if ($Content -is [string]) {
                        $output += $Content  | Convert-MDtoHTML
                }
                else {
                        $output += .$Content 
                }
        }
        catch { $_.Exception.Message }

        $output += @"
        </div>
"@
        return $output
}