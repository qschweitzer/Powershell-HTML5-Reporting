Function New-PWFTable {
    <#
.SYNOPSIS
Create a table from object.
.DESCRIPTION
Create a table from a powershell object.
.PARAMETER ToTable
The object you want to conver to an HTML table
.PARAMETER SelectProperties
Array or string (separate by comma) entries. Select certain properties to not use the totality of the object's properties.
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
        $ToTable,

        [Parameter(Mandatory = $false, Position = 1)]
        $SelectProperties,
        [switch]$EnableSearch,
        [switch]$Exportbuttons,

        [Parameter(Mandatory = $false,
            ParameterSetName = 'Conditionnal',
            HelpMessage = "Enable conditionnal format on certain values.",
            Position = 2)]
        [switch]$EnableConditionnalFormat,
        [Parameter(ParameterSetName = 'Conditionnal', Position = 3)]
        $ConditionProperties,
        $ConditionOperators,
        $ConditionValues,
        $ConditionBackgroundColors,

        [Parameter(Mandatory = $false, Position = 4)]
        [switch]$Pagination,
        [switch]$ShowTooltip,
        [switch]$DetailsOnClick,
        [switch]$SortByColumn,
        [switch]$Striped,
        [switch]$Dark,
        [switch]$Small,
        [ValidateSet("default", "primary", "secondary", "success", "danger", "warning", "info", "light", "dark", IgnoreCase = $false)]
        [string]$ContextualColor

        # Classes: class="striped highlight centered responsive-table"
    )
    # Cleaning Properties Name, removing white space
    $OldTableProperties = $ToTable.psobject.Properties.Name
    $NewTableProperties = $OldTableProperties -replace " ",""
    $orderedtable = [ordered] @{}; $i = 0
    $ToTable.psobject.Properties.ForEach({
        $orderedtable[$NewTableProperties[$i++]] = $_.Value
    })
    $ToTable = $orderedtable

    # Script begin
    $RandomIDTable = ("table$(Get-Random)")
    $RandomIDFuncDetailFormatter = "detailFormatter$(Get-Random)"
    $RandomIDFuncCustomSort = "customSort$(Get-Random)"
    $ConditionnalObjects = @()
    if ($SelectProperties -and $SelectProperties.gettype().Name -eq "String") {
        $SelectProperties = $SelectProperties.split(',')
    }
    write-host $SelectProperties
    if ($ConditionProperties -match ",") { $ConditionProperties = $ConditionProperties.split(",") }else { $ConditionProperties = [array]$ConditionProperties }
    if ($ConditionOperators -match ",") { $ConditionOperators = $ConditionOperators.split(",") }else { $ConditionOperators = [array]$ConditionOperators }
    if ($ConditionValues -match ",") { $ConditionValues = $ConditionValues.split(",") }else { $ConditionValues = [array]$ConditionValues }
    if ($ConditionBackgroundColors -match ",") { $ConditionBackgroundColors = $ConditionBackgroundColors.split(",") }else { $ConditionBackgroundColors = [array]$ConditionBackgroundColors }
    if ($EnableConditionnalFormat) {
        For ($e = 0; $e -lt ($ConditionProperties | Measure-Object).count; $e++) {
            $ConditionnalObject = New-Object psobject
            $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "PropertyName" -Value $ConditionProperties[$e]
            $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "poshOperator" -Value ([string]$ConditionOperators[$e])
            $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "poshValue" -Value ([string]$ConditionValues[$e])
            $ConditionnalObject | Add-Member -MemberType NoteProperty -Name "poshColor" -Value ([string]$ConditionBackgroundColors[$e])
            $ConditionnalObjects += $ConditionnalObject
        }
    }
    if ($SelectProperties) {
        $AllColumnsHeader = $SelectProperties
    }
    else {
        $AllColumnsHeader = ($ToTable | Get-Member -MemberType Properties).Name
    }
    
    $output += @"
    <table class='$(if($Striped){" table-striped"}if($Dark){" table-dark"}if($Small){" table-sm"}if($ContextualColor){" table-$($ContextualColor)"})' id='$($RandomIDTable)' data-toggle='table' $(if($EnableSearch){
        '
        data-search="true"
        '
    })
        $(if($Pagination){'data-pagination="true"'})
        $(if($Exportbuttons){
        '
        data-show-export="true"
        '
        })
        $(if($ShowTooltip){
        '
        data-show-columns="true"
        data-show-columns-toggle-all="true"
        data-show-pagination-switch="true"
        data-show-toggle="true"
        data-show-fullscreen="true"
        data-buttons="buttons"
        '
        })
        $(if($DetailsOnClick){
        "
        data-detail-view='true'
        data-detail-formatter='$($RandomIDFuncDetailFormatter)'
        data-detail-view-icon='false'
        data-detail-view-by-click='true'
        "
        })
        $(if($SortByColumn){
        "
        data-custom-sort='$($RandomIDFuncCustomSort)'
        "
        })
        $(if($ConditionProperties){
            $cellID = "cellStyle$(Get-random)"
        })
    >
    <thead>
        <tr>
            $($AllColumnsHeader | ForEach-Object { Write-Output "<th$(if($ColorForHeader){write-output " style='background-color:$($ColorForHeader);'"}) data-field="$($_)"$(if($SortByColumn){" data-sortable='true'"})$(if($ConditionProperties){" data-cell-style='$($cellID)'"})>" $_ "</th>" })
        </tr>
    </thead>
</table>

$(if($Exportbuttons){
    "
    <script>
    var `$table$($RandomIDTable) = `$('#$($RandomIDTable)')
    `$(function() {
        `$table$($RandomIDTable).bootstrapTable('destroy').bootstrapTable({
            exportTypes: ['json', 'xml', 'png', 'csv', 'txt', 'excel', 'pdf'],
            columns: [
            $(for ($p=0; $p -lt ($AllColumnsHeader | Measure-Object).count; $p++){
                if($p -eq ($AllColumnsHeader | Measure-Object).count){
                Write-Output "
                {
                    field: '$($AllColumnsHeader[$p])'
                }
                "
                }else{
                Write-Output "
                {
                    field: '$($AllColumnsHeader[$p])'
                },
                "
                }
            })
            ]
        })
    })
    </script>
    "
})
<script>
var `$table2$($RandomIDTable) = `$('#$($RandomIDTable)')
`$(function() {
    $(if(($ToTable | Measure-Object).count -eq 1 ){ "var datajson = [$($ToTable | ConvertTo-Json)]" }
    else{"var datajson = $($ToTable | ConvertTo-Json)"})
    `$table2$($RandomIDTable).bootstrapTable({data: datajson})
    `$('#$($RandomIDTable)').bootstrapTable('load', datajson);
})
</script>

$(if($DetailsOnClick){
    "<script>
    function $($RandomIDFuncDetailFormatter)(index, row) {
        var html = []
        $.each(row, function (key, value) {
            html.push('<p><b>' + key + ':</b> ' + value + '</p>')
        })
        return html.join('')
    }
    </script>"
})

$(if($ConditionnalObjects){
    "
    <script>
    function $($cellID)(value, row, index) {
        $($ConditionnalObjects | ForEach-Object {
            if($_.poshoperator -notmatch "match"){
                "if (!(isNaN(value)) &&value $($_.poshoperator) '$($_.poshvalue)'){
                    return {
                        css:{
                            'background-color': '$($_.poshcolor)'
                        }
                    }
                }"
            }
            else{
                "
                if (isNaN(value) && (value.toLowerCase()).match(/^.*$((($_.poshvalue).toLower())).*$/)){
                    return {
                        css:{
                            'background-color': '$($_.poshcolor)'
                        }
                    }
                }"
            }
        })
        return {
        }
      }
      </script>"
})

<script>
var `$table1$($RandomIDTable) = `$('#$($RandomIDTable)')

`$(function() {
    `$table1$($RandomIDTable).bootstrapTable({
    columns: [$(for($m=0; $m -le ($SelectProperties | Measure-Object).count-1; $m++){
        "{
        title: '$($SelectProperties[$m])',
        field: '$($SelectProperties[$m])'
        }$(if($m -ne ($SelectProperties | Measure-Object).count-1){","})"
    })]
    })
})
</script>

$(if($SortByColumn){
    $RandomIDvarOrder = "order$(Get-random)"
    $RandomIDvaraa = "aa$(Get-random)"
    $RandomIDvarbb = "bb$(Get-random)"
    "<script>
    function $($RandomIDFuncCustomSort)(sortName, sortOrder, data) {
    var $($RandomIDvarOrder) = sortOrder === 'desc' ? -1 : 1
    data.sort(function (a, b) {
        var $($RandomIDvaraa) = +((a[sortName] + '').replace(/[^\d]/g, ''))
        var $($RandomIDvarbb) = +((b[sortName] + '').replace(/[^\d]/g, ''))
        if ($($RandomIDvaraa) < $($RandomIDvarbb)) {
        return $($RandomIDvarOrder) * -1
        }
        if ($($RandomIDvaraa) > $($RandomIDvarbb)) {
        return $($RandomIDvarOrder)
        }
        return 0
    })
    }
    </script>"
})
"@
    return $output
}