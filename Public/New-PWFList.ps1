Function New-PWFList{
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
New-PWFList -List $myarray
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=0)]
    $List,

    [Parameter(Mandatory=$false,Position=1)]
    [switch]$Numbered
)

$output = @"
<$(if($Numbered){"o"}else{"u"})l>
    $($List | ForEach-Object{ "<li>$($_)</li>"})
</$(if($Numbered){"o"}else{"u"})l>
"@

return $output
}