$PWFPath = Read-Host "Indiquer le chemin complet vers le fichier PWF-Functions.ps1"
Import-Module $PWFPath
Start-Process "http://localhost:8000"
New-PWFAppBuild -ListeningPort 8000 -PageBlocks{
    switch($Pages){
        "/Sample2" {
            New-PWFPage -Title "Exemple 2" -Container -Content{
                New-PWFRow -Content {
                    New-PWFHeader -HeaderText "Exemple 2: Formulaire de cr&eacute;ation de compte AD pour un nouvel employ&eacute;" -Size 1
                    New-PWFColumn -Size 6 -Content {
@'
<pre style=white-space:pre-wrap;background-color:#4dd0e1;>
New-PWFColumn -Size 6 -Content {
    New-PWFRow -Content {
        New-PWFHeader -HeaderText "Visualisation Formulaire:" -Size 2
        New-PWFColumn -Size 12 -Content {
            New-PWFHeader -HeaderText "Nouvel employ&eacute;" -Size 4
            New-PWFForm -Size 12 -ActionPage "Sample2" -Content {
                New-PWFFormInput -Text -Label "Nom" -IDName "EmployeeName" -Size 6 -Required -IconPrefix "person"
                New-PWFFormInput -Text -Label "Pr&eacute;nom" -IDName "EmployeeFirstName" -Size 6 -Required
                New-PWFFormInput -Password -Label "Mot de passe" -IDName "EmployeePassword" -Size 12 -Required -IconPrefix "security"
                New-PWFFormInput -Email -Label "Adresse Mail" -IDName "EmployeeMail" -Size 12 -IconPrefix "contact_mail"
                New-PWFFormInput -Text -Label "T&eacute;l&eacute;phone" -IDName "EmployeePhone" -Size 6 -IconPrefix "phone"
                New-PWFFormInput -Text -Label "Site" -IDName "EmployeeSite" -Size 6 -IconPrefix "person_pin_circle"
                New-PWFFormInput -Text -Label "Fonction" -IDName "EmployeeFunction" -Size 12
                New-PWFFormSubmitButton -Label "Cr&eacute;er le compte" -Size Large
            }
        }
    }
    if($EmployeeName){
        New-PWFRow -Content {
            New-PWFHeader -HeaderText "Visualisation R&eacute;sultat:" -Size 2
            New-PWFPage -Title "Utilisateur cr&eacute;&eacute;" -Container -Content {
                New-PWFRow -Content {
                    New-PWFCard -CardType Image -CardTitle ($EmployeeName + " " + $EmployeeFirstName) -CardImgLink "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png?resize=256%2C256&quality=100&ssl=1" -CardContent "Nouvel(le) employ&eacute;(e)."
                }
            }
        }
    }
}
</pre>
'@
                    }
                    New-PWFColumn -Size 6 -Content {
                        New-PWFRow -Content {
                            New-PWFHeader -HeaderText "Visualisation Formulaire:" -Size 2
                            New-PWFColumn -Size 12 -Content {
                                New-PWFHeader -HeaderText "Nouvel employ&eacute;" -Size 4
                                New-PWFForm -Size 12 -ActionPage "Sample2" -Content {
                                    New-PWFFormInput -Text -Label "Nom" -IDName "EmployeeName" -Size 6 -Required -IconPrefix "person"
                                    New-PWFFormInput -Text -Label "Pr&eacute;nom" -IDName "EmployeeFirstName" -Size 6 -Required
                                    New-PWFFormInput -Password -Label "Mot de passe" -IDName "EmployeePassword" -Size 12 -Required -IconPrefix "security"
                                    New-PWFFormInput -Email -Label "Adresse Mail" -IDName "EmployeeMail" -Size 12 -IconPrefix "contact_mail"
                                    New-PWFFormInput -Text -Label "T&eacute;l&eacute;phone" -IDName "EmployeePhone" -Size 6 -IconPrefix "phone"
                                    New-PWFFormInput -Text -Label "Site" -IDName "EmployeeSite" -Size 6 -IconPrefix "person_pin_circle"
                                    New-PWFFormInput -Text -Label "Fonction" -IDName "EmployeeFunction" -Size 12
                                    New-PWFFormSubmitButton -Label "Cr&eacute;er le compte" -Size Large
                                }
                            }
                        }
                        if($EmployeeName){
                            New-PWFRow -Content {
                                New-PWFHeader -HeaderText "Visualisation R&eacute;sultat:" -Size 2
                                New-PWFPage -Title "Utilisateur cr&eacute;&eacute;" -Container -Content {
                                    New-PWFRow -Content {
                                        New-PWFCard -CardType Image -CardTitle ($EmployeeName + " " + $EmployeeFirstName) -CardImgLink "https://i0.wp.com/www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png?resize=256%2C256&quality=100&ssl=1" -CardContent "Nouvel(le) employ&eacute;(e)."
                                    }
                                }
                            }
                        }
                        New-PWFRow -Content {
                            New-PWFForm -ActionPage "Sample2" -Size 6 -Content {
                                New-PWFFormSubmitButton -Label "Exemple suivant" -Size large -Flat -IconName "play_circle_outline"
                            }
                        }
                    }
                }
            }
        }
        "/Sample1" {
            New-PWFPage -Title "Exemple 1" -Container -Content{
                New-PWFRow -Content {
                    New-PWFHeader -HeaderText "Exemple 1: Formulaire de recherche de processus" -Size 1
                    New-PWFColumn -Size 6 -Content {
@'
<pre style=white-space:pre-wrap;background-color:#4dd0e1;>
New-PWFAppBuild -ListeningPort 8000 -PageBlocks{
    switch($Pages){
        "/FindedProcess" {
            Write-Host $ProcessName -BackgroundColor Red
            $RealProcess = Get-Process -Name "*$ProcessName*"
            New-PWFPage -Title "All Finded Process" -Container -Content {
                New-PWFRow -Content {
                    New-PWFColumn -Size 6 -Content {
                        New-PWFTable -ToTable $RealProcess -SelectProperties Handles,Id,ProcessName -Striped -Responsive
                    }
                }
            }
        }
        default{
            New-PWFPage -Title "Process Search" -Container -Content {
                New-PWFHeader -HeaderText "Search Specific Process" -Size 1
                New-PWFRow -Content {
                    New-PWFColumn -Size 6 -Content {
                        New-PWFHeader -HeaderText "Process" -Size 1
                        New-PWFForm -Size 12 -ActionPage "FindedProcess" -Content {
                            New-PWFFormInput -Text -Label "Process Name" -IDName "ProcessName" -Size 6 -Required
                            New-PWFFormSubmitButton -Label "Search Process" -Size Large -IconName "search"
                        }
                    }
                }
            }
        }
    }
}
</pre>
'@
                    }
                    New-PWFColumn -Size 6 -Content {
                        New-PWFRow -Content {
                            New-PWFHeader -HeaderText "Visualisation Formulaire:" -Size 2
                            New-PWFColumn -Size 6 -Content {
                                New-PWFHeader -HeaderText "Process" -Size 4
                                New-PWFForm -Size 12 -ActionPage "Sample1" -Content {
                                    New-PWFFormInput -Text -Label "Process Name" -IDName "ProcessName" -Size 6 -Required
                                    New-PWFFormSubmitButton -Label "Search Process" -Size Large -IconName "search"
                                }
                            }
                        }
                        if($ProcessName){
                            New-PWFRow -Content {
                                New-PWFHeader -HeaderText "Visualisation R&eacute;sultat:" -Size 2
                                Write-Host $ProcessName -BackgroundColor Red
                                $RealProcess = Get-Process -Name "*$ProcessName*"
                                New-PWFPage -Title "All Finded Process" -Container -Content {
                                    New-PWFRow -Content {
                                        New-PWFColumn -Size 6 -Content {
                                            New-PWFTable -ToTable $RealProcess -SelectProperties Handles,Id,ProcessName -Striped -Responsive
                                        }
                                    }
                                }
                            }
                        }
                        New-PWFRow -Content {
                            New-PWFForm -ActionPage "Sample2" -Size 6 -Content {
                                New-PWFFormSubmitButton -Label "Exemple suivant" -Size large -Flat -IconName "play_circle_outline"
                            }
                        }
                    }
                }
            }
        }
        "/Learning-Basics" {
            New-PWFPage -Title "Etape 2" -Container -Content{
                New-PWFRow -Content {
                    New-PWFHeader -HeaderText "Comprendre le fonctionnement" -Size 1
                    New-PWFColumn -Size 4 -Content {
                        New-PWFColumn -Size 12 -Align center -Content {
                            New-PWFIcon -IconName code -Size large
                            New-PWFHeader -HeaderText "LE CODE" -Size 3
                        }
                        ####### LE CODE #######
                        New-PWFCard -CardType basic -CardTitle "Le switch principal" -BackgroundColor "teal lighten-3" -CardContent "Le switch principal, dans le quel vous composerez tout votre code, permet de g&eacute;rer les multiples
                        pages de votre interface. <strong>La page par d&eacute;faut (Default) est obligatoire</strong> et est le point d'ancrage de toutes les autres."
                        New-PWFCard -CardType basic -CardTitle "Les verbes de PWF" -BackgroundColor "teal lighten-2" -CardContent "Toutes les fonctions de PWF utilisent le pr&eacute;fixe <strong>New-</strong>+PWF..."
                        New-PWFCard -CardType basic -CardTitle "Concat&eacute;nation des fonctions PWF" -CardContent "Certaines fonctions peuvent contenir d'autres fonctions PWF sous-jacentes afin de cr&eacute;er des
                        formulaires ou pages complexes et organis&eacute;s. Chaque fonction comportant le param&egrave;tre <strong>-Content</strong> permet d'ajouter un block de script et d'y int&eacute;grer d'autres fonctions. <br />
                        <br />
                        Exemple: <br />
                        New-PWFRow -Content { <br />
                            New-PWFColumn -Size 6 -Content { <br />
                                ... <br />
                            } <br />
                        }" -BackgroundColor "teal"
                    }
                    New-PWFColumn -Size 4 -Align Center -Content {
                        New-PWFColumn -Size 12 -Align center -Content {
                            New-PWFIcon -IconName developer_board -Size large
                            New-PWFHeader -HeaderText "LE LAYOUT" -Size 3
                        }
                        ####### LE LAYOUT #######
                        New-PWFCard -CardType basic -CardTitle "Une page oui, mais dans l'ordre!" -CardContent "Les fonctions sont &agrave; utiliser dans un certain ordre pour initier une nouvelle page. Ceci est un Best Practice, il est 
                        conseill&eacute; de cr&eacute;er une div Row puis un div Column afin d'avoir un layout bien organis&eacute;. Cela dit, les autres fonctions peuvent fonctionner ind&eacute;pendamment, layout bien format&eacute; ou non. A vos risques et p&eacute;riles,
                        il est possible que vous vous retrouviez avec des affichages &eacute;tranges si vous n'organisez pas correctement vos pages. Je vous conseille de lire la tr&egrave;s bonne documentation de MaterializeCSS sur la Grid (grille
                        en Francais) qui repr&eacute;sente l'organisation des blocs HTML de facon responsive.<br />
                        <br />
                        1- New-PWFPage<br />
                        2- New-PWFRow<br />
                        3- New-PWFColumn<br />
                        " -BackgroundColor "cyan lighten-2"
                        New-PWFCard -CardType basic -CardTitle "Les lignes (Row)" -CardContent "Les lignes permettent de cr&eacute;er un container. Ce container peut contenir des colonnes ou tout autre &eacute;l&eacute;ment HTML.
                        Une Row peut &eacute;galement contenir une autre Row, afin d'organiser plus pr&eacute;cis&eacute;ment une interface.
                        " -BackgroundColor "cyan lighten-1"
                        New-PWFCard -CardType basic -CardTitle "Les colonnes (Column)" -CardContent "Les colonnes sont g&eacute;r&eacute;es par une taille de 1 &agrave; 12. 12 repr&eacute;sente la totalit&eacute; de la largeur de la page.
                        Consid&eacute;rez donc que la page est d&eacute;coup&eacute;e en 12 colonnes.
                        Si vous ne mettez qu'une colonne, elle d&eacute;butera &agrave; gauche de la page pour terminer vers la droite suivant la taille donn&eacute;e.
                        Une colonne peut &ecirc;tre utilis&eacute;e dans une pr&eacute;c&eacute;dente colonne. La taille maximale sera &eacute;galement 12, mais cette fois le maximal sera la largeur de la colonne parente.
                        " -BackgroundColor "cyan"
                    }
                    New-PWFColumn -Size 4 -Align Center -Content {
                        New-PWFColumn -Size 12 -Align center -Content {
                            New-PWFIcon -IconName dashboard -Size large
                            New-PWFHeader -HeaderText "LES FORMULAIRES ET FONCTIONS" -Size 3
                        }
                        ####### LES FORMULAIRES ET FONCTIONS #######
                        New-PWFCard -CardType basic -CardTitle "Les formulaires" -CardContent "Les formulaires sont certainement la raison pour laquelle vous avez t&eacute;l&eacute;charg&eacute; PWF. Moi-m&ecirc;me je l'ai cr&eacute;&eacute;
                        afin de pouvoir cr&eacute;er des interfaces HTML avec formulaire et pouvoir r&eacute;cup&eacute;rer le contenu saisi et l'exploiter.<br />
                        Pour cr&eacute;er un formulaire, il suffit d'utiliser la fonction <strong>New-PWFForm</strong> et de lui communiquer au moins l'argument <strong>ActionPage</strong>. Cet argument indique le nom de la page de r&eacute;sultat.
                        Il indique donc &eacute;galement quelle nouvelle page vous devrez cr&eacute;er dans votre Switch principal, afin d'afficher un r&eacute;sultat ou une autre page simplement.<br />
                        L'argument &eacute;galement indispensable est le <strong>Content</strong> qui vous permet de cr&eacute;er le contenu du formulaire via d'autres fonctions PWFFormInput.<br /><br />
                        Le contenu d'un formulaire est form&eacute; par les fonctions <strong>New-PWFFormInput</strong> et les divers arguments possibles. Vous pouvez ainsi cr&eacute;er un champ texte, une case &agrave; cocher, etc.
                        Chaque champ d&eacute;tient un <strong>IDName</strong>, un nom, que vous d&eacute;terminez. Il vous servira &agrave; r&eacute;cup&eacute;rer la valeur de ce champ une fois le formulaire valid&eacute;.<br />
                        <strong>Je vous conseille de NE PAS UTILISER D'ACCENT dans le nom de vos IDName.</strong>
                        <br />
                        <strong>Vous devez absolument terminer votre formulaire par New-PWFFormSubmitButton, sans quoi vous ne pourrez pas valider votre formulaire et donc pas l'utiliser.</strong>
                        " -BackgroundColor "green lighten-3"
                        New-PWFCard -CardType basic -CardTitle "R&eacute;cup&eacute;rer les valeurs d'un formulaire" -CardContent "Ca y est, votre formulaire est cr&eacute;&eacute; et il vous renvoie sur une nouvelle page. Vous devriez voir les valeurs dans l'URL.
                        <br />
                        Vous vous souvenez du IDName que vous avez du mettre sur vos Inputs ? H&eacute; bien 1 IDName = une variable.<br />
                        Si vous aviez appel&eacute; votre champ de pr&eacute;nom 'firstname', vous pouvez r&eacute;cup&eacute;rer la valeur saisie via la variable $firstname.
                        " -BackgroundColor "green lighten-2"
                        New-PWFCard -CardType basic -CardTitle "Utiliser les variables et afficher un r&eacute;sultat" -CardContent "Vous savez d&eacute;sormais presque tout. Reste &agrave; afficher vos r&eacute;sultat. Rien de plus simple ! M&ecirc;me technique que pour cr&eacute;er
                        les autres pages, vous n'avez qu'&agrave; utiliser les variables g&eacute;n&eacute;r&eacute;es par les IDName et les mettre en forme avec PWF.
                        Vous pouvez &eacute;videmment g&eacute;n&eacute;rer un traitement suite &agrave; vos r&eacute;sultats et par la suite mettre en forme ses r&eacute;sultat. Rien ne vous emp&ecirc;che d'utiliser le pr&eacute;nom saisi pour aller v&eacute;rifier qu'il existe dans l'AD, tout &ccedil;a dans le m&ecirc;me script.
                        " -BackgroundColor "green"
                    }
                    New-PWFRow -Content {
                        New-PWFCard -CardType basic -CardTitle "Et des exemples ??" -CardContent "Pas de panique, des exemples arrivent." -BackgroundColor "red darken-4"
                    }
                    New-PWFForm -ActionPage "Sample1" -Size 6 -Content {
                        New-PWFFormSubmitButton -Label "La suite" -Size large -Flat -IconName "play_circle_outline"
                    }
                }
            }
        }
        "/Import-Module" {
            New-PWFPage -Title "Etape 1" -Container -Content{
                New-PWFRow -Content {
                    New-PWFHeader -HeaderText "Importons le module PWF" -Size 1
                    New-PWFForm -ActionPage "Learning-Basics" -Size 6 -Content {
                        New-PWFRow -Content {
                            New-PWFHeader -HeaderText "Pour la premi&egrave;re &eacute;tape, il faut importer le module PWF-Functions.ps1" -Size 3
                            New-PWFFlowText -YourText "
                            Apr&egrave;s l'avoir t&eacute;l&eacute;charg&eacute; depuis le GitHub, importer le module .ps1: <br />
                            "
                            New-PWFBlockQuote -YourText "Import-Module .\PWF-Functions.ps1 -Global"
                            New-PWFFlowText -YourText "
                            Le -Global est optionnel mais permet d'ajouter le module pour toutes vos consoles. <br />
                            <br />
                            Pour v&eacute;rifier que l'importation a bien &eacute;t&eacute; faite, tapez dans une console Powershell <strong>New-PWF</strong> et faites une tabulation.
                            Vous devriez vous voir proposer la premi&egrave;re fonction PWF: <strong>New-PWFAppBuild</strong> <br />
                            <br />
                            Passons maintenant &agrave; la suite."
                        }
                        New-PWFFormSubmitButton -Label "La suite" -Size large -Flat -IconName "play_circle_outline"
                    }
                }
            }
        }
        default{
            New-PWFPage -Title "PWF Accueil" -Container -Content{
                New-PWFRow -Content {
                    New-PWFHeader -HeaderText "Bienvenue !" -Size 1
                    New-PWFForm -ActionPage "Import-Module" -Size 6 -Content {
                        New-PWFRow -Content {
                            New-PWFHeader -HeaderText "Pr&ecirc;t &agrave; commencer ?" -Size 3
                            New-PWFFlowText -YourText "Ce tutoriel a pour but de vous apprendre &agrave; maitriser l'outil Powershell Web Framework, lui-m&ecirc;me utilis&eacute; pour cr&eacute;er ce tutoriel."
                        }
                        New-PWFFormSubmitButton -Label "D&eacute;marrer!" -Size large -Flat -IconName "play_circle_outline"
                    }
                }
            }
        }
    }
}