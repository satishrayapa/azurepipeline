#--------------------------------------------------------------------
# Creates Application SQL User
#
# Parameters:
#   server        - SQL server name or IP
#   port          - SQL server port
#   adminuser     - Admin user (sa)
#   adminpassword - Admin password
#   adminSecretId - AWS Secret Id for Admin credentials (overrides admin user and password)
#   appUser       - Application User Name
#   appPassword   - Application User Password
#   appSecretId   - AWS Secret Id for App credentials (overrides app user and password)
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost\sqlexpress',
    [string]$port,
    [string]$adminUser = 'sa',
    [string]$adminPassword,
    [string]$adminSecretId,
    [string]$appUser = 'IP_App_GTM',
    [string]$appPassword,
    [string]$appSecretId
)

$ErrorActionPreference = 'Stop'

$rootDir = Split-Path $script:MyInvocation.MyCommand.Path

Import-Module -Name 'SqlServer'

if ([String]::IsNullOrEmpty($port)) {
    $serverInstance = $server
}
else {
    $serverInstance = "$server,$port"
}

Write-Host "Server: $serverInstance"
Write-Host "Database: $database"

if (-not [String]::IsNullOrEmpty($adminSecretId)) {
    Write-Host "Retrieving credentials for $adminSecretId from AWS Secrets Manager..."    
    $adminCreds = Get-SECSecretValue -SecretId $adminSecretId | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
    $adminUser = $adminCreds.UserName
    $adminPassword = $adminCreds.Password
}

if (-not [String]::IsNullOrEmpty($appSecretId)) {
    Write-Host "Retrieving credentials for $appSecretId from AWS Secrets Manager..."    
    $appCreds = Get-SECSecretValue -SecretId $appSecretId | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
    $appUser = $appCreds.UserName
    $appPassword = $appCreds.Password
}

#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

Write-Host "Adding SQL Principal for $appUser ..."

$sql = @"
IF NOT EXISTS (SELECT 1 FROM master.sys.server_principals WHERE name = '$appUser')
  CREATE LOGIN $appUser WITH PASSWORD = '$appPassword'
"@

Invoke-SqlCmd -ServerInstance $serverInstance -User $adminUser -Password $adminPassword -Query $sql
