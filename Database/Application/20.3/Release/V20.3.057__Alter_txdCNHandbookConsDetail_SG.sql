
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('PCProductSeqNum','PCProductNum','PCHSNum','PCProductName') --your column here
			AND Object_ID = OBJECT_ID('txdCNHandbookConsDetail')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
	--('PCProductSeqNum','numeric',19,19,0),
	('PCProductNum','nvarchar',32,0,0),
	('PCHSNum','nvarchar',10,0,0),
	('PCProductName','nvarchar',512,0,0)

	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNHandbookConsDetail', @Columns = @columnchanges, @ForceCopy = 0

	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PCProductSeqNum' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdCNHandbookConsDetail')) --Your Table Here
	BEGIN
			ALTER TABLE [txdCNHandbookConsDetail] 
			DROP COLUMN PCProductSeqNum
	END
	ELSE
	BEGIN
			PRINT 'Column does not Exists... Skipping.'
	END

	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PCProductNum' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdCNHandbookConsDetail')) --Your Table Here
	BEGIN
			ALTER TABLE [txdCNHandbookConsDetail] 
			DROP COLUMN PCProductNum
	END
	ELSE
	BEGIN
			PRINT 'Column does not Exists... Skipping.'
	END

	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PCHSNum' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdCNHandbookConsDetail')) --Your Table Here
	BEGIN
			ALTER TABLE [txdCNHandbookConsDetail] 
			DROP COLUMN PCHSNum
	END
	ELSE
	BEGIN
			PRINT 'Column does not Exists... Skipping.'
	END

	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'PCProductName' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdCNHandbookConsDetail')) --Your Table Here
	BEGIN
			ALTER TABLE [txdCNHandbookConsDetail] 
			DROP COLUMN PCProductName
	END
	ELSE
	BEGIN
			PRINT 'Column does not Exists... Skipping.'
	END

	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name ='BOMDueDate'
			AND Object_ID = OBJECT_ID('txdCNHandbookConsDetail'))
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		ALTER TABLE [txdCNHandbookConsDetail] 
		ADD [BOMDueDate] [datetime] NULL
	END

	EXEC usp_DBACreateTableIndexes '','txdCNHandbookConsDetail'
End

