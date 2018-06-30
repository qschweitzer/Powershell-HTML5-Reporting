Function Start-PoshWebGUI
{
<#
.SYNOPSIS
A little webserver.
.DESCRIPTION
A little web server., originaly writed by TibeRiver256 and edited by MrTrez.
.EXAMPLE
Start-PoshWebGUI -ListeningPort 8080 - ScriptBlock {#some code}
.PARAMETER ScriptBlock
Please read the 3 posts about it on http://tiberriver256.github.io/powershell/gui/html/PowerShell-HTML-GUI-Pt1/ that is the real author of most of this code.
.LINK
http://tiberriver256.github.io/powershell/gui/html/PowerShell-HTML-GUI-Pt1/
#>
    param(
        [parameter(Mandatory=$true)]
        $ListeningPort,
        $ScriptBlock        
    )
    # We create a scriptblock that waits for the server to launch and then opens a web browser control
    $UserWindow = {
                
        # Wait-ServerLaunch will continually repeatedly attempt to get a response from the URL before continuing
        function Wait-ServerLaunch
        {

            try {
                $url="http://localhost:$ListingPort/"
                $Test = New-Object System.Net.WebClient
                $Test.DownloadString($url);
            }
            catch
            { start-sleep -Seconds 1; Wait-ServerLaunch }

        }

        Wait-ServerLaunch
    }

    $RunspacePool = [RunspaceFactory]::CreateRunspacePool()
    $RunspacePool.ApartmentState = "STA"
    $RunspacePool.Open()
    $Jobs = @()


    $Job = [powershell]::Create().AddScript($UserWindow).AddArgument($_)
    $Job.RunspacePool = $RunspacePool
    $Jobs += New-Object PSObject -Property @{
    RunNum = $_
    Pipe = $Job
    Result = $Job.BeginInvoke()
    }


    # Create HttpListener Object
    $SimpleServer = New-Object Net.HttpListener

    # Tell the HttpListener what port to listen on
    #    As long as we use localhost we don't need admin rights. To listen on externally accessible IP addresses we will need admin rights
    $SimpleServer.Prefixes.Add("http://localhost:$ListingPort/")

    # Start up the server
    $SimpleServer.Start()

    while($SimpleServer.IsListening)
    {
    Write-Host "Listening for request"
    # Tell the server to wait for a request to come in on that port.
    $Context = $SimpleServer.GetContext()

    #Once a request has been captured the details of the request and the template for the response are created in our $context variable
    Write-Verbose "Context has been captured"

    # $Context.Request contains details about the request
    # $Context.Response is basically a template of what can be sent back to the browser
    # $Context.User contains information about the user who sent the request. This is useful in situations where authentication is necessary


    # Sometimes the browser will request the favicon.ico which we don't care about. We just drop that request and go to the next one.
    if($Context.Request.Url.LocalPath -eq "/favicon.ico")
    {
        do
        {
                $Context.Response.Close()
                $Context = $SimpleServer.GetContext()

        }while($Context.Request.Url.LocalPath -eq "/favicon.ico")
    }

    # Creating a friendly way to shutdown the server
    if($Context.Request.Url.LocalPath -eq "/theend")
    {

        $Result = New-PWFPage -Title "Bye Bye" -Container -Content {
            New-PWFRow -Content {
                New-PWFColumn -Size 12 -Content {
                    New-PWFHeader -HeaderText ((New-PWFIcon -IconName mood -Size large) + " See you next time!") -Size 1
                }
            }
        }
        # We convert the result to bytes from ASCII encoded text
        $buffer = [System.Text.Encoding]::UTF8.GetBytes($Result)

        # We need to let the browser know how many bytes we are going to be sending
        $context.Response.ContentLength64 = $buffer.Length

        # We send the response back to the browser
        $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)

        # We close the response to let the browser know we are done sending the response
        $Context.Response.Close()

        $SimpleServer.Stop()
        break

    }

    if(($Context.Request.Url.LocalPath) -like "/*"){
        #Convert Requested form input's names into variables with their own value
        New-RequestVars -AllKeys ($Context.Request.QueryString.AllKeys) -QueryString ($Context.Request.QueryString)
    }

    #$Context.Request
    # Handling different URLs
    $StartPerfCalc = (Get-Date).Millisecond
    $Pages = $Context.Request.Url.LocalPath
    $result = try {.$ScriptBlock} catch {$_.Exception.Message}

    if($result -ne $null) {
        if($result -is [string]){
            
            Write-Verbose "A [string] object was returned. Writing it directly to the response stream."

        } else {

            Write-Verbose "Converting PS Objects into JSON objects"
            $result = $result | ConvertTo-Json
            
        }
    }
    $EndPerfCalc = (Get-Date).Millisecond
    Write-Host "Sending response of requested form."
    Write-Host "Execution Time: $($EndPerfCalc - $StartPerfCalc) milliseconds" -BackgroundColor Green -ForegroundColor Black

    # We convert the result to bytes from ASCII encoded text
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($Result)

    # We need to let the browser know how many bytes we are going to be sending
    $context.Response.ContentLength64 = $buffer.Length

    # We send the response back to the browser
    $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)

    # We close the response to let the browser know we are done sending the response
    $Context.Response.Close()

    #$Context.Response
    }
}
Function New-RequestVars {
<#
.SYNOPSIS
Convert GET params and values into variables
.DESCRIPTION
Convert GET params and values into variables
.EXAMPLE
New-RequestVars -AllKeys ($Context.Request.QueryString.AllKeys) -QueryString ($Context.Request.QueryString)
.LINK
https://github.com/qschweitzer/PoshWebFramework
#>
    param(
        [Parameter(Mandatory=$true)]
        $AllKeys,
        $QueryString
    )

    $AllKeys | foreach-object {
        Set-Variable -Name $_ -Value $QueryString[$_] -Scope global
    }

}

Function New-PWFAppBuild {
    <#
    .SYNOPSIS
    WebServer and pages building function.
    .DESCRIPTION
    WebServer and pages building function.
    .PARAMETER ListeningPort
    Port on which you want to listen to access your app.
    .PARAMETER PageBlocks
    Refer to the Github link to build the PageBlocks part.
    .EXAMPLE
    New-PWFAppBuild -ListeningPort 8000 -PageBlocks { Switch($Pages) {default{ New-PWFPage...}}}
    .LINK
    https://github.com/qschweitzer/PoshWebFramework
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $ListeningPort=8000,
        $PageBlocks        
    )

    Start-PoshWebGUI -ListeningPort $ListeningPort -ScriptBlock {
        #switching between urls
        try {.$PageBlocks} catch {$_.Exception.Message}
    }

}
Function New-PWFPage{
    <#
    .SYNOPSIS
    Create a new HTML page.
    .DESCRIPTION
    Create a new HTML page with pre-configured settings, and an empty body tag which will contain other blocks.
    .PARAMETER Title
    Title of your WebPage.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .PARAMETER Charset
    Choose your Web Charset encoding.
    .PARAMETER Container
    If added, this parameter will configure the page to have a Container div. Refer to Materialize to understand all the concept of container. https://materializecss.com/getting-started.html
    .EXAMPLE
    New-PWFPage { New-PWFRow -Content {}}
    .LINK
    https://github.com/qschweitzer/PoshWebFramework
    #>
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
    <div class="fixed-action-btn">
        <a href="/theend" class="btn-floating btn-large red">
            <i class="large material-icons">stop</i>
        </a>
    </div>
    </div>
        <footer>
            <script>
                // Or with jQuery
                `$(document).ready(function(){
                `$('.tabs').tabs();
                });
                `$(document).ready(function(){
                    `$('.fixed-action-btn').floatingActionButton();
                  });
                        
            </script>
        </footer>
    </body>

    </html>

"@
return $output
}
Function New-PWFRow{
    <#
    .SYNOPSIS
    Create a new HTML div with Row class.
    .DESCRIPTION
    Create a new HTML div with Row class.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFRow -Content { ... }
    .LINK
    https://github.com/qschweitzer/PoshWebFramework
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
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
    <#
    .SYNOPSIS
    Create a new HTML div with col class.
    .DESCRIPTION
    Create a new HTML div with col class.
    .PARAMETER Size
    This is a parameter to set the size of your Column. Refer to Materialize Grid system.
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFColumn -Size 6 -Content { ... }
    .LINK
    https://github.com/qschweitzer/PoshWebFramework
    #>
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $Size="12",
        $Content        
    )

    $output = @"
        <div class="col m$($Size)">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </div>
"@

return $output

}
Function New-PWFForm{
    <#
    .SYNOPSIS
    Create a new HTML form.
    .DESCRIPTION
    Create a new HTML form.
    .PARAMETER Size
    This is a parameter to set the size of your Column. Refer to Materialize.
    .PARAMETER ActionPage
    Precise wich page this form will redirect to after validation. Ex: -ActionPage ResultPage --> http://localhost:8000/ResultPage
    .PARAMETER Content
    The Content is a scriptblock that will contain next blocks parts.
    .EXAMPLE
    New-PWFForm -Size 6 -Content { ... }
    .LINK
    https://github.com/qschweitzer/PoshWebFramework
    #>
    param(
        [Parameter(Mandatory=$true,Position=1)]
        $Size="12",
        $ActionPage,
        $Content
    )

    $output = @"
        <div class="row">
        <form class="col s$($Size)" action="/$($ActionPage)" method="get">
"@
        $(try {$output += .$Content} catch {$_.Exception.Message})

    $output += @"
        </form>
        </div>
"@

    return $output

}

Function New-PWFFormInput {
    <#
    .SYNOPSIS
    Create a new HTML form.
    .DESCRIPTION
    Create a new HTML form.
    .PARAMETER Text
    Switch parameter. Use it to create this input type.
    .PARAMETER Email
    Switch parameter. Use it to create this input type.
    .PARAMETER Password
    Switch parameter. Use it to create this input type.
    .PARAMETER TextArea
    Switch parameter. Use it to create this input type.
    .PARAMETER File
    Switch parameter. Use it to create this input type.
    .PARAMETER Checkbox
    Switch parameter. Use it to create this input type.
    .PARAMETER Radio
    Switch parameter. Use it to create this input type.
    .PARAMETER Label
    Add text to describe what your input is. Like "Enter your Email"
    .PARAMETER IDName
    This is the Unique ID and Name which will be used to valide input and form.
    .PARAMETER PlaceHolder
    If you want to help your users with a short text in your input. Only for Text, Email.
    .PARAMETER Size
    The size of your input, refer to grid system of Materialize.
    .PARAMETER IconPrefix
    If you want to add a Prefix on your input.
    .PARAMETER disabled
    To disable this Input.
    .PARAMETER checked
    Default checked.
    .PARAMETER multiple
    Multiple select.
    .PARAMETER Label1
    Left text of the switch.
    .PARAMETER Label2
    Right text of the switch.
    .PARAMETER filledin
    Checkbox style. Refer to Materialize Checkbox.
    .PARAMETER withgap
    Radio style. Refer to Materialize radio.
    .PARAMETER min
    Minimum value of the range.
    .PARAMETER max
    Maximum value of the range.
    .PARAMETER OptionLabelListObject
    Object to use to create Select.
    .PARAMETER Required
    Input is required.
    .EXAMPLE
    New-PWFFormInput -Text -Label "First Name" -IDName "FirstName" -Size 6 -Required
    .LINK
    https://github.com/qschweitzer/PoshWebFramework
    #>
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
        $Size="12",
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
        $OptionLabelListObject,
        
        [parameter(Mandatory=$false, ParameterSetName="textarea")]
        [parameter(Mandatory=$false, ParameterSetName="password")]
        [parameter(Mandatory=$false, ParameterSetName="email")]
        [parameter(Mandatory=$false, ParameterSetName="text")]
        [parameter(Mandatory=$false, ParameterSetName="file")]
        [switch]$Required
    )
    if(!($Size)){$Size="12"}

    switch($PsCmdlet.ParameterSetName){
        
        "text"{
            $output=@"
            <div class="input-field col s12 m$Size">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <input $(if($PlaceHolder){write-output 'placeholder="'$PlaceHolder'"'}) id="$($IDName)" name="$($IDName)" type="text" class="validate" $(if($Required){write-output 'required="" aria-required="true"'})>
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "email"{
            $output=@"
            <div class="input-field col s12 m$Size">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <input $(if($PlaceHolder){write-output 'placeholder="'$PlaceHolder'"'}) id="$($IDName)" name="$($IDName)" type="email" class="validate" $(if($Required){write-output 'required="" aria-required="true"'})>
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "password"{
            $output=@"
            <div class="input-field col s12 m$Size">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <input $(if($PlaceHolder){write-output 'placeholder="'$PlaceHolder'"'}) id="$($IDName)" name="$($IDName)" type="password" class="validate" $(if($Required){write-output 'required="" aria-required="true"'})>
                <label for="$($IDName)">$($Label)</label>
            </div>
"@
        }
        "textarea"{
            $output=@"
            <div class="input-field col s12 m$Size">
                $(if($IconPrefix){write-output '<i class="material-icons prefix">'$IconPrefix'</i>'})
                <textarea id="$($IDName)" name="$($IDName)" class="materialize-textarea" $(if($Required){write-output 'required="" aria-required="true"'})>
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
                    <input id="$($IDName)" name="$($IDName)" class="file-path validate" type="text" $(if($Required){write-output 'required="" aria-required="true"'})>
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

Function New-PWFCard{
    param(

        [parameter(Position=0, Mandatory=$true)]
        [ValidateSet("Basic", "Image", "FABs", "Horizontal", "Reveal", "Panel")]
        [string]$CardType,
        $Size,

        [parameter(Position=1, Mandatory=$true)]
        [string]$CardTitle,
        [string]$CardContent,

        [parameter(Position=2, Mandatory=$false)]
        [string]$CardLink1,
        [string]$CardLinkLabel1,
        [string]$CardLink2,
        [string]$CardLinkLabel2,
        [string]$CardImgLink,
        [string]$BackgroundColor="teal",
        [String]$TextColor="white"

    )
    if(!($Size)){$Size="12"}

    switch($CardType){
        "basic"{
            $output = @"
            <div class="col s12 m$($Size)">
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
            <div class="col s12 m$Size">
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
                <div class="col s12 m$Size">
                    <div class="card-panel $BackgroundColor">
                        <span class="$TextColor-text">$($CardContent)
                        </span>
                    </div>
                </div>
            </div>
"@
        }
    }#End Switch
    return $output
}

Function New-PWFFormSubmitButton{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Label,
        
        [Parameter(Mandatory=$false,Position=1)]
        $Size,

        [Parameter(Mandatory=$false,Position=2)]
        [switch]$Disabled,
        [String]$IconName,
        [switch]$Flat,
        [switch]$Float
    )

    switch($Size){
        "Large"{$Size="btn-large"}
        "Small"{$Size="btn-small"}
        "Flat"{$Size="btn-flat"}
        default{$Size=""}
    }

    $output = @"
        <button class="$(if($Float){ write-output 'btn-floating'}) btn waves-effect waves-light $(if($Flat){ write-output 'btn-flat'}) $($Size) $(if($disabled){ write-output ' disabled'})" type="submit" name="action">$($Label)
            $(if($IconName){ write-output '<i class="material-icons right">'$IconName'</i>'})
        </button>
"@

    return $output

}

Function New-PWFButton{
    param(
        
        [Parameter(Mandatory=$false,Position=0)]
        [string]$Label,
        [string]$Size,

        [Parameter(Mandatory=$false,Position=1)]
        [switch]$Flat,
        [switch]$Float,
        [switch]$Disabled,
        [String]$IconName
    )

    switch($Size){
        "Large"{$Size="btn-large"}
        "Small"{$Size="btn-small"}
        default{$Size=""}
    }

    $output = @"
        <button class="$(if($Float){ write-output 'btn-floating'}) btn waves-effect waves-light $(if($Flat){ write-output 'btn-flat'}) $($Size) $(if($disabled){ write-output 'disabled'})">$($Label)
            $(if($IconName){ write-output '<i class="material-icons right">'$IconName'</i>'})
        </button>
"@

    return $output

}

Function New-PWFCollection{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        $CollectionArray,
        
        [Parameter(Mandatory=$false,Position=1)]
        [string]$CollectionColName,
        [string]$HeaderLabel,
        [string]$LinksColName
    )
    
    if($CollectionColName){$OriginalCollection = $CollectionArray ; $CollectionArray = $CollectionArray.([string]$CollectionColName)}

    if($LinksColName){
        $output = @"
            <div class="collection $(if($HeaderLabel){ write-output 'with-header'})">
                $(if($HeaderLabel){ write-output '<div class="collection-header"><h4>'$HeaderLabel'</h4></div>'})
                $($index=0)
                $($CollectionArray | ForEach-Object { write-output '<a href="'($OriginalCollection[$index].([string]$LinksColName).Trim())'" class="collection-item">'$_.Trim()'</a>'}; $index++)
            </div>
"@
    }else{
        $output = @"
            <ul class="collection $(if($HeaderLabel){ write-output 'with-header'})">
                $(if($HeaderLabel){ write-output '<li class="collection-header"><h4>'$HeaderLabel'</h4></li>'})
                $($CollectionArray | ForEach-Object { write-output '<li class="collection-item">'$_.Trim()'</li>'})
            </ul>
"@
    }
    return $output

}

Function New-PWFFlowText{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$YourText
    )

    $output = @"
        <p class="flow-text">$YourText</p>
"@

    return $output

}

Function New-PWFIcon{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$IconName,

        [Parameter(Mandatory=$false,Position=1)]
        [string]$Size
    )

    $output = @"
        <i class="$(if($Size){write-output $Size}) material-icons">$IconName</i>
"@

    return $output

}

Function New-PWFBlockQuote{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$YourText
    )

    $output = @"
        <blockquote>
            $YourText
        </blockquote>
"@

    return $output

}

Function New-PWFHeader{
    param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$HeaderText,
        [ValidateSet(1,2,3,4,5,6)]
        [int]$Size
    )

    $output = @"
        <h$Size>$Headertext</h$Size>
"@
    return $output
}
