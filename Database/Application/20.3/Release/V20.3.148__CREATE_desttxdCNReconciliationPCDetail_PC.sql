IF EXISTS (select TOP 1 1 from sys.tables where Name = 'desttxdCNReconciliationPCDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[desttxdCNReconciliationPCDetail]
	(
	
		 eHandbookNum NVARCHAR(64)
		,LineNum NUMERIC(19,0)
		,CustomsItemID NUMERIC(19,0) 
		,PartNum NVARCHAR(30)
		,RemainingQty NUMERIC(19,5)
		,ModifyFlag NVARCHAR(4)		
	)
END
