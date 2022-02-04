Function New-PWFIcon{
<#
.SYNOPSIS
Create a new icon.
.DESCRIPTION
Create a new icon based on Google Material icons database.
.PARAMETER IconName
The name of the icon. Choose it here: https://fonts.google.com/icons?selected=Material+Icons
.PARAMETER Size
The size of the icon. (18,24,36,48 are defaults about Material guidelines)
.EXAMPLE
New-PWFIcon -IconName Settings -SizeInPixel 24
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
param(
    [Parameter(Mandatory=$true,Position=0)]
    [string]$IconName,

    [Parameter(Mandatory=$false,Position=1)]
    [string]$SizeinPixel
)

$output = @"
    <i class="$(if($SizeinPixel){write-output "style=font-size: $($SizeinPixel)px;"}) material-icons">$IconName</i>
"@

return $output

}