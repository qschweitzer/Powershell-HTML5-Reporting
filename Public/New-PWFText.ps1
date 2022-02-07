Function New-PWFText {
    <#
.SYNOPSIS
Create a text.
.DESCRIPTION
Create a simple text.
.PARAMETER YourText
Type the text you want to display in your report. Support string or single array.
.PARAMETER Center
Move your text to the center of the web page. It's a switch option.
.EXAMPLE
New-PWFText -YourText "My text" -Center
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $YourText,
        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$Center
    )

    switch ($YourText.gettype().Name) {
        "Object[]" {
            $output = @"
        <p$(if($Center){" style='text-align:center;'"})>
            $(For($i=0; $i -le $YourText.count; $i++){if($i -lt $YourText.count){"$($YourText[$i]) <br>"}else{$($YourText[$i])}})
        </p>
"@
        }
        "String" {
            $output = @"
        <p$(if($Center){" style='text-align:center;'"})>
            $($Splitted = ($YourText -split '\n'))
            $(For($i=0; $i -le $Splitted.count; $i++){if($i -lt $splitted.count){"$($Splitted[$i]) <br>"}else{$($Splitted[$i])} })
        </p>
"@
        }
    }

    return $output

}