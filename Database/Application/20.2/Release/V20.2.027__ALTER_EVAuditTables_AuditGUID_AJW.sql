DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT
SET @NumRows = 0

Declare @columnchanges as ColumnCheckTable
Insert into @columnchanges 
(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
Values
('DeletedFlag','varchar',1,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
('KeepDuringRollback','varchar',1,0,0) -->numeric or decimal based data types need Precision and Scale of the column passed

--Create table of AuditGUIDs per country so we can update all tables to have matching GUIDs
CREATE TABLE #Audits
(CountryCode VARCHAR(2),
AuditGUID UNIQUEIDENTIFIER)

--Insert records for any currently selected audits to know which countries to bother using
INSERT INTO #Audits
SELECT CountryCode, NEWID()
FROM tmgEntryDataAudit WITH (NOLOCK)
GROUP BY CountryCode


--tmgEntryDataAudit
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgEntryDataAudit' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AuditGUID' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('tmgEntryDataAudit')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('tmgEntryDataAudit')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.tmgEntryDataAudit WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [tmgEntryDataAudit] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAudit') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END

			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgEntryDataAudit', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.tmgEntryDataAudit --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.tmgEntryDataAudit --Your Table Here
			ADD  
			AuditGUID UNIQUEIDENTIFIER NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [tmgEntryDataAudit] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAudit') --Your Table Here
					AND [name] IN ( 'AuditGUID' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st parameter.  
			EXEC usp_DBACreateTableIndexes '','tmgEntryDataAudit' --Your Table Here
		END
		
		--Update new AuditGUID values so they're consistent per country
		UPDATE tmgEntryDataAudit
		SET tmgEntryDataAudit.AuditGUID = #Audits.AuditGUID
		FROM #Audits
		WHERE tmgEntryDataAudit.CountryCode = #Audits.CountryCode

		--We need to add AuditGUID to the primary key on the table
		--Delete the primary key constraint.  
		ALTER TABLE [tmgEntryDataAudit]
		DROP CONSTRAINT [PK_tmgEntryDataAudit];   

		--Now create a new primary key including the AuditGUID column
		ALTER TABLE [tmgEntryDataAudit]
		ADD CONSTRAINT [PK_tmgEntryDataAudit] PRIMARY KEY NONCLUSTERED 
		(
			[PartnerID] ASC,
			[AuditGUID] ASC,
			[CountryCode] ASC,
			[DataIdentifier] ASC
		)
	END
END



SET @NumRows = 0

--tmgEntryDataAuditAssignment
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgEntryDataAuditAssignment' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AuditGUID' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('tmgEntryDataAuditAssignment')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('tmgEntryDataAuditAssignment')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.tmgEntryDataAuditAssignment WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [tmgEntryDataAuditAssignment] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditAssignment') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END

			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgEntryDataAuditAssignment', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.tmgEntryDataAuditAssignment --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.tmgEntryDataAuditAssignment --Your Table Here
			ADD  
			AuditGUID UNIQUEIDENTIFIER NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [tmgEntryDataAuditAssignment] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditAssignment') --Your Table Here
					AND [name] IN ( 'AuditGUID' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st parameter.  
			EXEC usp_DBACreateTableIndexes '','tmgEntryDataAuditAssignment' --Your Table Here
		END
		
		--Update new AuditGUID values so they're consistent per country
		set @sql = '
		UPDATE tmgEntryDataAuditAssignment
		SET tmgEntryDataAuditAssignment.AuditGUID = #Audits.AuditGUID
		FROM tmgEntryDataAuditAssignment edaa
		JOIN tmgEntryDataAudit eda WITH (NOLOCK)
		ON edaa.PartnerID = eda.PartnerID AND edaa.EntryGUID = eda.DataGUID
		JOIN #Audits
		ON eda.CountryCode = #Audits.CountryCode'
		exec (@sql)

		--We need to add AuditGUID to the primary key on the table
		--Delete the primary key constraint.  
		ALTER TABLE [tmgEntryDataAuditAssignment]
		DROP CONSTRAINT [PK_tmgEntryDataAuditAssignment];   

		--Now create a new primary key including the AuditGUID column
		ALTER TABLE [tmgEntryDataAuditAssignment]
		ADD CONSTRAINT [PK_tmgEntryDataAuditAssignment] PRIMARY KEY NONCLUSTERED 
		(
			[PartnerID] ASC,
			[AuditGUID] ASC,
			[EntryGUID] ASC
		)
	END
END


SET @NumRows = 0

--tmgEntryDataAuditAssignmentHist
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgEntryDataAuditAssignmentHist' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AuditGUID' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('tmgEntryDataAuditAssignmentHist')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('tmgEntryDataAuditAssignmentHist')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.tmgEntryDataAuditAssignmentHist WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [tmgEntryDataAuditAssignmentHist] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditAssignmentHist') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END
			
			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgEntryDataAuditAssignmentHist', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.tmgEntryDataAuditAssignmentHist --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.tmgEntryDataAuditAssignmentHist --Your Table Here
			ADD  
			AuditGUID UNIQUEIDENTIFIER NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [tmgEntryDataAuditAssignmentHist] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditAssignmentHist') --Your Table Here
					AND [name] IN ( 'AuditGUID' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st parameter.  
			EXEC usp_DBACreateTableIndexes '','tmgEntryDataAuditAssignmentHist' --Your Table Here
		END
		
		--Update new AuditGUID values so they're consistent per country
		set @sql = '
		UPDATE tmgEntryDataAuditAssignmentHist
		SET tmgEntryDataAuditAssignmentHist.AuditGUID = #Audits.AuditGUID
		FROM tmgEntryDataAuditAssignmentHist edaa
		JOIN tmgEntryDataAudit eda WITH (NOLOCK)
		ON edaa.PartnerID = eda.PartnerID AND edaa.EntryGUID = eda.DataGUID
		JOIN #Audits
		ON eda.CountryCode = #Audits.CountryCode
		'
		exec (@sql)

		--We need to add AuditGUID to the primary key on the table
		--Delete the primary key constraint.  
		ALTER TABLE [tmgEntryDataAuditAssignmentHist]
		DROP CONSTRAINT [PK_tmgEntryDataAuditAssignmentHist];   

		--Now create a new primary key including the AuditGUID column
		ALTER TABLE [tmgEntryDataAuditAssignmentHist]
		ADD CONSTRAINT [PK_tmgEntryDataAuditAssignmentHist] PRIMARY KEY NONCLUSTERED 
		(
			[PartnerID] ASC,
			[AuditGUID] ASC,
			[HistGUID] ASC,
			[EntryGUID] ASC
		)
	END
END


SET @NumRows = 0

--tmgEntryDataAuditCompletion
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgEntryDataAuditCompletion' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AuditGUID' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('tmgEntryDataAuditCompletion')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('tmgEntryDataAuditCompletion')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.tmgEntryDataAuditCompletion WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [tmgEntryDataAuditCompletion] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditCompletion') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END
			
			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgEntryDataAuditCompletion', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.tmgEntryDataAuditCompletion --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.tmgEntryDataAuditCompletion --Your Table Here
			ADD  
			AuditGUID UNIQUEIDENTIFIER NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [tmgEntryDataAuditCompletion] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditCompletion') --Your Table Here
					AND [name] IN ( 'AuditGUID' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st parameter.  
			EXEC usp_DBACreateTableIndexes '','tmgEntryDataAuditCompletion' --Your Table Here
		END
		
		--Update new AuditGUID values so they're consistent per country
		set @sql = '
		UPDATE tmgEntryDataAuditCompletion
		SET tmgEntryDataAuditCompletion.AuditGUID = #Audits.AuditGUID
		FROM #Audits
		WHERE tmgEntryDataAuditCompletion.CountryCode = #Audits.CountryCode
		'
		exec (@sql)

		--We need to add AuditGUID to the primary key on the table
		--Delete the primary key constraint.  
		ALTER TABLE [tmgEntryDataAuditCompletion]
		DROP CONSTRAINT [PK_tmgEntryDataAuditCompletion];   

		--Now create a new primary key including the AuditGUID column
		ALTER TABLE [tmgEntryDataAuditCompletion]
		ADD CONSTRAINT [PK_tmgEntryDataAuditCompletion] PRIMARY KEY NONCLUSTERED 
		(
			[PartnerID] ASC,
			[AuditGUID] ASC,
			[CountryCode] ASC
		)
	END
END


SET @NumRows = 0

--trdEntryDataAuditNotes
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'trdEntryDataAuditNotes' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AuditGUID' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('trdEntryDataAuditNotes')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('trdEntryDataAuditNotes')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.trdEntryDataAuditNotes WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [trdEntryDataAuditNotes] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('trdEntryDataAuditNotes') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END
			
			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'trdEntryDataAuditNotes', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.trdEntryDataAuditNotes --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.trdEntryDataAuditNotes --Your Table Here
			ADD  
			AuditGUID UNIQUEIDENTIFIER NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [trdEntryDataAuditNotes] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('trdEntryDataAuditNotes') --Your Table Here
					AND [name] IN ( 'AuditGUID' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st parameter.  
			EXEC usp_DBACreateTableIndexes '','trdEntryDataAuditNotes' --Your Table Here
		END
	END
END


SET @NumRows = 0

--tmgEntryDataAuditOptions
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgEntryDataAuditOptions' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'AuditGUID' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('tmgEntryDataAuditOptions')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('tmgEntryDataAuditOptions')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.tmgEntryDataAuditOptions WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [tmgEntryDataAuditOptions] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditOptions') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END
			
			exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'tmgEntryDataAuditOptions', @Columns = @columnchanges, @ForceCopy = 0 --Your Table Here
			
			ALTER TABLE dbo.tmgEntryDataAuditOptions --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.tmgEntryDataAuditOptions --Your Table Here
			ADD  
			AuditGUID UNIQUEIDENTIFIER NOT NULL DEFAULT '00000000-0000-0000-0000-000000000000' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [tmgEntryDataAuditOptions] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('tmgEntryDataAuditOptions') --Your Table Here
					AND [name] IN ( 'AuditGUID' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st parameter.  
			EXEC usp_DBACreateTableIndexes '','tmgEntryDataAuditOptions' --Your Table Here
		END
		
		--Update new AuditGUID values so they're consistent per country
		set @sql = '
		UPDATE tmgEntryDataAuditOptions
		SET tmgEntryDataAuditOptions.AuditGUID = #Audits.AuditGUID
		FROM #Audits
		WHERE tmgEntryDataAuditOptions.CountryCode = #Audits.CountryCode
		'
		exec (@sql)

		--We need to add AuditGUID to the primary key on the table
		--Delete the primary key constraint.  
		ALTER TABLE [tmgEntryDataAuditOptions]
		DROP CONSTRAINT [PK_tmgEntryDataAuditOptions]; 


		--Now create a new primary key including the AuditGUID column
		ALTER TABLE [tmgEntryDataAuditOptions]
		ADD CONSTRAINT [PK_tmgEntryDataAuditOptions] PRIMARY KEY NONCLUSTERED 
		(
			[PartnerID] ASC,
			[AuditGUID] ASC,
			[CountryCode] ASC
		)
	END
END


--Drop temp AuditGUID table at the very end
DROP TABLE #Audits
