Function New-PWFColumn {
    <#
.SYNOPSIS
Create a new HTML div column without class.
.DESCRIPTION
Create a new HTML div column without class. The size of each column is relative to number of column in 100% width.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.EXAMPLE
New-PWFColumn -Content { ... }
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Content
    )

    $output = @"
    <div>
"@
    $(try { $output += .$Content } catch { $_.Exception.Message })

    $output += @"
    </div>
"@

    return $output

}