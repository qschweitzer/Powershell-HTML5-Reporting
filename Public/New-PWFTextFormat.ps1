Function New-PWFTextFormat {
    <#
.SYNOPSIS
Create a new HTML text with customized format.
.DESCRIPTION
Create a new HTML Title with customized format. You can use multiple format options at the same time.
.PARAMETER YourText
Your string text.
.PARAMETER Center
Center your text.
.PARAMETER ColorHexa
Color your text with custom hexadecimal color.
.PARAMETER Abbreviation
Add Abreviation mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Highlight
Add Highlight mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Bold
Add Bold mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Strikethrough
Add Strikethrough mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Italic
Add Italic mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Deleted
Add Deleted mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER SubText
Add SubText mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER SupText
Add SupText mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Inserted
Add Inserted mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Keyboard
Add Keyboard mode to your text. Look sample at https://picocss.com/docs/#typography
.PARAMETER Underline
Add Underline mode to your text. Look sample at https://picocss.com/docs/#typography
.EXAMPLE
New-PWFTextFormat -YourText "My Text is Awesome" -ColorHexa "#D94020" -Bold -Underline
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$YourText,

        [Parameter(Mandatory = $false, Position = 1)]
        [string]$ColorHexa,
        [switch]$Abbreviation,
        [switch]$Highlight,
        [switch]$Bold,
        [switch]$Strikethrough,
        [switch]$Italic,
        [switch]$Deleted,
        [switch]$SubText,
        [switch]$SupText,
        [switch]$Inserted,
        [switch]$Keyboard,
        [switch]$Underline
    )
    function LoopFormat {
        param (
            $Text,
            $Type,
            $ColorHexa
        )
        $Result = @"
        <$($Type) style='$(if($ColorHexa){"color:$($ColorHexa);"})'>$($Text -split '\n' | ForEach-Object {"$_"})</$($Type)>
"@

        return $Result
    }

    $output = $YourText
    $type = ""

    if ($Abbreviation) {
        $type += "abbr;"
    }
    if ($Highlight) {
        $type += "mark;"
    }
    if ($Bold) {
        $type += "strong;"
    }
    if ($Strikethrough) {
        $type += "s;"
    }
    if ($Italic) {
        $type += "em;"
    }
    if ($Deleted) {
        $type += "del;"
    }
    if ($SubText) {
        $type += "sub;"
    }
    if ($SupText) {
        $type += "sup;"
    }
    if ($Inserted) {
        $type += "ins;"
    }
    if ($Keyboard) {
        $type += "kbd;"
    }
    if ($Underline) {
        $type += "u;"
    }
    if ($type -eq "") {
        $type += "span;"
    }

    $type = $type -split ";"


    $type | Where-Object { $_ -ne "" } | ForEach-Object {
        $output = LoopFormat -Text $output -Type $_ -ColorHexa $ColorHexa
    }

    return $output
}