--select max(Version) from tbgSQLCommands

DECLARE @CurrentRelease as Varchar(20)
DECLARE @NewRelease as Varchar(20)

SET @CurrentRelease = '19.3'
SET @NewRelease = '19.4'

INSERT INTO tbgSQLCommands 
(PartnerID,EffDate,SQLGUID,SQLCommand,Description,LongDescription,CreatedDate,CreatedBy,ApprovedBy,SQLHash,SQLType,
Version,DeletedFlag,KeepDuringRollback) 
SELECT PartnerID,EffDate,SQLGUID,SQLCommand,Description,LongDescription,GETDATE(),CreatedBy,ApprovedBy,SQLHash,SQLType,
@NewRelease,DeletedFlag,KeepDuringRollback 
FROM tbgSQLCommands 
WHERE PartnerID = 4000 AND 
  DeletedFlag = 'N' AND 
  Version = @CurrentRelease AND 
  SQLGUID NOT IN 
	( SELECT SQLGUID FROM tbgSQLCommands WHERE PartnerID = 4000 AND DeletedFlag = 'N' AND Version = @NewRelease ) 

 