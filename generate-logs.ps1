param(
    [int]$Lines = 10
)

# Listes de valeurs plausibles
$actions  = @("CONTRACT_SIGNED","USER_CREATED","DOCUMENT_DELETED","LOGIN","LOGOUT","PASSWORD_CHANGED","ACCESS_GRANTED","ACCESS_DENIED")
$roles    = @("Admin","Manager","HR","Finance","User")
$targets  = @("HR-System","Finance-Archive","Administratif-Documents","CRM","ERP","Payroll")
$status   = @("Success","Failed")
$services = @("documents","auth","internal-user","attendance","chatbot","entretiens","offres","settings")

$logFile = "ms-auth_20261304V1_audit.json"

# Nettoyer le fichier avant d'écrire
if (Test-Path $logFile) {
    Remove-Item $logFile
}

for ($i=1; $i -le $Lines; $i++) {
    $action      = Get-Random -InputObject $actions
    $role        = Get-Random -InputObject $roles
    $target      = Get-Random -InputObject $targets
    $stat        = Get-Random -InputObject $status
    $serviceName = Get-Random -InputObject $services
    $matricule   = "ZH" + (Get-Random -Minimum 1000 -Maximum 9999)

    $line = '{"LogType":"Audit","TenantId":"dev-local","UserMatricule":"' + $matricule + '","UserRole":"' + $role + '","Action":"' + $action + '","TargetId":"' + $target + '","Status":"' + $stat + '","service_name":"' + $serviceName + '"}'
    Add-Content -Path $logFile -Value $line
}

Write-Host "$Lines lignes générées dans $logFile"
