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
    $RandomIDNavTab = "NavTab$(Get-Random)"

    $TabsOutput = .$Tabs
    $output = @"
<nav>
    <div class="nav nav-tabs" id="$($RandomIDNavTab)" role="tablist">
    $(try {
        for($i=0; $i -lt $TabsID.count; $i++){
            "<button class='nav-link$(if($i -eq 0){" active"})' id='nav-$($TabsID[$i])-tab' data-bs-toggle='tab' data-bs-target='#nav-$($TabsID[$i])' type='button' role='tab' aria-controls='nav-$($TabsID[$i])'$(if($i -eq 0){" aria-selected='true'"})>$($TabsNames[$i])</button>`r`n"
        }
    }
    catch
    {
        $_.Exception.Message
    })
    </div>
</nav>
<div class="tab-content" id="nav-tabContent">
    $($TabsOutput)
</div>
"@

    return $output
}
