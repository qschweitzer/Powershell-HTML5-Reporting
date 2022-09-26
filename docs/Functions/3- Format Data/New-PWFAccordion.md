# New-PWFAccordion

## Description
Create a new Accordion element to organize your content.

## SYNTAX
``` powershell
New-PWFAccordion -AccordionItems {
    <scriptblock>
} [-Alwaysopen <switch>]
```

## EXAMPLES

### EXAMPLE 1
```powershell
New-PWFAccordion -AccordionItems {
    New-PWFAccordionItem -ItemTitle "Test 1" -ItemContent "SubHeading 1"
    New-PWFAccordionItem -ItemTitle "Test 2" -ItemContent "SubHeading 2"
    New-PWFAccordionItem -ItemTitle "Test 3" -ItemContent "SubHeading 3"
}
```

## PARAMETERS
### -AccordionItems
ScriptBlock containing PWF-AccordionItems.
```yaml
Type: Scriptblock
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```
### -Alwaysopen
When you click on first and then second title, the first stay open.
```yaml
Type: Switch
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```