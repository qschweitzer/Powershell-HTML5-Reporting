Function New-WEBList {
        <#
.SYNOPSIS
Create a new HTML list.
.DESCRIPTION
Create a new HTML list.
.PARAMETER List
Your array.
.PARAMETER Numbered
Create a numbered list.
.EXAMPLE
New-WEBList -List $myarray
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
        param(
                [Parameter(Mandatory = $true, Position = 0)]
                $list,
                $title,
                [Parameter(Mandatory = $false, Position = 1)]
                [switch]$numbered
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
                        <$(if($Numbered){"o"}else{"u"})l>
                                $($List | ForEach-Object{ "<li>$($_ | Convert-MDtoHTML)</li>"})
                        </$(if($Numbered){"o"}else{"u"})l>
"@

        }
        catch { $_.Exception.Message }

        $output += @"
                </div>
        </div>
"@
        return $output
}