// === THEME MANAGEMENT ===
class ThemeManager {
    constructor() {
        this.theme = localStorage.getItem('theme') || 'light';
        this.init();
    }

    init() {
        this.applyTheme();
        applyChartTheme();
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
        applyChartTheme();
    }
}

document.addEventListener("DOMContentLoaded", () => {
    const details = document.querySelectorAll('details');
    if (details.length > 0) {
        details[0].setAttribute('open', '');
    }
});

// Apply theme to graphs
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
            throw new Error(`DataTable: empty or invalid data for table: ${tableId}`);
        }

        this.tableId = tableId;
        this.data = [...data];
        this.originalData = [...data];
        this.columns = columns || Object.keys(data[0]); // Auto-detect
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
                    ${this.columns.map(col => {
                const value = item[col] ?? '';
                const formatted = this.formatCell(col, value);
                return `<td>${formatted}</td>`;
            }).join('')}
                </tr>
            `;
        }).join('');
    }

    formatCell(col, value) {
        if (col === 'status') {
            return `<span class="status-badge status-${value}">${value}</span>`;
        }
        if (col === 'severity') {
            const cls = value === 'Critique' ? 'status-offline' :
                value === 'Élevée' ? 'status-maintenance' : 'status-online';
            return `<span class="status-badge ${cls}">${value}</span>`;
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
// Foxu on global search
document.addEventListener('keydown', function (e) {
    // Vérifie si Ctrl+K est pressé (ou Cmd+K sur Mac)
    if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'k') {
        e.preventDefault(); // empêche le comportement par défaut du navigateur
        const searchInput = document.getElementById('global-search');
        if (searchInput) {
            searchInput.focus();
            searchInput.select(); // optionnel : sélectionne le texte déjà présent
        }
    }
});

// Global search
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

// Per table
function filterTable(tableId, query) {
    const table = document.getElementById(tableId);
    const tbody = table.querySelector("tbody");
    const rows = tbody.querySelectorAll("tr");
    const q = query.toLowerCase();

    rows.forEach(row => {
        const match = Array.from(row.cells).some(cell =>
            cell.textContent.toLowerCase().includes(q)
        );
        row.style.display = match ? "" : "none";
    });
}

// === EXPORT FUNCTIONS ===
/* JSON */
function exportToJSON(tableId) {
    const table = document.getElementById(`${tableId}-table`);
    const rows = Array.from(table.querySelectorAll("tbody tr"));
    const headers = Array.from(table.querySelectorAll("thead th")).map(th =>
        th.getAttribute("data-sort")
    );

    const data = rows.map(row => {
        const cells = Array.from(row.cells);
        const item = {};
        headers.forEach((key, index) => {
            const span = cells[index].querySelector("span");
            item[key] = span ? span.textContent.trim() : cells[index].textContent.trim();
        });
        return item;
    });

    const blob = new Blob([JSON.stringify(data, null, 2)], { type: "application/json" });
    const url = URL.createObjectURL(blob);
    downloadFile(url, `${tableId}.json`);
}

/* CSV */
function exportToCSV(tableId) {
    const table = document.getElementById(`${tableId}-table`);
    const rows = Array.from(table.querySelectorAll("tr"));
    const csv = rows.map(row =>
        Array.from(row.cells).map(cell =>
            `"${cell.innerText.replace(/"/g, '""')}"`
        ).join(",")
    ).join("\n");

    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    downloadFile(url, `${tableId}.csv`);
}

/* Excel (XLSX) */
function exportToExcel(tableId) {
    const table = document.getElementById(`${tableId}-table`);
    const rows = Array.from(table.querySelectorAll("tr"));
    const tsv = rows.map(row =>
        Array.from(row.cells).map(cell =>
            cell.innerText.replace(/\t/g, ' ')
        ).join("\t")
    ).join("\n");

    const blob = new Blob([tsv], { type: "application/vnd.ms-excel" });
    const url = URL.createObjectURL(blob);
    downloadFile(url, `${tableId}.xls`);
}

function downloadFile(url, filename) {
    const a = document.createElement("a");
    a.href = url;
    a.download = filename;
    a.style.display = "none"; // Important si document.body est sensible
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
}

// === INITIALIZATION ===
let themeManager, tables = {};

document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('current-date').textContent = new Date().toLocaleDateString('en-EN');

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
            console.warn(`⚠️ Emtpy data : ${dataVarName} isn't defined.`);
        }
    });
});