Function New-PWFAccordionItem {
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
New-PWFAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
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
    <div class="accordion-item">
        <h2 class="accordion-header" id="$($RandomID_AccordionHeader)">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#$($RandomID_Accordioncollapsone)" aria-expanded="false" aria-controls="$($RandomID_Accordioncollapsone)">
            $($ItemTitle)
            </button>
        </h2>
        <div id="$($RandomID_Accordioncollapsone)" class="accordion-collapse collapse" aria-labelledby="$($RandomID_AccordionHeader)" $(if(!$Script:CollapseAlwaysOpen -eq $true){"data-bs-parent='#$Script:RandomID_AccordionFlush'"})>
            <div class="accordion-body">$($ItemContent)</div>
        </div>
    </div>
"@

    return $output
}