Get-ChildItem ".\Functions" | Select-Object * | foreach{
    Import-Module $_.FullName -Force
}

<# Import-Module "D:\GitHub_Projects\PoshWebFramework\Functions\PWF-HTMLMaker.psm1" -Force
Import-Module "D:\GitHub_Projects\PoshWebFramework\Functions\PWF-RequestVarMgmt.ps1" -Force
Import-Module "D:\GitHub_Projects\PoshWebFramework\Functions\PWF-Start-WebServer.psm1" -Force
#>

Start-PoshWebGUI -ListingPort 3030 -ScriptBlock {
    if(($Context.Request.Url.LocalPath) -like "/*"){
        #Convert Requested form input's names into variables with their own value
        #Get-RequestVars
        write-host "Condition validated" -BackgroundColor Red
    }

    #switching between urls
    switch ($Context.Request.Url.LocalPath)
    {
        "/loadProcess" {
            New-PWFPage -Title "Test" -Container -Content {
                New-PWFRow -Content {
                    New-PWFColumn -Scale 3 -Content {
                        Get-Disk | ConvertTo-Html -Fragment | Out-String
                    }
                }
            }
		}
        "/loadServices" {
			Get-Service $ServiceName | Select-Object Status,Name,DisplayName | ConvertTo-Html -CssUri "https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-rc.2/css/materialize.min.css"| Out-String
		}
        default {
            New-PWFPage -Title "Test" -Container -Content {
                New-PWFRow -Content {
                    New-PWFColumn -Scale 6 -Content {
                        New-PWFForm -Scale 12 -ActionPage "loadProcess" -Content {
                            New-PWFFormInput -Text -Label "First Name" -IDName "FirstName" -Scale 6
                            New-PWFFormInput -Text -Label "Name" -IDName "Name" -Scale 6
                            New-PWFFormInput -Email -Label "Email" -IDName "Email" -Scale 12
                            New-PWFFormInput -Password -Label "Password" -IDName "Password" -Scale 6
                            New-PWFFormSubmitButton -Label "Validate" -Scale Large -IconName "cloud"
                        }
                    }
                }
            }
        }
    }
}