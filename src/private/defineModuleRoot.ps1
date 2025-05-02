function defineModuleRoot {
    if ($MyInvocation.MyCommand.Module.ModuleBase) {
        $moduleroot = $MyInvocation.MyCommand.Module.ModuleBase
    }
    else {
        $moduleroot = "$($MyInvocation.PSScriptRoot | Split-Path)"
    }
    return $moduleroot
}