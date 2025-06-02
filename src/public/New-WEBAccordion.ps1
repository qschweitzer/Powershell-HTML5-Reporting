Function New-WEBAccordion {
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
New-WEBAccordion -AccordionItems {
    New-WEBAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
    New-WEBAccordionItem -ItemTitle "Test 2" -ItemContent "SubHeading 2"
    New-WEBAccordionItem -ItemTitle "Test 3" -ItemContent "SubHeading 3"
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
        $(try { .$AccordionItems } catch { $_.Exception.Message })
"@
    return $output
}