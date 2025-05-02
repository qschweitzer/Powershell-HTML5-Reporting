function Remove-StringSpecialCharactere {
   <#
   .DESCRIPTION
   Nettoie une chaine de caractères de ses accents et caractères spéciaux.
   Possibilité d'utiliser un formatage compatible noms de fichiers.
   .PARAMETER String
   Chaine de caractère. En param ou en pipeline.
   .PARAMETER ForFileName
   Switch indiquant un formatage plus compatible nom de fichiers, en remplaçant la majorité de la ponctuation par des underscores.
   .EXAMPLE
   Remove-StringSpecialCharactere "[TEST] Internal name" -ForFileName
   # Test_Internal_Name
   #>
   [CmdletBinding()]
   param (
      [Parameter(Position = 1, ValueFromPipeline = $true, Mandatory = $true)]
      [string]$String,
      [Parameter(Position = 2, Mandatory = $false)]
      [switch]$ForFileName)

   process {
      if ($ForFileName) {
         [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String)) `
            -replace ' ', '_' `
            -replace '/', '_' `
            -replace '\\', '_' `
            -replace '\*', '_' `
            -replace "'", "_" `
            -replace "\[", "" `
            -replace "\]", "" `
   
      }
      else {
         [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($String)) `
            -replace '-', '' `
            -replace ' ', '' `
            -replace '/', '' `
            -replace '\*', '' `
            -replace "'", "" 
      }
   }
}