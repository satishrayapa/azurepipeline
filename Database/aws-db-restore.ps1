#--------------------------------------------------------------------
# Restore IPMaster DB
#
# Parameters:
#   server            - SQL server name or IP
#   database          - Database name
#   databasefile      - Name of the back up file to restore from
#   bucketname        - Name of the S3 bucket where database back files are placed
#   bucketprefix      - folder(s) (if any)
#   port              - SQL server port
#   user              - SQL user (sa)
#   password          - SQL password
#   credSecretId - AWS Secret Id for SQL credentials (overrides user and password)
#--------------------------------------------------------------------
param(
    [string]$server = 'localhost\sqlexpress',
    [Parameter(Mandatory)][string]$database = '',
    [string]$databasefile = '',
    [Parameter(Mandatory)][string]$bucketname = 'a205822-infrastructure-database-backups-prod',
    [string]$bucketprefix = 'DBA',
    [string]$port,
    [string]$user = 'sa',
    [string]$password,
    [string]$credSecretId,
    [string]$overwriteifexists = 'False'
)

$ErrorActionPreference = 'Stop'

Import-Module -Name 'SqlServer'

[Reflection.Assembly]::LoadWithPartialName("System.Security") | Out-Null

#--------------------------------------------------------------------
# Main Process
#--------------------------------------------------------------------

$completedatabasefile = ''

if ([String]::IsNullOrEmpty($port)) {
    $serverInstance = $server
}
else {
    $serverInstance = "$server,$port"
}

Write-Host "Server: $serverInstance"
Write-Host "Database: $database"

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

if (-Not [string]::IsNullOrEmpty($checkDB.DbId) -And $overwriteifexists -eq $FALSE) {
    Write-Host '$database database already exist...'
    return
}

if ([string]::IsNullOrEmpty($databasefile) -And $overwriteifexists -eq $TRUE) {
  $latestuploadedbackup = (aws s3api list-objects --bucket $bucketname --prefix $bucketprefix | ConvertFrom-Json).Contents | Sort-Object LastModified -Descending | select -First 1
  $completedatabasefile = $latestuploadedbackup.Key
}
else{
  $completedatabasefile = $bucketprefix + '/' + $databasefile
}

if (-Not [string]::IsNullOrEmpty($checkDB.DbId) -And $overwriteifexists -eq $TRUE) {
    Write-Host 'Deleting $database database...'
$sql = @"
exec msdb.dbo.rds_drop_database	@db_name='$database';
"@

$out = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 
$out
}

Write-Host 'Restoring DB: $database...'
$sql = @"
exec msdb.dbo.rds_restore_database 
	@restore_db_name='$database', 
	@s3_arn_to_restore_from='arn:aws:s3:::$bucketname/$completedatabasefile',
	@with_norecovery=0,
	@type='FULL';
"@

$out = Invoke-SqlCmd -ServerInstance $serverInstance -User $user -Password $password -Query $sql 
$out