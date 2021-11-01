function Install-CCP37 {
    Remove-Module Convert-CP37
    Import-Module "$workingDir\Convert-CP37.psm1"
}

function Convert-CP37 {
    param(
        [String] $sourceFile   
    )
    Write-Host $sourceFile
}