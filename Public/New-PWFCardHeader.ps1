Function New-PWFCardHeader{
<#
.SYNOPSIS
Create a new HTML <header>.
.DESCRIPTION
Create a new HTML <header>.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.EXAMPLE
New-PWFCardHeader -Content { ... }
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true)]
    $Content,

    [Parameter(Mandatory=$false)]
    [string]$BackgroundColor,
    [switch]$Center
)
$output = @"
    <header style="$(if($BackgroundColor){"background-color:$($BackgroundColor);"})$(if($Center){"text-align:center"})">
"@
    $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
    </header>
"@
return $output
}