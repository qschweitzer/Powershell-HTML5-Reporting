Function New-PWFRow {
    <#
.SYNOPSIS
Create a new HTML div with Row class.
.DESCRIPTION
Create a new HTML div with Row class.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.EXAMPLE
New-PWFRow -Content { ... }
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Content
    )

    $output = @"
    <div class="grid">
"@
    $(try { $output += .$Content } catch { $_.Exception.Message })

    $output += @"
    </div>
"@

    return $output

}