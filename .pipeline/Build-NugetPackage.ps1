function build-nugetpackage {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ModuleName,
        [string]$ModulePath,
        [string]$nugetPath,
        [string]$ManifestPath,
        [version]$version
    )

    Write-Host -ForegroundColor magenta "[PHASE] Entering build-nugetpackage" -ShowDebug
    $ErrorActionPreference = "Stop"

    if(-not $version){
        $version = (get-module $manifestPath -ListAvailable).version
    }

    Write-Host -ForegroundColor cyan "[INFO] Packaging $($ModuleName):$Version" -ShowDebug
    New-Item -ItemType Directory $nugetPath -ErrorAction SilentlyContinue
    try {
        Write-Host "[DEBUG] Converting manifest to nuspec manifest"
        # Conversion du psd1 en nuspec
        . "$($PSScriptRoot)/Convert-PSD1ToNuspec.ps1" $manifestPath $nugetPath
    }
    catch {
        Write-Host -ForegroundColor red "[ERROR]  $($_.exception.message)"
        throw "Unable to convert psd1 to nuspec"
    }

    try {
        # Preparing build of Nuget package
        Write-Host "[DEBUG] Preparing build of Nuget package"
        $csprojtemp = "$ModulePath/tmp" #workaround to unable to create nuget pkg without csproj
        if (-not (Test-Path $csprojtemp)) {
            mkdir $csprojtemp | Out-Null #workaround to: unable to create nuget pkg without csproj
        }
        $nuspec = (Get-ChildItem $NugetPath -Filter "*.nuspec" -Recurse).fullname
        dotnet new classlib -o $csprojtemp -v q | Out-Null #workaround to unable to create nuget pkg without csproj
        $csprojfile = (Join-Path $csprojtemp "tmp.csproj")
    
        # Modification CSProj pour supprimer les warnings inutiles
        $xml = [xml](Get-Content $csprojfile)
        $propertyGroup = $xml.Project.PropertyGroup
        $newElement = $xml.CreateElement("NoWarn")
        $newElement.InnerText = "`$(NoWarn);NU5110;NU5111"
        $propertyGroup.AppendChild($newElement)
        $xml.Save($csprojfile)

    }
    catch {
        Write-Host -ForegroundColor red "[ERROR]  $($_.exception.message)"
        throw "Unable to prepare build of nuget"
    }

    try {

        # $ignore = $Error |
        #     Where-Object { $_.CategoryInfo.Activity -eq "Find-Package" } |
        #         Where-Object { $_.CategoryInfo.Category -eq [System.Management.Automation.ErrorCategory]::ObjectNotFound }
        # $ignore | ForEach-Object { $Error.Remove($_) }

        Write-Host "[DEBUG] dotnet pack: $($nuspec.fullname):$(Test-Path $nuspec -ErrorAction stop)" -ShowDebug
        dotnet pack $csprojfile --no-build -p:NuspecFile=$($nuspec) -p:PackageVersion=$Version -o $nugetPath -v q
        Write-Host "[SUCCESS] dotnet pack: $($nuspec.fullname):$(Test-Path $nuspec -ErrorAction stop)" -ShowDebug
    }
    catch {
        Write-Host -ForegroundColor red "[ERROR] $($_.exception.message)"
        throw "Unable to package nuspec file"
    }
}