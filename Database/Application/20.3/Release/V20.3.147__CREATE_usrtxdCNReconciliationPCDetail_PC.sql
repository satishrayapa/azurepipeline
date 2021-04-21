IF EXISTS (select TOP 1 1 from sys.tables where Name = 'usrtxdCNReconciliationPCDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[usrtxdCNReconciliationPCDetail]
	(
		 PartnerId INT
		,UserName NVARCHAR(4000)
		,FileGUID NVARCHAR(50)
		,eHandbookNum NVARCHAR(4000)
		,LineNum NVARCHAR(4000)
		,CustomsItemID NVARCHAR(4000) 
		,PartNum NVARCHAR(4000)
		,RemainingQty NVARCHAR(4000)
		,ModifyFlag NVARCHAR(4000)
		
	)
END


