Function New-PWFAccordion {
    <#
.SYNOPSIS
Create a new Accordion element to organize your content.
.DESCRIPTION
Create a new Accordion element to organize your content. Feel free to add what items you want.
.PARAMETER AccordionItems
ScriptBlock containing PWF-AccordionItems.
.PARAMETER Alwaysopen
When you click on first and then second title, the first stay open.
.EXAMPLE
New-PWFAccordion -AccordionItems {
    New-PWFAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
    New-PWFAccordionItem -ItemTitle "Test 2" -ItemContent "SubHeading 2"
    New-PWFAccordionItem -ItemTitle "Test 3" -ItemContent "SubHeading 3"
}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $AccordionItems,
        [Parameter(Mandatory = $false, Position = 1)]
        [switch]$Alwaysopen
    )
    if($Alwaysopen){$script:CollapseAlwaysOpen = $true}
    $Script:RandomID_AccordionFlush = "AF$(Get-Random)" 
    $output = @"
    <div class="accordion accordion-flush" id="$($RandomID_AccordionFlush)">
        $(try { .$AccordionItems } catch { $_.Exception.Message })
    </div>
"@
    return $output
}