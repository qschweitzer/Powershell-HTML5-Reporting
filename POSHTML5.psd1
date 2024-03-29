#
# Manifeste de module pour le module « POSHTML5 »
#
# Généré par : Quentin Schweitzer
#
# Généré le : 13/09/2022
#

@{

    # Module de script ou fichier de module binaire associé à ce manifeste
    RootModule        = 'POSHTML5.psm1'

    # Numéro de version de ce module.
    ModuleVersion     = '0.0.9'

    RELEASENOTES = "Rollback last changes, bad idea."
    # Éditions PS prises en charge
    # CompatiblePSEditions = @()

    # ID utilisé pour identifier de manière unique ce module
    GUID              = 'e219a2a8-ae09-4101-9f3d-f99684b4bd56'

    # Auteur de ce module
    Author            = 'Quentin Schweitzer'

    # Description de la fonctionnalité fournie par ce module
    Description       = 'These functions lets you create an HTML5  web page with dynamic table and charts, easily.'

    # Version minimale du moteur Windows PowerShell requise par ce module
    PowerShellVersion = '3.0'

    # Fonctions à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune fonction à exporter.
    FunctionsToExport = @('New-PWFAccordion', 'New-PWFAccordionItem', 'New-PWFListGroup', 'New-PWFListGroupItem', 'New-PWFAlert', 'New-PWFBadge', 'New-PWFBlockQuote', 'New-PWFCard', 'New-PWFCardFooter', 'New-PWFCardHeader', 'New-PWFChart', 'New-PWFChartStackedDataset', 'New-PWFColumn', 'New-PWFHorizontalScroller', 'New-PWFIcon', 'New-PWFImage', 'New-PWFList', 'New-PWFPage', 'New-PWFProgressBar', 'New-PWFRow', 'New-PWFTab', 'New-PWFTabContainer', 'New-PWFTable', 'New-PWFText', 'New-PWFTextFormat', 'New-PWFTitle')

    # Applets de commande à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucune applet de commande à exporter.
    CmdletsToExport   = '*'

    # Variables à exporter à partir de ce module
    VariablesToExport = '*'

    # Alias à exporter à partir de ce module. Pour de meilleures performances, n’utilisez pas de caractères génériques et ne supprimez pas l’entrée. Utilisez un tableau vide si vous n’avez aucun alias à exporter.
    AliasesToExport   = '*'

    # Données privées à transmettre au module spécifié dans RootModule/ModuleToProcess. Cela peut également inclure une table de hachage PSData avec des métadonnées de modules supplémentaires utilisées par PowerShell.
    PrivateData       = @{

        PSData = @{

            # Des balises ont été appliquées à ce module. Elles facilitent la découverte des modules dans les galeries en ligne.
            Tags       = @('powershell', 'web', 'http', 'websites', 'powershell-core', 'windows', 'unix', 'linux', 'PSEdition_Core', 'cross-platform', 'access-control',
                'multithreaded', 'mkdocs')


            # URL vers la licence de ce module.
            LicenseUri = 'https://github.com/qschweitzer/Powershell-HTML5-Reporting/blob/master/LICENSE'

            # URL vers le site web principal de ce projet.
            ProjectUri = 'https://github.com/qschweitzer/Powershell-HTML5-Reporting'

        } # Fin de la table de hachage PSData

    } # Fin de la table de hachage PrivateData
}

