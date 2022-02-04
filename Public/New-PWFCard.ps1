Function New-PWFCard{
<#
.SYNOPSIS
Create a new HTML <article>.
.DESCRIPTION
Create a new HTML <article>.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.PARAMETER BackgroundColor
The Content background. 
.EXAMPLE
New-PWFCard -Content { ... } -BackgroundColor "#f9fafb"
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=1)]
    $Content,

    [Parameter(Mandatory=$false,Position=0)]
    [string]$BackgroundColor="#f9fafb"
)

        $output = @"
        <article $(write-output "style='background-color:$($BackgroundColor)'")>
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

        $output += @"
        </article>
"@
return $output
}