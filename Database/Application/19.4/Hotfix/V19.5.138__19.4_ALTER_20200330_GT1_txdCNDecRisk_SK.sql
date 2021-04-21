IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'SignDate' --your column here
			AND Object_ID = OBJECT_ID('txdCNDecRisk')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNDecRisk','SignDate','datetime',1,8

	ALTER TABLE txdCNDecRisk --Your Table Here
	ALTER COLUMN SignDate datetime NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNDecRisk' --Your Table Here
END