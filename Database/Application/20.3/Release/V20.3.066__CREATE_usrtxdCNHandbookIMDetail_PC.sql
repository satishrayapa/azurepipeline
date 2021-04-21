IF EXISTS (select TOP 1 1 from sys.tables where Name = 'usrtxdCNHandbookIMDetail'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[usrtxdCNHandbookIMDetail]
	(
		 PartnerId INT
		,UserName NVARCHAR(4000)
		,FileGUID NVARCHAR(50)
		,eHandbookNum NVARCHAR(4000)
		,LineNum NVARCHAR(4000)
		,ProductNum NVARCHAR(4000)
		,HSNum NVARCHAR(4000)
		,ProductName NVARCHAR(4000)
		,ProductSDE NVARCHAR(4000)
		,TxnQtyUOM NVARCHAR(4000)
		,RptQtyUOM NVARCHAR(4000)
		,AddlRptQtyUOM NVARCHAR(4000)
		,TxnQty NVARCHAR(4000)
		,Value NVARCHAR(4000)
		,CurrencyCode NVARCHAR(4000)
		,DutyMode NVARCHAR(4000)
		,EnterpriseExecuteMarkCode NVARCHAR(4000)
		,ModifyMarkCode NVARCHAR(4000)
        ,Remark NVARCHAR(4000)
	)	
END
