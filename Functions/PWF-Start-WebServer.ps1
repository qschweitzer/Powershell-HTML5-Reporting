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