#--------------------------------------------------------------------
# Creates and / or Migrates DB
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
    [Parameter(Mandatory)][string]$database = 'ReportServiceQueue',
    [string]$port,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId,
    [Parameter(Mandatory)] [string]$sqlPath,
    [string]$baseVer,
    [switch]$repair,
    [switch]$outoforder,
    [String[]]$flywayParams
)

$ErrorActionPreference = 'Stop'

$Script:rootDir = Split-Path $script:MyInvocation.MyCommand.Path
$Script:sqlRootDir = "$rootDir\$sqlPath"
$Script:flywayCmd = "$rootDir\flyway\flyway.cmd"

Import-Module -Name 'SqlServer'

#--------------------------------------------------------------------
# Runs flyway
#--------------------------------------------------------------------
function RunFlyway ([string] $action, [string[]] $actionParams) {

    if ([String]::IsNullOrEmpty($port)) {
        $serverInstance = $server
    }
    else {
        $serverInstance = "$server`:$port"
    }

    $args = @(
        "-url=jdbc:sqlserver://$serverInstance;databaseName=$database",
        "-user=$user",
        """-password=$password""",
        "-locations=filesystem:$sqlRootDir"
    )

    foreach ($i in $actionParams)  
    { 
        $args += $i
    }

    $args += $action

    $proc = Start-Process $flywayCmd -Wait -NoNewWindow -PassThru -ArgumentList $args
    if (0 -ne $proc.ExitCode) {
        throw "Failed to run flyway. Exit code: $($proc.ExitCode). Check output for details."
    }
}

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

Write-Host 'Checking if database exists...'

$sql = @"
USE master 
SELECT DB_ID(N'$database') as DbId
"@

$checkDB = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 

if ([string]::IsNullOrEmpty($checkDB.DbId)) {
    Write-Host 'Creating database...'

    $sql = "CREATE DATABASE $database"
    Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 
}

Write-Host 'Checking if database is empty...'

$sql = "SELECT count(*) as TableCount FROM INFORMATION_SCHEMA.TABLES"
$tableExist = Invoke-SqlCmd -ServerInstance $serverInstance -Database $database -User $user -Password $password -Query $sql

if ($tableExist.TableCount -gt 0) {

    Write-Host 'Checking if database has flyway_schema_history table...'

    $sql = "SELECT COUNT(*) AS TableCount FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'flyway_schema_history'"
    $tableExist = Invoke-SqlCmd -ServerInstance $serverInstance -Database $database -User $user -Password $password -Query $sql

    if ($tableExist.TableCount -eq 0) {
        if (-not [string]::IsNullOrEmpty($baseVer)) {
            Write-Host "Database is not empty. Setting baseline to $baseVer..."
            RunFlyway 'baseline' "-baselineVersion=$baseVer"
        }
        else {
            Write-Host 'Database is not empty. Exiting.'
            return
        }
    }
    else {
        if ($repair) {
            Write-Host 'Database is not empty. Repairing history...'
            RunFlyway 'repair'
        }
    }
}

if ($outoforder)
{
    $flywayParams += "-outOfOrder=true"
}

$flywayParams

Write-Host 'Running database migration...'
RunFlyway 'migrate' $flywayParams
