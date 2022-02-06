Function New-PWFCardFooter {
    <#
.SYNOPSIS
Create a new HTML <footer>.
.DESCRIPTION
Create a new HTML <footer>.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.EXAMPLE
New-PWFCardFooter -Content { ... }
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Content
    )
    $output = @"
    <footer>
"@
    $(try { $output += .$Content } catch { $_.Exception.Message })
    $output += @"
    </footer>
"@
    return $output
}