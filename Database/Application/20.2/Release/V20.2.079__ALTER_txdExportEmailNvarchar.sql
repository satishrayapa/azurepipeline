IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'EmailTo' --your column here
			AND ID = OBJECT_ID('txdExportEmail')) --Your Table Here

	BEGIN
	
		--Do not change 1st and 5th parameter.  
		--4th parameter is the updated data type; 6th paramter is the updated column length if any
		EXEC usp_DBACopyTableIndexesByColumn '','txdExportEmail','EmailTo','nvarchar',1,500

		ALTER TABLE txdExportEmail 
		ALTER COLUMN EmailTo [nvarchar] (500) NOT NULL

		--Do not change 1st paramter.  
		EXEC usp_DBACreateTableIndexes '','txdExportEmail'

	END
GO

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'EmailCC' --your column here
			AND ID = OBJECT_ID('txdExportEmail')) --Your Table Here

	BEGIN
	
		--Do not change 1st and 5th parameter.  
		--4th parameter is the updated data type; 6th paramter is the updated column length if any
		EXEC usp_DBACopyTableIndexesByColumn '','txdExportEmail','EmailCC','nvarchar',1,500

		ALTER TABLE txdExportEmail 
		ALTER COLUMN EmailCC [nvarchar] (500) NOT NULL

		--Do not change 1st paramter.  
		EXEC usp_DBACreateTableIndexes '','txdExportEmail'

	END
GO

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'EmailSubject' --your column here
			AND ID = OBJECT_ID('txdExportEmail')) --Your Table Here

	BEGIN
	
		--Do not change 1st and 5th parameter.  
		--4th parameter is the updated data type; 6th paramter is the updated column length if any
		EXEC usp_DBACopyTableIndexesByColumn '','txdExportEmail','EmailSubject','nvarchar',1,500

		ALTER TABLE txdExportEmail 
		ALTER COLUMN EmailSubject [nvarchar] (500) NOT NULL

		--Do not change 1st paramter.  
		EXEC usp_DBACreateTableIndexes '','txdExportEmail'

	END
GO

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'EmailBody' --your column here
			AND ID = OBJECT_ID('txdExportEmail')) --Your Table Here

	BEGIN
	
		--Do not change 1st and 5th parameter.  
		--4th parameter is the updated data type; 6th paramter is the updated column length if any
		EXEC usp_DBACopyTableIndexesByColumn '','txdExportEmail','EmailBody','nvarchar',1,-1

		ALTER TABLE txdExportEmail 
		ALTER COLUMN EmailBody [nvarchar] (MAX) NOT NULL

		--Do not change 1st paramter.  
		EXEC usp_DBACreateTableIndexes '','txdExportEmail'

	END
GO

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'EmailDocList' --your column here
			AND ID = OBJECT_ID('txdExportEmail')) --Your Table Here

	BEGIN
	
		--Do not change 1st and 5th parameter.  
		--4th parameter is the updated data type; 6th paramter is the updated column length if any
		EXEC usp_DBACopyTableIndexesByColumn '','txdExportEmail','EmailDocList','nvarchar',1,-1

		ALTER TABLE txdExportEmail 
		ALTER COLUMN EmailDocList [nvarchar] (MAX) NOT NULL

		--Do not change 1st paramter.  
		EXEC usp_DBACreateTableIndexes '','txdExportEmail'

	END
GO
