Function New-RequestVars {
    param(
        [Parameter(Mandatory=$true)]
        $AllKeys,
        $QueryString
    )
    $AllKeys | % {
        Set-Variable -Name $_ -Value $QueryString[$_] -Scope global
    }

}


Function Get-RequestVars {
    New-RequestVars -AllKeys ($Context.Request.QueryString.AllKeys) -QueryString ($Context.Request.QueryString)
}