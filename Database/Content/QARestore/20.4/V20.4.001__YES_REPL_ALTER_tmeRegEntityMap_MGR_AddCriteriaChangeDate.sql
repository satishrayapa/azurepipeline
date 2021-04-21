USE DTS 

IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'CriteriaChangeDate' --Any 1 of your NEW columns here
			AND ID = OBJECT_ID('tmeRegEntityMap')) --Your Table Here
	BEGIN
		PRINT 'Column Already Exists... Skipping'
	END
ELSE
	BEGIN
		IF EXISTS (SELECT * FROM dbo.syscolumns WHERE id = OBJECT_ID('tmeRegEntityMap')) --Your Table Here
		BEGIN	
			ALTER TABLE dbo.tmeRegEntityMap --Your Table Here
			ADD  
				CriteriaChangeDate DATETIME NOT NULL DEFAULT '1/1/1900'
			EXEC('
			UPDATE dbo.tmeRegEntityMap
			SET CriteriaChangeDate = ModifyDate
			')
		END
	END