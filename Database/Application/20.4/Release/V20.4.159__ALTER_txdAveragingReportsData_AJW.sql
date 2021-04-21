IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('RVCPercentage','Option1Percentage') --your column here
			AND Object_ID = OBJECT_ID('txdAveragingReportsData')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('RVCPercentage','numeric',38,38,20), -->numeric or decimal based data types need Precision and Scale of the column passed 
	('Option1Percentage','numeric',38,38,20) -->numeric or decimal based data types need Precision and Scale of the column passed 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdAveragingReportsData', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdAveragingReportsData --Your Table Here
	ALTER COLUMN RVCPercentage numeric(38,20) NOT NULL --your column here
	
	ALTER TABLE txdAveragingReportsData --Your Table Here
	ALTER COLUMN Option1Percentage numeric(38,20) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdAveragingReportsData' --Your Table Here
End