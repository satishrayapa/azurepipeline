IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdPartnerCrossReference]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT 'Table already exists... Skipping'
	END
ELSE
	BEGIN
	CREATE TABLE dbo.tmdPartnerCrossReference(
		PartnerID int NOT NULL DEFAULT '',
		EffDate datetime NOT NULL DEFAULT '',
		AuthenticationKey varchar(255) NOT NULL DEFAULT '',
		OrganizationTypeCode varchar(255) NOT NULL DEFAULT '',
		OrganizationCode varchar(255) NOT NULL DEFAULT '',
		PartnerIdentifier varchar(255) NOT NULL DEFAULT '',
		DeletedFlag varchar(1) NOT NULL DEFAULT 'N',
		KeepDuringRollback varchar(1) NOT NULL DEFAULT 'N')
	END
GO
DECLARE @sql NVARCHAR(4000)
WHILE 1 = 1 
	BEGIN
		SELECT TOP 1
		@sql = N'alter table [tmdPartnerCrossReference] ' --Your Table Here
			+ 'drop constraint [' + object_name(sc.cdefault) + N']'
		FROM    syscolumns sc
		WHERE   [id] = OBJECT_ID('tmdPartnerCrossReference') --Your Table Here
		AND [name] IN ('PartnerID','EffDate','AuthenticationKey','OrganizationTypeCode','OrganizationCode','PartnerIdentifier')
		AND cdefault <> 0
		IF @@ROWCOUNT = 0 
		BREAK   
		EXEC (@sql)
	END

GO
IF EXISTS (SELECT name FROM sys.key_constraints WHERE type = 'PK' AND OBJECT_NAME(parent_object_id) = N'PK_tmdPartnerCrossReference')
BEGIN
	ALTER TABLE tmdPartnerCrossReference
	DROP CONSTRAINT PK_tmdPartnerCrossReference
END
GO
ALTER TABLE tmdPartnerCrossReference
ADD CONSTRAINT PK_tmdPartnerCrossReference PRIMARY KEY (PartnerID,AuthenticationKey,OrganizationTypeCode,OrganizationCode,PartnerIdentifier)