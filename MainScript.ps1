Get-ChildItem ".\Functions" | Select-Object * | foreach{
    Import-Module $_.FullName -Force
}

New-PWFAppBuild -ListeningPort 3030 -PageBlocks{
    switch($Pages){
        "/ResultForm" {
            Write-Host $firstName -BackgroundColor Red
            New-PWFPage -Title "ResultPage" -Container -Content {
                New-PWFRow -Content {
                    New-PWFColumn -Size 6 -Content {
                        New-PWFHeader -HeaderText "Hi $firstname !" -Size 1
                        New-PWFFlowText -YourText "This is What I know about you"
                        New-PWFCard -CardType Basic -Size 12 -CardTitle ($firstname + " " + $name) -CardContent ("Your Email: "+$email+" Your Password: nonono, I can't display that ;)")
                    }
                }
            }            
        }
        default {
            New-PWFPage -Title "Hello" -Container -Content {
                New-PWFRow -Content {
                    New-PWFColumn -Size 6 -Content {
                        New-PWFHeader -HeaderText "Form Test" -Size 1
                        New-PWFForm -Size 12 -ActionPage "ResultForm" -Content {
                            New-PWFFormInput -Text -Label "First Name" -IDName "FirstName" -Size 6 -Required
                            New-PWFFormInput -Text -Label "Name" -IDName "Name" -Size 6
                            New-PWFFormInput -Email -Label "Email" -IDName "Email" -Size 12
                            New-PWFFormInput -Password -Label "Password" -IDName "Password" -Size 6
                            New-PWFFormSubmitButton -Label "Validate" -Size Large -IconName "cloud"
                        }
                    }
                    New-PWFColumn -Size 6 -Content {
                        New-PWFHeader -HeaderText "Panel Test" -Size 2
                        New-PWFCard -CardType Panel -Size 12 -CardTitle "Test Card" -CardContent "One common flaw we've seen in many frameworks is a lack of support for truly responsive text. While elements on the page resize fluidly, text still resizes on a fixed basis." -CardLink1 "#" -CardLinkLabel1 "First Link" -BackgroundColor "blue darken-1" -TextColor "white"
                    }
                }
                New-PWFRow -Content {
                    New-PWFBlockQuote -YourText "This is a blockquote. Yeah."
                }
                New-PWFRow -Content {
                    New-PWFColumn -Size 6 -Content {
                        New-PWFCollection -CollectionArray (Get-Process | Select-Object -first 10) -CollectionColName ProcessName -LinksColName ProcessName -HeaderLabel "Running Services"
                    }
                    New-PWFColumn -Size 4 -Content {
                        New-PWFFlowText -YourText "One common flaw we've seen in many frameworks is a lack of support for truly responsive text. While elements on the page resize fluidly, text still resizes on a fixed basis."
                        New-PWFButton -Float -Size large -IconName add_alarm
                        New-PWFButton -Label "Click Me" -Size large -Disabled
                    }
                    New-PWFColumn -Size 2 -Content {
                        New-PWFIcon -IconName "ac_unit" -Size large
                    }
                }
                New-PWFRow -Content {
                    New-PWFTable -ToTable (Get-WinUserLanguageList) -Striped -Responsive
                }
            }
        }
    }
}