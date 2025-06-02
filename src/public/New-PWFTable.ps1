Function New-PWFTable {
    <#
.SYNOPSIS
Create a table from object.
.DESCRIPTION
Create a table from a powershell object.
.PARAMETER ToTable
The object you want to conver to an HTML table
.PARAMETER EnableSearch
Enable a search bar that helps you to find any word on the table.
.PARAMETER Exportbuttons
Add a XLSX button to export table to XLSX file.
.PARAMETER Pagination
Limit the size of your table and add pagination system.
.PARAMETER ShowTooltip
Add a toolbar with some options like fullscreen your tab, enable/disable pagination...
.PARAMETER DetailsOnClick
Use it to large objects, it will limit the width size of your table and add all other properties in a details pane. Just click on the row to display details.
.PARAMETER EnableConditionnalFormat
Enable addition of condition with next parameters ConditionProperties,COnditionOperators,ConditionValues,ConditionBackgroundColors. Each of them nedd to have same number of properties,operators,values.
.PARAMETER ConditionProperties
Add the different properties where you want to add a condition, in a string format and joined by comma: "Property1,Property2"
.PARAMETER ConditionOperators
Add the different operators of the conditions, in powershell format: "-lt,-gt"
.PARAMETER ConditionValues
Add the different values to control condition: "1,8"
.PARAMETER ConditionBackgroundColors
Add a background color if the condition match
.PARAMETER ColorForHeader
Color the table's header
.PARAMETER ColorForRows
Color the table's rows
.PARAMETER ColorForEverySecondRow
Color the table's rows each second line with another color (better visibility)
.EXAMPLE
New-PWFTable -ToTable (Get-Process | Group-Object -Property Name -NoElement | Sort-Object Count -Descending | select Name, Count) -SelectProperties "Name,Count" -EnableConditionnalFormat -ConditionProperties "Count,Name" -ConditionOperators "-gt,-match" -ConditionValues "2,svchost" -ConditionBackgroundColors "#ff0000,#FFFF00"
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $toTable,
        [Parameter(Position = 1)]
        $title,
        [Parameter(Mandatory = $false,
            ParameterSetName = 'Conditionnal',
            HelpMessage = "Enable conditionnal format on certain values.",
            Position = 2)]
        [switch]$EnableConditionnalFormat,
        [Parameter(ParameterSetName = 'Conditionnal', Position = 3)]
        $ConditionProperties,
        $ConditionOperators,
        $ConditionValues,
        $ConditionBackgroundColors
    )

    $RandomIDTable = -join ((65..90) + (97..122) | Get-Random -Count 10 | % {[char]$_})
    $AllColumnsHeader = ($ToTable | Get-Member -MemberType Properties).Name

    [string]$script:allTableData += "window.$($randomIDTable)Data = JSON.parse(``$($ToTable | ConvertTo-Json)``);`r`n"
    
    $output += @"
    <div class="table-container">
        <div class="table-header">
            <h3 class="card-title">$title</h3>
            <div class="table-controls">
                <input type="text" class="search-input table-control" id="$RandomIDTable-search" placeholder="🔍 Search in table..." oninput="filterTable('$RandomIDTable-table', this.value)"/>
                <button class="table-control" onclick="exportToCSV('$RandomIDTable')">📄 CSV</button>
                <button class="table-control" onclick="exportToJSON('$RandomIDTable')">📄 JSON</button>
                <button class="table-control" onclick="exportToExcel('$RandomIDTable')">📊 Excel</button>
            </div>
        </div>
        <div class="table-wrapper">
            <table class='data-table filterable' id='$($RandomIDTable)-table'>
                <thead>
                    <tr>
                        $($AllColumnsHeader | ForEach-Object { Write-Output "<th class='sortable' data-sort='$(Remove-StringSpecialCharactere $_)'>" $_ "</th>`n" })
                    </tr>
                </thead>
                <tbody id="$($RandomIDTable)-tbody">
                    <tr>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
"@
    #$script:allTableData
    return $output
}