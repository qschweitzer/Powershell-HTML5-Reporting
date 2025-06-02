Function New-WEBAccordionItem {
    <#
.SYNOPSIS
Create a new Accordion Item.
.DESCRIPTION
Create a new ListGroup Item.
.PARAMETER ItemTitle
The primary title of the item.
.PARAMETER ItemContent
The content of your item.
.EXAMPLE
New-WEBAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $ItemTitle,
        $ItemContent
    )

    $RandomID_AccordionHeader = "AH$(Get-Random)"
    $RandomID_Accordioncollapsone = "CO$(Get-Random)"
    $output = @"
    <details name="$($RandomID_AccordionFlush)">
    <summary>$($ItemTitle)</summary>
    $(try { .$ItemContent } catch { $_.Exception.Message })
    </details>
"@

    return $output
}