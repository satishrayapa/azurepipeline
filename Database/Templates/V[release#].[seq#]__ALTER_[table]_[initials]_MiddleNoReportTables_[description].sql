--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

PRINT '.........CREATE/MODIFY Table_1.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'Table_1' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'NewColumn1' --NEW column here
				AND Object_ID = Object_ID('Table_1')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_Table_1' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_Table_1 --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_Table_1] --"tmp" + Your Table Here
		(
			PartnerID int NOT NULL,
			EffDate datetime NOT NULL,
			Column1 varchar(50) NOT NULL,
			Column2 varchar(50) NOT NULL,
			Column3 varchar(30) NOT NULL,
			Column4 varchar(150) NOT NULL,
			NEWColumn1 varchar(50) NOT NULL,
			NEWColumn2 varchar(2500) NOT NULL,
			Column5 varchar(50) NOT NULL,
			Column6 varchar(50) NOT NULL,
			DeletedFlag varchar(1) NOT NULL,
			KeepDuringRollback varchar(1) NOT NULL
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [Table_1]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_Table_1 (PartnerID, EffDate, Column1, Column2, Column3, Column4, NEWColumn1, NEWColumn2, Column5, Column6, DeletedFlag, KeepDuringRollback)
			SELECT PartnerID, EffDate, Column1, Column2, Column3, Column4, '''', '''', Column5, Column6, KeepDuringRollback FROM Table_1 TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_Table_1]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'Table_1' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [Table_1] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_Table_1', N'Table_1', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'Table_1' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_Table_1' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_Table_1] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END