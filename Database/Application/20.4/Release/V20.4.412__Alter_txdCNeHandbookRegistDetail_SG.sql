
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Value' 
			AND Object_ID = OBJECT_ID('txdCNeHandbookRegistDetail'))
BEGIN
	EXEC usp_DBACopyTableIndexesByColumn '','txdCNeHandbookRegistDetail','Value','numeric',1,null,25,5

	Alter table txdCNeHandbookRegistDetail
	Alter column Value numeric(25,5) not null

	EXEC usp_DBACreateTableIndexes '','txdCNeHandbookRegistDetail'
END
