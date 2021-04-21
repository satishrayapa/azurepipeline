--------------------------------------------------------------------------------------------------------------
--ADD NEW COLUMN
--Add a new column partnerType to the ttdStagingERPAPIPartnerHeader and ttdStagingERPAPIPartnerHeaderHist table.
--------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'DeletedFlag' AND id = OBJECT_ID('ttdStagingERPAPIPartnerHeader'))
BEGIN
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[#NonDefaultCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		DROP TABLE #NonDefaultCount
	SELECT COUNT(*) AS NumRows INTO #NonDefaultCount FROM dbo.ttdStagingERPAPIPartnerHeader WITH (NOLOCK) 
	WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N'
END
GO

DECLARE @NumRows INT
SET @NumRows = 0
IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'partnerType' AND ID = OBJECT_ID('ttdStagingERPAPIPartnerHeader'))
BEGIN
  PRINT 'Columns Already Exists... Skipping'
END
ELSE
BEGIN
	IF EXISTS (SELECT * FROM dbo.syscolumns WHERE id = OBJECT_ID('ttdStagingERPAPIPartnerHeader')) 
	BEGIN
		SELECT @NumRows = NumRows FROM #NonDefaultCount
	END
	IF @NumRows > 0
	BEGIN
		RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.',16,1)
	END
	ELSE
	BEGIN
		DECLARE @sql NVARCHAR(4000)
		WHILE 1 = 1
		BEGIN
			SELECT TOP 1
			@sql = N'alter table [ttdStagingERPAPIPartnerHeader] ' --Your Table Here
				+ 'drop constraint [' + object_name(sc.cdefault) + N']'
			FROM syscolumns sc
			WHERE 
				[id] = OBJECT_ID('ttdStagingERPAPIPartnerHeader') AND --Your Table Here
				[name] IN ( 'DeletedFlag', 'KeepDuringRollback' ) AND
				cdefault <> 0
        
			IF @@ROWCOUNT = 0
				BREAK
			EXEC (@sql)
		END
	
		ALTER TABLE dbo.ttdStagingERPAPIPartnerHeader 
		DROP COLUMN DeletedFlag, KeepDuringRollback

		ALTER TABLE dbo.ttdStagingERPAPIPartnerHeader 
		ADD 
			partnerType varchar(255) NOT NULL DEFAULT '',
			DeletedFlag varchar(1) NOT NULL DEFAULT 'N',
			KeepDuringRollback varchar(1) NOT NULL DEFAULT 'N'
		
		WHILE 1 = 1 
		BEGIN
			SELECT TOP 1
			@sql = N'alter table [ttdStagingERPAPIPartnerHeader] ' --Your Table Here
				+ 'drop constraint [' + object_name(sc.cdefault) + N']'
			FROM    syscolumns sc
			WHERE   [id] = OBJECT_ID('ttdStagingERPAPIPartnerHeader') --Your Table Here
			AND [name] IN ('partnerType')
			AND cdefault <> 0
			IF @@ROWCOUNT = 0 
			BREAK   
			EXEC (@sql)
		END
	END
END
GO
DROP TABLE #NonDefaultCount

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'DeletedFlag' AND id = OBJECT_ID('ttdStagingERPAPIPartnerHeaderHist'))
BEGIN
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[#NonDefaultCount]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		DROP TABLE #NonDefaultCount
	SELECT COUNT(*) AS NumRows INTO #NonDefaultCount FROM dbo.ttdStagingERPAPIPartnerHeaderHist WITH (NOLOCK) 
	WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N'
END
GO

DECLARE @NumRows INT
SET @NumRows = 0
IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'partnerType' AND ID = OBJECT_ID('ttdStagingERPAPIPartnerHeaderHist'))
BEGIN
  PRINT 'Columns Already Exists... Skipping'
END
ELSE
BEGIN
	IF EXISTS (SELECT * FROM dbo.syscolumns WHERE id = OBJECT_ID('ttdStagingERPAPIPartnerHeaderHist')) 
	BEGIN
		SELECT @NumRows = NumRows FROM #NonDefaultCount
	END
	IF @NumRows > 0
	BEGIN
		RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.',16,1)
	END
	ELSE
	BEGIN
		DECLARE @sql NVARCHAR(4000)
		WHILE 1 = 1
		BEGIN
			SELECT TOP 1
			@sql = N'alter table [ttdStagingERPAPIPartnerHeaderHist] ' --Your Table Here
				+ 'drop constraint [' + object_name(sc.cdefault) + N']'
			FROM syscolumns sc
			WHERE 
				[id] = OBJECT_ID('ttdStagingERPAPIPartnerHeaderHist') AND --Your Table Here
				[name] IN ( 'DeletedFlag', 'KeepDuringRollback' ) AND
				cdefault <> 0
        
			IF @@ROWCOUNT = 0
				BREAK
			EXEC (@sql)
		END
	
		ALTER TABLE dbo.ttdStagingERPAPIPartnerHeaderHist 
		DROP COLUMN DeletedFlag, KeepDuringRollback

		ALTER TABLE dbo.ttdStagingERPAPIPartnerHeaderHist 
		ADD 
			partnerType varchar(255) NOT NULL DEFAULT '',
			DeletedFlag varchar(1) NOT NULL DEFAULT 'N',
			KeepDuringRollback varchar(1) NOT NULL DEFAULT 'N'
		
		WHILE 1 = 1 
		BEGIN
			SELECT TOP 1
			@sql = N'alter table [ttdStagingERPAPIPartnerHeaderHist] ' --Your Table Here
				+ 'drop constraint [' + object_name(sc.cdefault) + N']'
			FROM    syscolumns sc
			WHERE   [id] = OBJECT_ID('ttdStagingERPAPIPartnerHeaderHist') --Your Table Here
			AND [name] IN ('partnerType')
			AND cdefault <> 0
			IF @@ROWCOUNT = 0 
			BREAK   
			EXEC (@sql)
		END
	END
END
GO
DROP TABLE #NonDefaultCount