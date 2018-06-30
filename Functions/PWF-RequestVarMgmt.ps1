Function New-RequestVars {
<#
.SYNOPSIS
Convert GET params and values into variables
.DESCRIPTION
Convert GET params and values into variables
.EXAMPLE
New-RequestVars -AllKeys ($Context.Request.QueryString.AllKeys) -QueryString ($Context.Request.QueryString)
.LINK
https://github.com/qschweitzer/PoshWebFramework
#>
    param(
        [Parameter(Mandatory=$true)]
        $AllKeys,
        $QueryString
    )

    $AllKeys | foreach-object {
        Set-Variable -Name $_ -Value $QueryString[$_] -Scope global
    }

}