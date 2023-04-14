function Get-AppliedGPOsLocal {
    [CmdletBinding()]
    param ()

    $GpResult = gpresult /R /Scope:Computer /X gpresult.xml
    $ReportXml = [xml](Get-Content -Path gpresult.xml)

    $AppliedGPOs = $ReportXml.Rsop.ComputerResults.GPO | Where-Object {
        $_.Enabled -eq "true"
    } | ForEach-Object {
        New-Object PSObject -Property @{
            DisplayName = $_.Name
            GPOID       = $_.Id
        }
    }

    Remove-Item gpresult.xml

    return $AppliedGPOs
}

$AppliedGPOs = Get-AppliedGPOsLocal
$AppliedGPOs
