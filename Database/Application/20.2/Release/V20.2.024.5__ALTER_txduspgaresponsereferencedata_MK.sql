--MODIFY EXISTING COLUMN
--txduspgaresponsereferencedata
--  Increase PGAReferenceID to size 18
--------------------------------------------------------------------------------------------------------------
				
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PGAReferenceID' --your column here
			AND Object_ID = OBJECT_ID('txduspgaresponsereferencedata')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txduspgaresponsereferencedata','PGAReferenceID','varchar',1,18
	ALTER TABLE txduspgaresponsereferencedata --Your Table Here
	ALTER COLUMN PGAReferenceID  [varchar] (18) NOT NULL --your column here
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txduspgaresponsereferencedata' --Your Table Here
END