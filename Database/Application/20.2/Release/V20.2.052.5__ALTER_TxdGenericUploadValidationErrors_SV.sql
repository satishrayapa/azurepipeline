--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

PRINT '.........CREATE/MODIFY TxdGenericUploadValidationErrors.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'TxdGenericUploadValidationErrors' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'FileGUID' --NEW column here
				AND Object_ID = Object_ID('TxdGenericUploadValidationErrors')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_TxdGenericUploadValidationErrors' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_TxdGenericUploadValidationErrors --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_TxdGenericUploadValidationErrors] --"tmp" + Your Table Here
		(
		[PartnerID] [int] NOT NULL,
		[EffDate] [datetime] NOT NULL,
		[UploadType] [nvarchar](50) NOT NULL,
		[FileGUID] [nvarchar](50) NOT NULL,
		[DestinationTable] [varchar](50) NOT NULL,
		[ValidationCode] [nvarchar](50) NOT NULL,
		[LineNum] [int] NOT NULL,
		[FieldName] [varchar](200) NOT NULL,
		[FieldValue] [nvarchar](500) NOT NULL,
		[ValidationMessage] [nvarchar](max) NOT NULL,
		[ValidationSeverity] [nvarchar](50) NOT NULL,
		[Username] [varchar](50) NOT NULL,
		[ValidationGUID] [uniqueidentifier] NOT NULL,
		[DeletedFlag] [varchar](1) NOT NULL,
		[KeepDuringRollback] [varchar](1) NOT NULL,
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [TxdGenericUploadValidationErrors]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_TxdGenericUploadValidationErrors (PartnerID, EffDate, UploadType, FileGUID, DestinationTable, ValidationCode, LineNum, FieldName, FieldValue,ValidationMessage,ValidationSeverity,Username,ValidationGUID, DeletedFlag, KeepDuringRollback)
			SELECT PartnerID, EffDate, UploadType,'''', DestinationTable, ValidationCode, LineNum, FieldName, FieldValue,ValidationMessage,ValidationSeverity,Username,ValidationGUID, DeletedFlag, KeepDuringRollback FROM TxdGenericUploadValidationErrors TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_TxdGenericUploadValidationErrors]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'TxdGenericUploadValidationErrors' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [TxdGenericUploadValidationErrors] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_TxdGenericUploadValidationErrors', N'TxdGenericUploadValidationErrors', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'TxdGenericUploadValidationErrors' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_TxdGenericUploadValidationErrors' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_TxdGenericUploadValidationErrors] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END


