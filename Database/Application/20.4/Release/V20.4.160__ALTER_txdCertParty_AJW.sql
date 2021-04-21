--txdCertParty
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CompanyID' --your column here
			AND Object_ID = OBJECT_ID('txdCertParty')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdCertParty','CompanyID','nvarchar',1,100

	ALTER TABLE txdCertParty --Your Table Here
	ALTER COLUMN CompanyID [nvarchar] (100) NOT NULL --your column here

	--Do not change 1st parameter.  
	EXEC usp_DBACreateTableIndexes '','txdCertParty' --Your Table Here
END

--trdReportFTAParty
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CompanyID' --your column here
			AND Object_ID = OBJECT_ID('trdReportFTAParty')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','trdReportFTAParty','CompanyID','nvarchar',1,100

	ALTER TABLE trdReportFTAParty --Your Table Here
	ALTER COLUMN CompanyID [nvarchar] (100) NOT NULL --your column here

	--Do not change 1st parameter.  
	EXEC usp_DBACreateTableIndexes '','trdReportFTAParty' --Your Table Here
END