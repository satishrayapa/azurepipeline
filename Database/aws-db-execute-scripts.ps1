#--------------------------------------------------------------------
# Execute DB scritps
#
# Parameters:
#   server        - SQL server name or IP
#   database      - Database name
#   port          - SQL server port
#   user          - SQL user (sa)
#   password      - SQL password (for user)
#   credSecretId    AWS Secret Id for SQL credentials (overrides user and password)
#   sqlPath       - Relative path to SQL scripts home folder for this DB
#   baseVer       - Baseline version to use if DB exist, not empty,
#                   and has no flyway_schema_history table.
#                   If this parameter is not specified then migration step
#                   is ignored.
#   repair        - Repairs flyway schema history table
#   flywayParams  - additional parameters to pass to Flyway when running migration
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost\sqlexpress',
    [string]$database,
    [string]$script,
    [string]$port,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId
)

$ErrorActionPreference = 'Stop'

$rootDir = Split-Path $script:MyInvocation.MyCommand.Path
$sqlRootDir = "$rootDir\$database"

if ([String]::IsNullOrEmpty($script) -And [String]::IsNullOrEmpty($database)){
  $sqlscript = @("$rootDir\Shared\master_to_ipmaster.sql", "$rootDir\IPMaster\ci_ipmaster_permissions.sql")
}
else{
  $sqlRootDir = "$rootDir\$database"  
  $sqlscript = "$sqlRootDir\$script"
}

Import-Module -Name 'SqlServer'

#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

if ([String]::IsNullOrEmpty($port)) {
    $serverInstance = $server
}
else {
    $serverInstance = "$server,$port"
}

Write-Host "Server: $serverInstance"
Write-Host "Database: $database"
Write-Host "Scripts Directory: $sqlRootDir"

if (-not [String]::IsNullOrEmpty($credSecretId)) {
    Write-Host "Retrieving credentials for $credSecretId from AWS Secrets Manager..."    
    $creds = Get-SECSecretValue -SecretId $credSecretId | Select-Object -ExpandProperty SecretString | ConvertFrom-Json
    $user = $creds.UserName
    $password = $creds.Password
}

if (-not [String]::IsNullOrEmpty($database)){

  Write-Host 'Checking if database exists...'

  $sql = @"
USE master 
SELECT DB_ID(N'$database') as DbId
"@

  $checkDB = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 

  if (-Not [string]::IsNullOrEmpty($checkDB.DbId)) {
      Write-Host '$database database does not exist...'
      return
  }
}

Write-Host 'Executing scripts...'

$sqlscript | ForEach-Object -Begin {
    $results = @()
  } -Process {
      #Executing script
      Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -InputFile $_!
      $results += 1
  } -End {
      #Count total scripts executed
      Write-Host "Total scritps executed: $($results.Count)"
  }

