Function New-PWFTab {
    <#
.SYNOPSIS
Create a new Tab.
.DESCRIPTION
Create a new Tab. Create this tab in the TabContainer.
.PARAMETER Name
Create a new tab with New-PWFTabs
.PARAMETER Content
Add a Content like a scriptblock.
.EXAMPLE
New-PWFTabs -Name "Tab1" -Content {...}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Name,
        $Content,
        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$Container
    )
    $Script:TabsNames += $Name
    $idName = "tab$(Get-Random)"
    $Script:TabsID += $idName

    $output = @"
    <div class="tab-pane fade show$(if($TabsCount -eq 1){" active"})$(if($Container){" container"}else{" container-fluid"})" id="nav-$($idName)" role="tabpanel" aria-labelledby="nav-$($idName)-tab">
    $(try {.$Content} catch {$_.Exception.Message})
    </div>
"@
    $Script:TabsCount++
    return $output
}