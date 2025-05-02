param(
    [Parameter(Position = 0)]
    [version]$Version,
    [switch]$pipeline,
    [switch]$beta,

    [switch]$build,
    [switch]$import,
    [switch]$test,
    [switch]$deploy,
    [switch]$gendoc
)
Write-Host "Entering assemble.ps1"
$ErrorActionPreference = "Stop"

Get-ChildItem "./.pipeline" -Filter "*.ps1" | ForEach-Object { . $_.fullname }
Write-host "[DEBUG] Pipeline functions loaded"

Install-Requirements
Write-host "[DEBUG] Required modules loaded"

try {
    [string]$ModulePath = ($MyInvocation.MyCommand.path | Split-Path)
    [string]$ModuleName = (Get-ChildItem "$ModulePath/src" -Filter "*.psd1").BaseName.tolower()
    [string]$buildPath = Join-Path $ModulePath "build"
    [string]$testPath = Join-Path $ModulePath "test"

    # Creating directories if not exists or define buildedModulePath
    $toTest = @($buildPath, $testPath)
    foreach ($tPath in $toTest) {
        Write-Host "DEBUG | $tPath"
        if (-not (Test-Path -Path $tPath)) {
            Write-Host "DEBUG | Creating $tPath"
            New-Item -ItemType Directory $tPath | Out-Null
        }
        elseif ($tPath -notmatch "test") {
            # Resolving build path using psd1 in /build
            Write-Host "DEBUG | Resolving $tPath"
            [string]$buildedModulePath = (Get-ChildItem $tPath -Filter "*.psd1" -Recurse).FullName
            if ($buildedModulePath) {
                $buildedModulePath = $buildedModulePath | Split-Path
                
            }
        }
    }
}
catch {
    Write-Host $_.exception.message
    throw "unable to define path variables"
}

if ($build) {
    [string]$ManifestPath = (Get-ChildItem "$ModulePath/src" -Filter "*.psd1" -Recurse).fullname
    # Remove build folder if not in test mode to don't be fucked by the pipeline
    if (-not $test) {
        Write-Host "removing build folder content"
        Get-ChildItem $buildPath | Remove-Item -Recurse -Force
    }

    # if pipeline, update version and prerelease before build
    if ($pipeline) {
        Write-Host "Pipeline in use, run prepare-module"
        if ($beta) {
            $ManifestPath = Prepare-Module $ModuleName $ManifestPath -beta
        }
        else {
            $ManifestPath = Prepare-Module $ModuleName $ManifestPath
        }
    }
    

    Write-Host "Run build module from manifest $manifestpath to $buildPath"
    $manifest = Get-Module $ManifestPath -ListAvailable
    $params = @{}
    $params.SourcePath = $ManifestPath
    $params.OutputDirectory = $buildPath
    $params.UnversionedOutputDirectory = $true
    $params.CopyPaths = "assets"
    $params.verbose = $false
    if ($version) {
        $params.version = $version
    }
    elseif ($manifest.version) {
        $params.version = $manifest.version
    }
    if ($manifest.PrivateData.PSData.prerelease) {
        $params.prerelease = $manifest.PrivateData.PSData.prerelease
    }
    
    # Build module
    try {
        Build-Module @params
        [string]$buildedModulePath = (Get-ChildItem $buildPath -Filter "*.psd1" -Recurse).FullName | Split-Path

        # Removing base files to don't be fucked when tests were be started
        if ((Get-ChildItem "$modulepath/src/private" | Where-Object name -Match "basefiles")) {
            Get-ChildItem "$modulepath/src/private" | Where-Object name -Match "basefiles" | Remove-Item -Recurse -Force
        }
    }
    catch {
        throw $_.exception.message
    }
    # if in a pipeline but not in test mode, build nugetpackage
    if ($pipeline -and -not $test) {
        Write-Host "Pipeline in use, run build-nugetpackage"
        Build-NugetPackage $ModuleName $ModulePath $buildedModulePath $ManifestPath
    }
}

# Redefined manifest path because build and prepare-module change module's version and prerelease
[string]$ManifestPath = (Get-ChildItem "$ModulePath/build" -Filter "*.psd1" -Recurse).fullname

# Import module
if ($import) {        
    try {
        Write-Host "Run import Module $ModuleName from $ManifestPath"
        Import-Module $ManifestPath -Force
    }
    catch {
        throw "Unable to import module $modulename from $manifestpath"
    }
}

if ($test) {
    Write-Host "Run Tests for current module $ModuleName"
    $config                                    = New-PesterConfiguration
    $config.Run.Path                           = $testPath
    $config.Run.PassThru                       = $true
    $config.Run.Throw                          = $true
    $config.CodeCoverage.Enabled               = $true
    $config.CodeCoverage.OutputFormat          = 'CoverageGutters'
    $coverageList                              = "$ModulePath/src"
    $config.CodeCoverage.path                  = $coverageList
    $config.CodeCoverage.OutputPath            = "$ModulePath/test/out/coverage.xml"
    $config.CodeCoverage.CoveragePercentTarget = 60
    $config.TestResult.OutputPath              = "$ModulePath/test/out/result.xml"
    $config.TestResult.Enabled                 = $true
    $config.TestResult.OutputFormat            = "NUnitXml"
    
    try {
        $TestResults = Invoke-Pester -Configuration $config
        Write-Host "✅ All tests passed !"
    }
    catch {
        Write-Host "❌ Some fails during tests!"
        exit 1
    }
}

if ($deploy) {
    Write-Host "Run deploy module"
    deploy-module $ModuleName $buildedModulePath
}

if ($gendoc) {
    Write-Host "Run doc generation of module $ModuleName"
    Create-Markdown $ModuleName $ModulePath
}
