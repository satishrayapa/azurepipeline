#--------------------------------------------------------------------
# Create rebuildindexes and nightly job to back up databases to S3
#
# Parameters:
#   server            - SQL server name or IP
#   port              - SQL server port
#   user              - SQL user (sa)
#   password          - SQL password
#   credSecretId - AWS Secret Id for SQL credentials (overrides user and password)
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost',
    [string]$port,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId
)

$ErrorActionPreference = 'Stop'

$rootDir = Split-Path $script:MyInvocation.MyCommand.Path
$sqlRootDir = $rootDir + "\Job"
$rebuildindexessql = $sqlRootDir + "\usp_DBARebuildIndexes.sql"
$createjobsql = $sqlRootDir + "\AWSBackupJobs.sql"

Import-Module -Name 'SqlServer'

if ([String]::IsNullOrEmpty($port)) {
    $serverInstance = $server
}
else {
    $serverInstance = "$server,$port"
}

Write-Host "Server: $serverInstance"
Write-Host "Scripts Directory: $sqlRootDir"


if (-not [String]::IsNullOrEmpty($credSecretId)) {
    Write-Host "Retrieving credentials for $credSecretId from AWS Secrets Manager..."    
    $creds = Get-SECSecretValue -SecretId $credSecretId | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
    $user = $creds.UserName
    $password = $creds.Password
}

#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

#Write-Host 'Creating rebuildindexes...'

#$out = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -InputFile $rebuildindexessql 
#$out

Write-Host 'Creating job...'

$out = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -InputFile $createjobsql 
$out