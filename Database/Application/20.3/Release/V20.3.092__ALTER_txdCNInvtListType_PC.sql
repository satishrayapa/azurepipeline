
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('GdsMtNo','GdeCd','GdsNm','GdsSpcfModelDesc','DclUnitCd','DclQty','LvyrlfModeCd') 
			AND Object_ID = OBJECT_ID('txdCNInvtListType')) 
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	('GdsMtNo','nvarchar',50,0,0),
	('GdeCd','varchar',15,0,0),
	('GdsNm','nvarchar',512,0,0),
	('GdsSpcfModelDesc','nvarchar',4000,0,0),
	('DclUnitCd','nvarchar',10,0,0),
	('DclQty','numeric',17,38,20), 
	('LvyrlfModeCd','nvarchar',510,0,0) 

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNInvtListType', @Columns = @columnchanges, @ForceCopy = 0

	ALTER TABLE txdCNInvtListType 
	ALTER COLUMN GdsMtNo [nvarchar] (50) NOT NULL 

	ALTER TABLE txdCNInvtListType 
	ALTER COLUMN GdeCd [varchar] (15) NOT NULL 

	ALTER TABLE txdCNInvtListType
	ALTER COLUMN GdsNm [nvarchar] (512) NOT NULL 

	ALTER TABLE txdCNInvtListType 
	ALTER COLUMN GdsSpcfModelDesc [nvarchar] (4000) NOT NULL 

	ALTER TABLE txdCNInvtListType 
	ALTER COLUMN DclUnitCd [nvarchar] (10) NOT NULL 

	ALTER TABLE txdCNInvtListType
	ALTER COLUMN DclQty numeric(38,20) NOT NULL

	ALTER TABLE txdCNInvtListType --Your Table Here
	ALTER COLUMN LvyrlfModeCd [nvarchar] (510) NOT NULL
	
	
	EXEC usp_DBACreateTableIndexes '','txdCNInvtListType'
End