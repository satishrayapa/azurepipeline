#--------------------------------------------------------------------
# Creates and / or Migrates all partners DBs defined in Security DB
#
# Parameters:
#   server       - SQL server name or IP (Security DB)
#   database     - Database name (Security DB)
#   port         - SQL server port (Security DB)
#   user         - SQL user (sa) (Security DB)
#   password     - SQL password (Security DB)
#   credSecretId - AWS Secret Id for SQL credentials (overrides user and password)
#   sqlPath      - Relative path to SQL scripts home folder for Partner DB
#   partnerId    - If specified, migrates this partner only
#   baseVer      - Baseline version to use if DB exist, not empty,
#                  and has no flyway_schema_history table.
#                  If this parameter is not specified then migration step
#                  is ignored.
#   repair       - Repairs flyway schema history table
#--------------------------------------------------------------------
param(
    [string]$server
)



Write-Host "Server: $server" 

#$partids = $arr -join ', '
#$partids
$name = "trsuccess,trcomapny,trcorporation,trsomething,hello"
$name.GetType().FullName
#Write-Host "##vso[task.setvariable variable=mypartids;]$partids"
Write-Host "##vso[task.setvariable variable=StorageName;isOutput=true]$name"
#Write-Host "##vso[task.setvariable variable=$groupVariableName;isOutput=true]$value"

#Write-Host "##vso[task.setvariable variable=testvar;]testvalue"
#echo "##vso[task.setvariable variable=MYPARTIDS]$partids"
Write-Host "================"
#Write-Host "$(MYPARTIDS)"
#Write-Host "MY VARIABLE IS $env:MYPARTIDS"
#Write-Host " some $MYPARTIDS"
#Write-Host " so $partids"
#$env:MYPARTIDS

Write-Host "================"
