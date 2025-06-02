function Convert-MDtoHTML {
    Param(
        [parameter(Mandatory = $false, Position = 0, ValueFromPipeline)]
        [string]$Text
    )
    $nochange = $true
    try {
        [string]$Output = ($Text | Out-String) `
            -replace "#{6}\s(([a-zA-Z0-9\/\s-!]|\n|\r)*)", "<h6>`$1</h6>"`
            -replace "#{5}\s(([a-zA-Z0-9\/\s-!]|\n|\r)*)", "<h5>`$1</h5>"`
            -replace "#{4}\s(([a-zA-Z0-9\/\s-!]|\n|\r)*)", "<h4>`$1</h4>"`
            -replace "#{3}\s(([a-zA-Z0-9\/\s-!]|\n|\r)*)", "<h3>`$1</h3>"`
            -replace "#{2}\s(([a-zA-Z0-9\/\s-!]|\n|\r)*)", "<h2>`$1</h2>"`
            -replace "#{1}\s(([a-zA-Z0-9\/\s-!]|\n|\r)*)", "<h1>`$1</h1>"`
            -replace "\[(([a-zA-Z0-9\/\s-!]|\n|\r)*)\]\((([a-zA-Z0-9\/\s-!]|\n|\r)*)\)", "<a href='`$2'>`$1</a>"

        if ($Output.trim() -ne $text.trim()) {
            $nochange = $false
        }

        [string]$Output = ($(if ($nochange) { $Text | Out-String }else { $Output | Out-String })) `
            -replace "^> (.*)", "<blockquote>`$1</blockquote>" `
            -replace "\*{2}(([a-zA-Z0-9\/\s-!]|\n|\r)*)\*{2}", "<strong>`$1</strong>" `
            -replace "_{2}(([a-zA-Z0-9\/\s-!]|\n|\r)*)_{2}", "<strong>`$1</strong>" `
            -replace "==(([a-zA-Z0-9\/\s-!]|\n|\r)*)==", "<mark>`$1</mark>"`
            -replace "``{1,3}", "<pre>"`
            -replace "\s``(.*)``\s", "<code>`$1</code>"

        if ($output -match "<pre>") {
            if ($script:pre -eq 1) {
                $script:pre = 0
                write-host $script:pre
                $output = $output -replace ("\<pre\>", "</pre>")
            }
            else{
                $script:pre = 1
                write-host $script:pre
            }
        }
        Write-Host "After changes : $output"
    }
    catch {
        Write-Host -ForegroundColor red -Message $_.Exception.Message
        Write-Host $Output
    }
    return ($Output | Out-String)
}