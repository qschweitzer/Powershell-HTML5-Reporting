Function New-PWFPage{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $Title,
        $Content,

        [Parameter(Mandatory=$false,Position=1)]
        $Charset="UTF-8",
        [switch]$Container
    )

    $output = @"
    <!DOCTYPE html>
    <html>
    
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta charset="$($charset)">
            <!-- Compiled and minified CSS -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-rc.2/css/materialize.min.css">
            <!--Import Google Icon Font-->
            <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
            <!-- Compiled and minified JavaScript -->
            <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-rc.2/js/materialize.min.js"></script>
            
            <title>$($title)</title>
        </head>
    <body>
    <div class="container">
"@
        try {$output += .$Content} catch {$_.Exception.Message}
    
    $output += @"
    </div>
        <footer>
            <script>
                // Or with jQuery
                `$(document).ready(function(){
                `$('.tabs').tabs();
                });
            </script>
        </footer>
    </body>

    </html>

"@
return $output
}
Function New-PWFRow{
    param(
        [Parameter(Mandatory=$true,Position=1)]
        $Content
    )

    $output = @"
        <div class="row">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </div>
"@

return $output

}

Function New-PWFColumn{
    param(
        [Parameter(Mandatory=$true,Position=1)]
        $Content,
        $Scale="12"
    )

    $output = @"
        <div class="col m$($Scale)">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </div>
"@

return $output

}
Function New-PWFForm{
    param(
        [Parameter(Mandatory=$true,Position=1)]
        $Content,
        $ActionPage,
        $Scale="12"
    )

    $output = @"
        <div class="row">
        <form class="col s$($Scale)" action="/$($ActionPage)" method="get">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </form>
        </div>
"@

    return $output

}

Function New-PWFFormInput {
    param(
        [parameter(Position=0, Mandatory=$true, ParameterSetName="text")]
        [switch]$Text,
        [parameter(Position=0, Mandatory=$true, ParameterSetName="email")]
        [switch]$Email,
        [parameter(Position=0, Mandatory=$true, ParameterSetName="password")]
        [switch]$Password,
        [parameter(Position=0, Mandatory=$true, ParameterSetName="textarea")]
        [switch]$TextArea,
        [parameter(Position=0, Mandatory=$true, ParameterSetName="file")]
        [switch]$File,
        [parameter(Position=0, Mandatory=$true, ParameterSetName="checkbox")]
        [switch]$Checkbox,
        [parameter(Position=0, Mandatory=$true, ParameterSetName="radio")]
        [switch]$Radio,

        [parameter(Position=1, Mandatory=$true, ParameterSetName="textarea")]
        [parameter(Position=1, Mandatory=$true, ParameterSetName="password")]
        [parameter(Position=1, Mandatory=$true, ParameterSetName="email")]
        [parameter(Position=1, Mandatory=$true, ParameterSetName="text")]
        [parameter(Position=1, Mandatory=$true, ParameterSetName="file")]
        [parameter(Position=1, Mandatory=$true, ParameterSetName="checkbox")]
        [parameter(Position=1, Mandatory=$true, ParameterSetName="radio")]
        $Label,
        $IDName,

        [parameter(Position=2, Mandatory=$false, ParameterSetName="text")]
        [parameter(Position=2, Mandatory=$false, ParameterSetName="email")]
        [parameter(Position=2, Mandatory=$false, ParameterSetName="password")]
        [parameter(Position=2, Mandatory=$false, ParameterSetName="textarea")]
        [parameter(Position=2, Mandatory=$false, ParameterSetName="file")]
        [parameter(Position=2, Mandatory=$false, ParameterSetName="checkbox")]
        [parameter(Position=2, Mandatory=$false, ParameterSetName="radio")]
        $PlaceHolder="",
        $Scale="12",
        $IconPrefix,
        [switch]$disabled,
        [switch]$checked,
        [switch]$multiple,

        [parameter(
        Mandatory=$true,
        ParameterSetName="switch")]
        [string]$Label1,
        [string]$Label2,

        [parameter(
        Mandatory=$false,
        ParameterSetName="checkbox")]
        [switch]$filledin,

        [parameter(
        Mandatory=$false,
        ParameterSetName="radio")]
        [switch]$withgap,

        [parameter(
        Mandatory=$true,
        ParameterSetName="range")]
        [int]$min,
        [int]$max,

        [parameter(
        Mandatory=$true,
        ParameterSetName="select")]
        $OptionLabelListObject
    )
    if(!($Scale)){$Scale="12"}

    switch($PsCmdlet.ParameterSetName){

        "text"{
            $output=@"
            <div class="input-field col s$($Scale)">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <input placeholder="$($PlaceHolder)" id="$($IDName)" name="$($IDName)" type="text" class="validate">
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "email"{
            $output=@"
            <div class="input-field col s$($Scale)">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <input placeholder="$($PlaceHolder)" id="$($IDName)" name="$($IDName)" type="email" class="validate">
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "password"{
            $output=@"
            <div class="input-field col s$($Scale)">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <input placeholder="$($PlaceHolder)" id="$($IDName)" name="$($IDName)" type="password" class="validate">
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "textarea"{
            $output=@"
            <div class="input-field col s$($Scale)">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <textarea id="$($IDName)" name="$($IDName)" class="materialize-textarea">
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "file"{            
            $output=@"
            <div class="file-field input-field">
                <div class="btn">
                    <span>$($Label)</span>
                    <input type="file" $(if($Multiple){write-output "multiple"})>
                </div>
                <div class="file-path-wrapper">
                    <input id="$($IDName)" name="$($IDName)" class="file-path validate" type="text">
                </div>
            </div>
"@
        }
        "switch"{
            $output=@"
            <div class="switch">
                <label>
                $($Label1)
                <input $(if($disabled){write-output "disabled"}) id="$($IDName)" name="$($IDName)" type="checkbox" $(if($checked){write-output "checked"})>
                <span class="lever"></span>
                $($Label2)
                </label>
            </div>
"@
        }
        "checkbox"{
            $output=@"
            <p>
                <label>
                    <input id="$($IDName)" name="$($IDName)" type="checkbox" $(if($disabled){write-output 'disabled="disabled"'}) $(if($checked){write-output "checked"}) />
                    <span>$($Label)</span>
                </label>
            </p>
"@
        }
        "radio"{
            $output=@"
            <p>
                <label>
                    <input id="$($IDName)" $(if($withgap){write-output 'class="with-gap"'}) name="$($IDName)" type="radio" $(if($disabled){write-output 'disabled="disabled"'}) $(if($checked){write-output "checked"}) />
                    <span>$($Label)</span>
                </label>
            </p>
"@
    }
        "range"{
            $output=@"
            <p class="range-field">
                <input type="range" id="$($IDName)" min="0" max="100" />
            </p>

"@
        }
        "select"{}



    }
    return $output
}

Function New-PWFComponent{
    param(
        [parameter(Position=0, Mandatory=$true, ParameterSetName="card")]
        [switch]$Card,

        [parameter(Position=1, Mandatory=$true, ParameterSetName="card")]
        [ValidateSet("Basic", "Image", "FABs", "Horizontal", "Reveal", "Panel")]
        [string]$CardType,

        [parameter(Position=2, Mandatory=$true, ParameterSetName="card")]
        [string]$CardTitle,
        [string]$CardContent,

        [parameter(Position=3, Mandatory=$false, ParameterSetName="card")]
        [string]$CardLink1,
        [string]$CardLinkLabel1,
        [string]$CardLink2,
        [string]$CardLinkLabel2,
        [string]$CardImgLink,

        [Parameter(Mandatory=$true,Position=5)]
        $Scale

    )
    if(!($Scale)){$Scale="12"}

    switch($PsCmdlet.ParameterSetName){

        "card"{

            switch($CardType){
                "basic"{
                    $output = @"
                    <div class="col m$($scale)">
                        <div class="card blue-grey darken-1">
                            <div class="card-content white-text">
                                <span class="card-title">$($CardTitle)</span>
                                <p>$($CardContent)</p>
                            </div>
                            <div class="card-action">
                                <a href="$($CardLink1)">$($CardLinkLabel1)</a>
                                <a href="$($CardLink2)">$($CardLinkLabel2)</a>
                            </div>
                        </div>
                    </div>
"@
                }
                "image"{
                    $output = @"
                    <div class="col m$($scale)">
                        <div class="card">
                            <div class="card-image">
                                <img src="$($CardImgLink)">
                                <span class="card-title">$($CardTitle)</span>
                            </div>
                            <div class="card-content">
                                <p>$($CardContent)</p>
                            </div>
                            <div class="card-action">
                                $(if($CardLink1){ Write-Output '<a href="'$CardLink1'">'$CardLinkLabel1'</a>'})
                                $(if($CardLink2){ Write-Output '<a href="'$CardLink2'">'$CardLinkLabel2'</a>'})
                            </div>
                        </div>
                    </div>
"@
                }
                "panel"{
                    $output = @"
                    <div class="row">
                        <div class="col s12 m5">
                            <div class="card-panel teal">
                                <span class="white-text">$($CardContent)
                                </span>
                            </div>
                        </div>
                    </div>
"@
                }
            }#End Sub Switch

        }
    }#End Switch

    return $output
}

Function New-PWFFormSubmitButton{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Label,
        
        [Parameter(Mandatory=$false,Position=1)]
        $Scale,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Disabled,
        [String]$IconName,
        [switch]$Flat,
        [switch]$Float
    )

    switch($Scale){
        "Large"{$Scale="btn-large"}
        "Small"{$Scale="btn-small"}
        "Flat"{$Scale="btn-flat"}
        default{$Scale=""}
    }

    $output = @"
        <button class="$(if($Float){ write-output 'btn-floating'}) btn waves-effect waves-light $(if($Flat){ write-output 'btn-flat'}) $($Scale) $(if($disabled){ write-output ' disabled'})" type="submit" name="action">$($Label)
            $(if($IconName){ write-output '<i class="material-icons right">'$IconName'</i>'})
        </button>
"@

    return $output

}

Function New-PWFButton{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Label,
        
        [Parameter(Mandatory=$false,Position=1)]
        $Scale,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Flat,
        [switch]$Float,
        [switch]$Disabled,
        [String]$IconName
    )

    switch($Scale){
        "Large"{$Scale="btn-large"}
        "Small"{$Scale="btn-small"}
        default{$Scale=""}
    }

    $output = @"
        <button class="$(if($Float){ write-output 'btn-floating'}) btn waves-effect waves-light $(if($Flat){ write-output 'btn-flat'}) $($Scale) $(if($disabled){ write-output 'disabled'})">$($Label)
            $(if($IconName){ write-output '<i class="material-icons right">'$IconName'</i>'})
        </button>
"@

    return $output

}

Function New-PWFCollection{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Label,
        
        [Parameter(Mandatory=$false,Position=1)]
        $Scale,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Flat,
        [switch]$Float,
        [switch]$Disabled,
        [String]$IconName
    )

    switch($Scale){
        "Large"{$Scale="btn-large"}
        "Small"{$Scale="btn-small"}
        default{$Scale=""}
    }

    $output = @"
        <button class="$(if($Float){ write-output 'btn-floating'}) btn waves-effect waves-light $(if($Flat){ write-output 'btn-flat'}) $($Scale) $(if($disabled){ write-output 'disabled'})">$($Label)
            $(if($IconName){ write-output '<i class="material-icons right">'$IconName'</i>'})
        </button>
"@

    return $output

}