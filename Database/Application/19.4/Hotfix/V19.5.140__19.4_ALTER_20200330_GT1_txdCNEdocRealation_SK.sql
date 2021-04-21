IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'SignTime' --your column here
			AND Object_ID = OBJECT_ID('txdCNEdocRealation')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNEdocRealation','SignTime','nvarchar',1,255

	ALTER TABLE txdCNEdocRealation 
	ALTER COLUMN SignTime nvarchar(255) NOT NULL 

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNEdocRealation' --Your Table Here
END



