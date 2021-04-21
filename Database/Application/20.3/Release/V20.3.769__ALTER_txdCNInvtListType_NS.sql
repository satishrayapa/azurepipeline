IF (
SELECT COUNT(*) FROM dbo.syscolumns
WHERE name IN ('DclUprcAmt','DclQty','DclTotalAmt')
AND ID = OBJECT_ID('txdCNInvtListType')
) = 3

BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('DclUprcAmt','numeric',9,19,4),
	('DclQty','numeric',9,19,5),
	('DclTotalAmt','numeric',9,19,2) 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNInvtListType', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdCNInvtListType 
	ALTER COLUMN DclUprcAmt numeric (19,4) NOT NULL 

	ALTER TABLE txdCNInvtListType 
	ALTER COLUMN DclQty numeric (19,5) NOT NULL 

	ALTER TABLE txdCNInvtListType
	ALTER COLUMN DclTotalAmt numeric (19,2) NOT NULL 
	
	EXEC usp_DBACreateTableIndexes '','txdCNInvtListType'
End