Function New-PWFListGroup {
    <#
.SYNOPSIS
Create a new ListGroup.
.DESCRIPTION
Create a new ListGroup.
.PARAMETER GroupItems
Scriptblock containing ListGroupItems
.PARAMETER Numbered
Create a numbered list.
.EXAMPLE
New-PWFListGroup -Numbered -GroupItems {
    New-PWFListGroupItem -ItemContent "Test 1" -SubHeading "SubHeading 1" -BadgeContent "2"
    New-PWFListGroupItem -ItemContent "Test 2" -SubHeading "SubHeading 2" -BadgeContent "4"
    New-PWFListGroupItem -ItemContent "Test 3" -SubHeading "SubHeading 3" -BadgeContent "156"
}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $GroupItems,

        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$Numbered
    )

    $output = @"
        <$(if($Numbered){"o"}else{"u"})l class="list-group list-group-numbered">
            $(try { .$GroupItems } catch { $_.Exception.Message })
        </$(if($Numbered){"o"}else{"u"})l>
"@

    return $output
}