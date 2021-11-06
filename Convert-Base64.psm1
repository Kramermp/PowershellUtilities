function Convert-Base64 {
    param (
        $string
    )
    Write-Host [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($string))
}