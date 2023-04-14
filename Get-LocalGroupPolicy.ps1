function Get-LocalGroupPolicy {
    [CmdletBinding()]
    param ()

    $ExportFilePath = "LocalGroupPolicy.inf"

    secedit /export /cfg $ExportFilePath /areas SECURITYPOLICY

    $LocalGroupPolicy = Get-Content -Path $ExportFilePath | Where-Object {
        $_ -match "^\[.*\]" -or ($_ -match "^[\w\s]+=.+$")
    }

    Remove-Item $ExportFilePath

    return $LocalGroupPolicy
}

$LocalGroupPolicy = Get-LocalGroupPolicy
$LocalGroupPolicy
