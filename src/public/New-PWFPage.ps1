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
        [switch]$OnlineCSS,
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
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta charset="$($charset)">
        $(if($OnlineCSS){
            '
            <!-- Compiled and minified CSS -->
            <!--Import Bootstrap-Table minified CSS -->
            <link rel="stylesheet" href="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.css" >
            <!--Import Bootstrap minified CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
            <!--Import Custom PicoCSS minified CSS -->
            <link href="https://cdn.jsdelivr.net/gh/qschweitzer/Powershell-HTML5-Reporting/assets/css/113_PicoCssModified.min.css" rel="stylesheet" crossorigin="anonymous">
            <!--Import Table Export minified CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/TableExport/5.2.0/css/tableexport.min.css" >
            <!--Import Bootstrap icons Font-->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
            '
        }
        else{
            "<style>
            $($AllCSS = Get-ChildItem "$((Get-Module POSHTML5).ModuleBase)\assets\css" -Filter *.css)
            $($AllCSS | ForEach-Object {write-host $_.name;"$(Get-Content $_.fullname) $(write-output `r`n)"})
            </style>
            <link href='https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.min.css' rel='stylesheet'>"
        })

    <script>
    document.addEventListener('DOMContentLoaded', function () {
        // Fonctionnalité pour les menus dépliables
        const menuSections = document.querySelectorAll('.menu-section');
        
        menuSections.forEach(section => {
            section.addEventListener('click', function () {
                // Trouve le sous-menu suivant
                let nextElement = this.nextElementSibling;
                let subMenu = [];
                
                // Collecte tous les éléments jusqu'au prochain menu-section
                while (nextElement && !nextElement.classList.contains('menu-section')) {
                    subMenu.push(nextElement);
                    nextElement = nextElement.nextElementSibling;
                }
                
                // Toggle classe expanded pour le menu-section
                this.classList.toggle('expanded');
                
                // Toggle visibilité pour tous les éléments du sous-menu
                subMenu.forEach(item => {
                    item.classList.toggle('hidden');
                });
            });
        });
        
        // Par défaut, montrer le premier menu et cacher les autres
        const firstMenuSection = document.querySelector('.menu-section');
        if (firstMenuSection) {
            firstMenuSection.classList.add('expanded');
            
            // Montre tous les éléments jusqu'au prochain menu-section
            let nextElement = firstMenuSection.nextElementSibling;
            while (nextElement && !nextElement.classList.contains('menu-section')) {
                nextElement.classList.remove('hidden');
                nextElement = nextElement.nextElementSibling;
            }
        }
        
        // Cacher les autres sous-menus par défaut
        const otherMenuSections = document.querySelectorAll('.menu-section:not(:first-child)');
        otherMenuSections.forEach(section => {
            let nextElement = section.nextElementSibling;
            while (nextElement && !nextElement.classList.contains('menu-section')) {
                nextElement.classList.add('hidden');
                nextElement = nextElement.nextElementSibling;
            }
        });

        // Navigation entre les sections
        const menuLinks = document.querySelectorAll('.menu-container a');
        const sections = document.querySelectorAll('section');
        
        // Fonction pour activer une section spécifique
        function activateSection(sectionId) {
            // Cacher toutes les sections
            sections.forEach(section => {
                section.classList.remove('active');
            });
            
            // Afficher la section demandée
            const targetSection = document.getElementById(sectionId);
            if (targetSection) {
                targetSection.classList.add('active');
            }
            
            // Mettre à jour les liens actifs
            menuLinks.forEach(link => {
                link.classList.remove('active');
                if (link.getAttribute('href') === '#' + sectionId) {
                    link.classList.add('active');
                }
            });
        }
        
        // Gérer les clics sur les liens de menu
        menuLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const sectionId = this.getAttribute('href').substring(1);
                activateSection(sectionId);
                
                // Rendre visible le sous-menu si besoin
                let parent = this.parentElement;
                while (parent && !parent.classList.contains('menu-section')) {
                    parent = parent.previousElementSibling;
                }
                
                if (parent && parent.classList.contains('menu-section') && !parent.classList.contains('expanded')) {
                    parent.click();
                }
            });
        });
        
        // Activer la première section par défaut
        if (sections.length > 0 && menuLinks.length > 0) {
            const firstSectionId = menuLinks[0].getAttribute('href').substring(1);
            activateSection(firstSectionId);
            menuLinks[0].classList.add('active');
        }

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



        // Gestionnaire d'événement pour le bouton de changement de thème
        const themeSwitch = document.querySelector('.theme-switch');
        themeSwitch.addEventListener('click', function () {
            const currentTheme = document.documentElement.getAttribute('data-theme');
            const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
            document.documentElement.setAttribute('data-theme', newTheme);
            console.log('Thème mis à jour :', newTheme);

            applyChartTheme(); // Mettre à jour les graphiques après le changement de thème
        });


    });
</script>
        $(if($OnlineJS){
            '
            <!-- Compiled and minified JavaScript -->
            <script src="https://cdn.jsdelivr.net/npm/jquery/dist/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
            <!-- Version of TableExport below. -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <!-- Minified version of TableExport below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/tableExport.min.js"></script>
            <!-- Minified version of jsPDF below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/jsPDF/jspdf.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/jsPDF-AutoTable/jspdf.plugin.autotable.js"></script>
            <!-- Minified version of es6-promise-auto below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/es6-promise/es6-promise.auto.min.js"></script>
            <!-- Minified version of HTML2canvas below. -->
            <script src="https://cdn.jsdelivr.net/npm/tableexport.jquery.plugin@1.10.21/libs/html2canvas/html2canvas.min.js"></script>
            <!-- Minified versions of Booststrap Table. -->
            <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/bootstrap-table.min.js"></script>
            <script src="https://unpkg.com/bootstrap-table@1.19.1/dist/extensions/export/bootstrap-table-export.min.js"></script>
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
    <!-- Navigation bar -->
    <nav class="navbar">
        <div class="container">
            <a href="#" class="brand">
                <svg width="64px" height="64px" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"> <path fill-rule="evenodd" clip-rule="evenodd" d="M8 16L3.54223 12.3383C1.93278 11.0162 1 9.04287 1 6.96005C1 3.11612 4.15607 0 8 0C11.8439 0 15 3.11612 15 6.96005C15 9.04287 14.0672 11.0162 12.4578 12.3383L8 16ZM3 6H5C6.10457 6 7 6.89543 7 8V9L3 7.5V6ZM11 6C9.89543 6 9 6.89543 9 8V9L13 7.5V6H11Z" fill="#ffd700"></path> </g></svg>
                Report
            </a>
        </div>
        <div class="theme-switch"><svg width="24px" height="24px" viewBox="0 0 24 24" fill="none"
                xmlns="http://www.w3.org/2000/svg" stroke="#f39c12">
                <g id="SVGRepo_bgCarrier" stroke-width="0"></g>
                <g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g>
                <g id="SVGRepo_iconCarrier">
                    <path
                        d="M17 12C17 14.7614 14.7614 17 12 17C9.23858 17 7 14.7614 7 12C7 9.23858 9.23858 7 12 7C14.7614 7 17 9.23858 17 12Z"
                        fill="#f39c12"></path>
                    <path fill-rule="evenodd" clip-rule="evenodd"
                        d="M12 1.25C12.4142 1.25 12.75 1.58579 12.75 2V4C12.75 4.41421 12.4142 4.75 12 4.75C11.5858 4.75 11.25 4.41421 11.25 4V2C11.25 1.58579 11.5858 1.25 12 1.25ZM1.25 12C1.25 11.5858 1.58579 11.25 2 11.25H4C4.41421 11.25 4.75 11.5858 4.75 12C4.75 12.4142 4.41421 12.75 4 12.75H2C1.58579 12.75 1.25 12.4142 1.25 12ZM19.25 12C19.25 11.5858 19.5858 11.25 20 11.25H22C22.4142 11.25 22.75 11.5858 22.75 12C22.75 12.4142 22.4142 12.75 22 12.75H20C19.5858 12.75 19.25 12.4142 19.25 12ZM12 19.25C12.4142 19.25 12.75 19.5858 12.75 20V22C12.75 22.4142 12.4142 22.75 12 22.75C11.5858 22.75 11.25 22.4142 11.25 22V20C11.25 19.5858 11.5858 19.25 12 19.25Z"
                        fill="#f39c12"></path>
                    <g opacity="0.5">
                        <path
                            d="M3.66919 3.7156C3.94869 3.4099 4.42309 3.38867 4.72879 3.66817L6.95081 5.69975C7.25651 5.97925 7.27774 6.45365 6.99824 6.75935C6.71874 7.06505 6.24434 7.08629 5.93865 6.80679L3.71663 4.7752C3.41093 4.4957 3.38969 4.0213 3.66919 3.7156Z"
                            fill="#f39c12"></path>
                        <path
                            d="M20.3319 3.7156C20.6114 4.0213 20.5902 4.4957 20.2845 4.7752L18.0624 6.80679C17.7567 7.08629 17.2823 7.06505 17.0028 6.75935C16.7233 6.45365 16.7446 5.97925 17.0503 5.69975L19.2723 3.66817C19.578 3.38867 20.0524 3.4099 20.3319 3.7156Z"
                            fill="#f39c12"></path>
                        <path
                            d="M17.0261 17.0247C17.319 16.7318 17.7938 16.7319 18.0867 17.0248L20.3087 19.2471C20.6016 19.54 20.6016 20.0148 20.3087 20.3077C20.0158 20.6006 19.5409 20.6006 19.248 20.3076L17.026 18.0854C16.7331 17.7924 16.7332 17.3176 17.0261 17.0247Z"
                            fill="#f39c12"></path>
                        <path
                            d="M6.97521 17.0249C7.2681 17.3177 7.2681 17.7926 6.97521 18.0855L4.75299 20.3077C4.46009 20.6006 3.98522 20.6006 3.69233 20.3077C3.39943 20.0148 3.39943 19.54 3.69233 19.2471L5.91455 17.0248C6.20744 16.732 6.68232 16.732 6.97521 17.0249Z"
                            fill="#f39c12"></path>
                    </g>
                </g>
            </svg>
        </div>
    </nav>
    <div class="container-fluid">
        <main>
            <!-- Menu sidebar -->
            <div class="menu-container">
                <ul>
                    $(if(-not $Script:TabUsed){
                        @"
                        <li class="menu-section">Global view</li>
                        <li><a href="#dashboard">Dashboard</a></li>
"@
                    }
                    else{

                        '<li class="menu-section">Global view</li>'
                        foreach ($tab in $Script:TabsNames){

                        "<li><a href='#$($tab.tolower() | Remove-StringSpecialCharactere)'>$tab</a></li>"
                        } 
                    }
                    )
                </ul>
            </div>
"@
    try {
        $output += @"
        <!-- Content area -->
            <div class="content-container">
                <!-- Vue d'ensemble section -->
"@
        if (-not $Script:TabUsed) {
            $output += @"
            <section id="dashboard">
                    <h2>Dashboard</h2>
                    $($output += $Content )
                </section>
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
        <script>
            const links = document.querySelectorAll('.tab-link');
            const contents = document.querySelectorAll('.tab-content');

            links.forEach(link => {
            link.addEventListener('click', e => {
                e.preventDefault();
                const target = link.getAttribute('data-tab');

                links.forEach(l => l.classList.remove('active'));
                link.classList.add('active');

                contents.forEach(c => {
                c.classList.toggle('active', c.id === target);
                });
            });
            });
        </script>
        <div class="container">
            <p>Report generated on $(get-date -DisplayHint date)</p>
        </div>
    </footer>
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