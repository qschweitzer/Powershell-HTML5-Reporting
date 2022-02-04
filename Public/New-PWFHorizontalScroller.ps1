Function New-PWFHorizontalScroller{
<#
.SYNOPSIS
Create a new HTML figure without class.
.DESCRIPTION
Create a new HTML figure without class. Use it to have an horizontal scroller, for example, of your large table.
See more at: https://picocss.com/docs/#scroller
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.EXAMPLE
New-PWFHorizontalScroller -Content { ... }
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=0)]
    $Content,
    [switch]$Scrollbar
)

    $outputa = @"
    <figure$(if($Scrollbar){write-output " style=height:25em;"})>
"@
    $(try {$outputa += .$Content} catch {$_.Exception.Message})

$outputa += @"
    </figure>
"@

return $outputa

}