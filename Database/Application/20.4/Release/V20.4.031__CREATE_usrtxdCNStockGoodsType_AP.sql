IF EXISTS (select TOP 1 1 from sys.tables where Name = 'usrtxdCNStockGoodsType'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[usrtxdCNStockGoodsType]
	(
		 PartnerId INT
		,UserName NVARCHAR(4000)
		,FileGUID NVARCHAR(50)
		,LineNum NVARCHAR(4000)	
		,[Pre-authorizationSeqID] NVARCHAR(4000)
		,HBItemID NVARCHAR(4000)
		,ProductNum NVARCHAR(4000)
		,HSNum NVARCHAR(4000)
		,ProductName NVARCHAR(4000)	
		,ProductSDE NVARCHAR(4000)	
		,DeclareUOM NVARCHAR(4000)	
		,CustomsUOM NVARCHAR(4000)	
		,[2ndCustomsUOM] NVARCHAR(4000)	
		,OriginalCountry NVARCHAR(4000)	
		,DeclareUnitPrice NVARCHAR(4000)	
		,DeclareTotalPrice NVARCHAR(4000)	
		,CurrencyCode NVARCHAR(4000)	
		,CustomsQty NVARCHAR(4000)	
		,[2ndCustomsQty] NVARCHAR(4000)	
		,WeightConvertRatio NVARCHAR(4000)	
		,[1stCustomsConvertRatio] NVARCHAR(4000)	
		,[2ndCustomsConvertRatio] NVARCHAR(4000)	
		,DeclareQty NVARCHAR(4000)	
		,GrossWeight NVARCHAR(4000)	
		,NetWeight NVARCHAR(4000)	
		,DutyMode NVARCHAR(4000)	
		,BOMVersion NVARCHAR(4000)	
		,ClassificationMark NVARCHAR(4000)	
		,RelatedProductLineNum NVARCHAR(4000)	
		,CombineOrNot NVARCHAR(4000)	
		,DestinationCountry NVARCHAR(4000)	
		,Remark NVARCHAR(4000)
		
	)
END