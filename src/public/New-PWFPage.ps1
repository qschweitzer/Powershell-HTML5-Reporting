Function New-PWFPage {
    <#
.SYNOPSIS
Create a new HTML page.
.DESCRIPTION
Create a new HTML page with pre-configured settings, and an empty body tag which will contain other blocks.
.PARAMETER Title
Title of your WebPage.
.PARAMETER Content
The Content is a scriptblock that will contain next blocks parts.
.PARAMETER Path
Path to export to.
.PARAMETER Charset
Choose your Web Charset encoding.
.PARAMETER Container
If added, this parameter will configure the page to have a Container div. Refer to Materialize to understand all the concept of container. https://materializecss.com/getting-started.html
.EXAMPLE
New-PWFPage -Title "TEST" -Chartset UTF8 -Content { New-PWFRow -Content {}}
.LINK
https://github.com/qschweitzer/Powershell-HTML5-Reporting
#>
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        $Title,
        $Content,
        [switch]$OnlineJS,
        [string]$Path,

        [Parameter(Mandatory = $false, Position = 1)]
        $Charset = "UTF-8",
        [switch]$Container,
        [switch]$DarkTheme
    )
    $script:ChartColorsPalette = @(
        "#6A0DAD",
        "#00ACC1",
        "#FFC107",
        "#8E24AA",
        "#03A9F4",
        "#FF9800",
        "#5C6BC0",
        "#9C27B0",
        "#E91E63",
        "#BA68C8",
        "#21D96D",
        "#AA00FF",
        "#00BFA5",
        "#CE93D8",
        "#8A2BE2",
        "#1DE9B6",
        "#FF5722",
        "#512DA8",
        "#AEEA00",
        "#D500F9",
        "#FDD835",
        "#F06292",
        "#F44336",
        "#FFEB3B",
        "#FFCA28",
        "#00E676",
        "#E91E63"
    )
    $Content = . $Content
    $output = @"
<!DOCTYPE html>
$(if($DarkTheme){'<html data-theme="dark" lang="en">'}else{'<html data-theme="light" lang="en">'})
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta charset="$($charset)">
        <style>
        $($AllCSS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\css" -Filter *.css)
        $($AllCSS | ForEach-Object {write-host $_.name;"$(Get-Content $_.fullname) $(write-output `r`n)"})
        </style>
        <script>
            // Tableau pour stocker les instances des graphiques
            let charts = [];
            charts.push($(if($script:AllCharts){"$($script:AllCharts -join ", ")"}));

            // Fonction pour appliquer le thème aux graphiques
            function applyChartTheme() {
                const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
                const textColor = isDark ? '#ffffff' : '#000000';
                const gridColor = isDark ? '#444' : '#ccc';

                charts.forEach(id => {
                    const chart = Chart.getChart(id);
                    if (!chart) return;

                    // Mise à jour des axes
                    const x = chart.options.scales?.x;
                    const y = chart.options.scales?.y;

                    if (x?.ticks) x.ticks.color = textColor;
                    if (x?.grid) x.grid.color = gridColor;
                    if (y?.ticks) y.ticks.color = textColor;
                    if (y?.grid) y.grid.color = gridColor;

                    // Légende
                    if (chart.options.plugins?.legend?.labels) {
                        chart.options.plugins.legend.labels.color = textColor;
                    }

                    // Titre
                    if (chart.options.plugins?.title) {
                        chart.options.plugins.title.color = textColor;
                    }

                    chart.update();
                });
            }
        </script>
        $(if($OnlineJS){
            '
            <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js"></script>
            '
        }
        else{
            "<script>
            $($AllJS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\js" -Filter *.min.* | Sort-Object Name)
            $($AllJS | ForEach-Object {write-host $_.name;"$(Get-Content $_.fullname) $(write-output `r`n)"})
            </script>"
        })
        <title>$($title)</title>
    </head>
<body>
<!-- Header -->
    <header class="header">
        <div class="header-content">
            <div class="header-left">
                <div class="logo">AI</div>
                <div class="header-title">
                    <h1>$Title</h1>
                    <div class="header-subtitle">Généré le <span id="current-date"></span></div>
                </div>
            </div>
            <div class="header-right">
                <div class="search-container">
                    <input type="text" class="search-input" placeholder="Search... (Ctrl+K)" id="global-search">
                    <span class="search-icon">🔍</span>
                </div>
                <button class="theme-toggle" id="theme-toggle" title="Switch theme">🌙</button>
            </div>
        </div>
    </header>

   <!-- Navigation -->
    <nav class="nav-container">
        <div class="nav-tabs" id="nav-tabs">
            $(
            foreach ($tab in $Script:TabsNames){
                if($tab -eq $script:TabsNames[0]){
                    $firstTab = $tab
                    "<button class=""nav-tab active"" data-tab=""$($tab.tolower() | Remove-StringSpecialCharactere)"">$tab</button>"
                }
                else{
                    "<button class=""nav-tab"" data-tab=""$($tab.tolower() | Remove-StringSpecialCharactere)"">$tab</button>"
                }
            })
        </div>
    </nav>

     <!-- Main Content -->
    <main class="main-container">
"@
    try {
        if (-not $Script:tabUsed) {
            $output += @"
        <div class="tab-content active" id="dashboard">
            <h2>Dashboard</h2>
            $($output += $Content )
        </div>
"@
        }
        else {
            $output += $Content 
        }
    }
    catch { $_.Exception.Message }

    $output += @"
    </main>
    <footer>
        <div class="container">
            <p>Report generated by a Powershell script.</p>
        </div>
    </footer>
    <script>
    // === DATA ===

    // === THEME MANAGEMENT ===
        class ThemeManager {
            constructor() {
                this.theme = localStorage.getItem('theme') || 'light';
                this.init();
            }

            init() {
                this.applyTheme();
                document.getElementById('theme-toggle').addEventListener('click', () => this.toggle());
            }

            applyTheme() {
                document.documentElement.setAttribute('data-theme', this.theme);
                const toggle = document.getElementById('theme-toggle');
                toggle.textContent = this.theme === 'dark' ? '☀️' : '🌙';
                localStorage.setItem('theme', this.theme);
            }

            toggle() {
                this.theme = this.theme === 'dark' ? 'light' : 'dark';
                this.applyTheme();
            }
        }

        // === TABS MANAGEMENT ===
        const tabButtons = document.querySelectorAll('.nav-tab');
        const tabs = document.querySelectorAll('.tab-content');

        tabButtons.forEach(button => {
            button.addEventListener('click', () => {
                tabButtons.forEach(btn => btn.classList.remove('active'));
                tabs.forEach(tab => tab.classList.remove('active'));

                button.classList.add('active');
                const activeTab = document.getElementById(button.dataset.tab);
                activeTab.classList.add('active');
            });
        });

        // === TABLE MANAGEMENT ===
        class DataTable {
            constructor(tableId, data, columns = null) {
                if (!Array.isArray(data) || data.length === 0) {
                    throw new Error(`DataTable: données invalides ou vides pour la table ${tableId}`);
                }

                this.tableId = tableId;
                this.data = [...data];
                this.originalData = [...data];
                this.columns = columns || Object.keys(data[0]); // Auto-detection ici
                this.currentPage = 1;
                this.rowsPerPage = 10;

                this.renderTable();
            }

            renderTable() {
                const table = document.getElementById(this.tableId);
                const tbody = table.querySelector('tbody');
                const pageData = this.getCurrentPageData();

                tbody.innerHTML = pageData.map(item => {
                    return `
                <tr>
                    $${this.columns.map(col => {
                        const value = item[col] ?? '';
                        const formatted = this.formatCell(col, value);
                        return `<td>$${formatted}</td>`;
                    }).join('')}
                </tr>
            `;
                }).join('');
            }

            formatCell(col, value) {
                if (col === 'status') {
                    return `<span class="status-badge status-$${value}">$${value}</span>`;
                }
                if (col === 'severity') {
                    const cls = value === 'Critique' ? 'status-offline' :
                        value === 'Élevée' ? 'status-maintenance' : 'status-online';
                    return `<span class="status-badge $${cls}">$${value}</span>`;
                }
                return value;
            }

            getCurrentPageData() {
                const start = (this.currentPage - 1) * this.rowsPerPage;
                const end = start + this.rowsPerPage;
                return this.data.slice(start, end);
            }
        }

        function searchTables() {
            const input = document.getElementById('global-search');
            const filter = input.value.toLowerCase();
            const tables = document.querySelectorAll('table');

            tables.forEach(table => {
                const rows = table.querySelectorAll('tbody tr');
                rows.forEach(row => {
                    let rowText = row.textContent.toLowerCase();
                    row.style.display = rowText.includes(filter) ? '' : 'none';
                });
            });
        }

        // === SEARCH MANAGEMENT ===
        const searchInput = document.getElementById('global-search');
        searchInput.addEventListener('input', () => {
            const keyword = searchInput.value.toLowerCase();
            const tables = document.querySelectorAll('.filterable');

            tables.forEach(table => {
                const rows = table.querySelectorAll('tbody tr');
                rows.forEach(row => {
                    const text = row.textContent.toLowerCase();
                    row.style.display = text.includes(keyword) ? '' : 'none';
                });
            });
        });

        // === EXPORT FUNCTIONS ===
        function exportToCSV(tableType) {
            const table = tables[tableType];
            if (!table) return;

            const data = table.exportData();
            const headers = Object.keys(data[0]);

            let csv = headers.join(',') + '\n';
            csv += data.map(row =>
                headers.map(header => `"${row[header]}"`).join(',')
            ).join('\n');

            downloadFile(csv, `$${tableType}-export.csv`, 'text/csv;charset=utf-8;');
        }

        function exportToExcel(tableType) {
            const table = tables[tableType];
            if (!table) return;

            const data = table.exportData();
            const headers = Object.keys(data[0]);

            let html = '<table><thead><tr>';
            html += headers.map(h => `<th>$${h}</th>`).join('');
            html += '</tr></thead><tbody>';
            html += data.map(row =>
                '<tr>' + headers.map(h => `<td>$${row[h]}</td>`).join('') + '</tr>'
            ).join('');
            html += '</tbody></table>';

            downloadFile(html, `$${tableType}-export.xls`, 'application/vnd.ms-excel');
        }

        function downloadFile(content, filename, mimeType) {
            const blob = new Blob([content], { type: mimeType });
            const url = URL.createObjectURL(blob);
            const link = document.createElement('a');
            link.href = url;
            link.download = filename;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            URL.revokeObjectURL(url);
        }

        function generateReport(type) {
            alert(`Génération du rapport $${type} en cours...`);
        }

        // === INITIALIZATION ===
        let themeManager, tables = {};

        document.addEventListener('DOMContentLoaded', function () {
            document.getElementById('current-date').textContent = new Date().toLocaleDateString('fr-FR');
            document.getElementById('last-analysis').textContent = new Date().toLocaleString('fr-FR');

            themeManager = new ThemeManager();

            // Dynamic DataTables init
            document.querySelectorAll('table.data-table').forEach(tableEl => {
                const tableId = tableEl.id;
                const key = tableId.replace('-table', '');
                const dataVarName = `${key}Data`;
                const data = window[dataVarName];

                if (data) {
                    tables[key] = new DataTable(tableId, data);
                } else {
                    console.warn(`⚠️ Emtpy data : $${dataVarName} isn't defined.`);
                }
            });
        });
    </script>
<!--</main>-->
</body>
</html>
"@
    if ($path) {
        $output | out-file $path -Encoding utf8
    }
    else {
        return $output
    }
    $Script:TabsNames = $null
    $script:AllCharts = $null
}