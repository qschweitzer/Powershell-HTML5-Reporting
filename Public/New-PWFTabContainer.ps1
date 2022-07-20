Function New-PWFTabContainer {
    <#
.SYNOPSIS
Create a new Tab navigation bar with tabs.
.DESCRIPTION
Create a new Tab navigation bar with tabs.
.PARAMETER Tabs
Create a new tab with New-PWFTabs
.EXAMPLE
New-PWFTabContainer -Tabs { New-PWFTabs -Name "Tab1" -Content {}}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Tabs
    )
    $Script:TabsNames = @()
    $Script:TabsCount = 1
    $Script:TabsID = @()
    $TabContentID = "Container$(Get-Random)"
    $RandomIDNavTab = "NavTab$(Get-Random)"

    $TabsOutput = .$Tabs
    $output = @"
<nav>
    <div class="nav nav-tabs" id="$($RandomIDNavTab)" role="tablist">
    $(
        for($i=0; $i -le $Script:TabsID.count; $i++){
            "<button class='nav-link$(if($i -eq 0){" active"})' id='nav-$($Script:TabsID[$i])-tab' data-bs-toggle='tab' data-bs-target='#nav-$($Script:TabsID[$i])' type='button' role='tab' aria-controls='nav-$($Script:TabsID[$i])'$(if($i -eq 0){" aria-selected='true'"})>$($Script:TabsNames[$i])</button>`r`n"
        }
    )
    </div>
</nav>
<div class="tab-content" id="$($TabContentID)">
    $($TabsOutput)
</div>
"@

    return $output
}
