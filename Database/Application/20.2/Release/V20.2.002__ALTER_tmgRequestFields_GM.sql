--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

PRINT '.........MODIFY tmgRequestFields.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'tmgRequestFields' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DocTypeCode' OR name = 'ModuleName' --NEW column here
				AND Object_ID = Object_ID('tmgRequestFields')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_tmgRequestFields' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_tmgRequestFields --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_tmgRequestFields] --"tmp" + Your Table Here
		(
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[RequestGUID] [uniqueidentifier] NOT NULL,  
			[RequestDetailGUID] [uniqueidentifier] NOT NULL,
			[FieldGUID] [uniqueidentifier] NOT NULL,
			[FieldType] [varchar](30) NOT NULL,
			[SourceField] [varchar](100) NOT NULL,
			[Value] [varchar](max) NOT NULL,
			[MandatoryFlag] [varchar](1) NOT NULL,
			[BackloadFlag] [varchar](1) NOT NULL,
			[DocTypeCode] [varchar](max) NOT NULL, --new column
			[ModuleName] [varchar](max) NOT NULL, --new column
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [tmgRequestFields]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_tmgRequestFields (PartnerID, EffDate, RequestGUID, RequestDetailGUID, FieldGUID, FieldType, SourceField, Value, MandatoryFlag, BackloadFlag, DocTypeCode, ModuleName, DeletedFlag, KeepDuringRollback)
			SELECT PartnerID, EffDate, RequestGUID, RequestDetailGUID, FieldGUID, FieldType, SourceField, Value, MandatoryFlag, BackloadFlag, '''', '''', DeletedFlag, KeepDuringRollback FROM tmgRequestFields TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_tmgRequestFields]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'tmgRequestFields' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [tmgRequestFields] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_tmgRequestFields', N'tmgRequestFields', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'tmgRequestFields' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_tmgRequestFields' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_tmgRequestFields] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END