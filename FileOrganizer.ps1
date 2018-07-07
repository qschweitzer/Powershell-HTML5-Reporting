Get-ChildItem ".\Functions" | Select-Object * | foreach{
    Import-Module $_.FullName -Force
}

New-PWFAppBuild -ListeningPort 3030 -PageBlocks{
    switch($Pages){
        default{
            New-PWFPage -Title "File Organizer" -Container -Content {
                New-PWFRow -Content{
                    New-PWFColumn -Size 6 -Content{
                        New-PWFForm -Size 12 -ActionPage result -Content{
                            New-PWFFormInput -File -Label "Select Source" -IDName "Path"
                            New-PWFFormInput -Select -IDName Selecter -Label "Select Me" -Size 12 -ObjectList (Get-Process | Select -First 10) -Property ProcessName
                            New-PWFFormSubmitButton -Label Submit -Size Large -Flat
                        }
                    }
                }
            }
        }
    }
}