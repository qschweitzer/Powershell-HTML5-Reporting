Function Install-Requirements {
    param($stage = $env:CI_JOB_STAGE)

    switch ($stage) {
        "build" {
            $modules = @("ModuleBuilder")
        }
        "test" {
            $modules = @("Pester", "ModuleBuilder")
        }
    }

    if ($modules) {
        Set-PackageSource PSGallery -Trusted > $null
        foreach ($m in $modules) {
            try {
                Get-InstalledModule -Name $m -ErrorAction stop
            }
            catch {
                Write-Host -ForegroundColor cyan "[INFO] Installing $m"
                Install-Module $m -Force -SkipPublisherCheck
                Import-Module $m -Force
            }
        }
    }
}