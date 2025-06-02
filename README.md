# PSReport

**PSReport** is a PowerShell-based reporting tool that allows you to quickly generate interactive, shareable, and exportable **HTML reports** from scripts and system data. Designed for IT professionals, system administrators, and DevOps engineers, PSReport brings powerful data visualization to your PowerShell workflow — with no need for a web server or external dependencies.

---

## ✨ Features

- ✅ Generate **standalone HTML reports** from PowerShell scripts
- 📊 Create dynamic **charts** (powered by Chart.js)
- 📋 Build interactive **filterable/exportable tables**
- 🎨 Customizable themes with **light/dark mode**
- 💾 Fully static: **no server required**, just open the file
- 🚀 Works on any system with PowerShell (Windows/Linux/macOS)

---

## 🔍 Why Use Static HTML Reports?

- **Easy sharing**: Send the report as an email attachment or host it on a file share — no infrastructure needed.
- **Data integrity**: The report reflects the data at the time of generation — no live refresh means no surprises.
- **Security-friendly**: No live connections, no backends, no data leaks.
- **Portability**: Works in disconnected environments, ideal for audits or air-gapped systems.
- **Reproducible results**: Store historical reports as-is, compare snapshots over time.

---

## 📦 Example Use Cases

- Audit Active Directory group memberships
- Inventory installed software on remote machines
- Summarize disk usage across servers
- Display patch compliance over time
- Monitor backup status with visual graphs

> Demo screenshots and sample reports coming soon.

---

## 🚀 Getting Started

### 1. Install

Clone the repository:

```powershell
Install-Module PSReport
```

> No external dependencies are required. Everything is bundled.

## 2. Generate Your First Report

```powershell
$data = Get-Process | Select-Object Name, CPU, ID

New-PSReport -Title "Process Report" -Table $data -Output "report.html"
```

## 🛠️ Planned Features
* PDF export support
* Theming system with custom color palettes
* CLI wrapper for scheduled reporting
* Integration with monitoring tools (optional)

## 📚 Documentation
* Full documentation is available in the **docs** folder. It includes:
* Chart creation guide
* Table customization (sorting, filtering, exporting)
* Styling and branding your report
* Localization support (planned)

## 🧑‍💻 Contributing
* Pull requests are welcome! If you'd like to contribute:
* Fork the repository
* Create a feature branch
* Submit a pull request with a clear description
* Feel free to open issues to report bugs or suggest features.


## 📄 License
PSReport is licensed under the **GNU Affero General Public License v3.0 (AGPL-3.0).**

This means:
* You can use, study, modify, and redistribute the code.
* If you make PSReport available as part of a network service, you must also make your modified source code available.
* Commercial use is allowed, under the terms of AGPLv3.

See the full license in the [LICENSE file](./LICENSE).

# 🏷️ Versioning
This project follows [Semantic Versioning](https://semver.org/).
Stable releases will be tagged and published in the Releases section.


## 🙏 Acknowledgements
* [Chart.js](https://www.chartjs.org/) for the chart rendering engine
* Inspired by internal needs for automated infrastructure reporting in real-world DevOps environments

## 📬 Contact
Maintained by **Quentin SCHWEITZER** – [mrtrez@proton.me]

If you're using PSReport in your organization or want custom features, feel free to reach out.