IF EXISTS (select TOP 1 1 from sys.tables where Name = 'desttxdCNStockGoodsType'
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[desttxdCNStockGoodsType]
	(
		 LineNum NUMERIC(19, 0)	
		,[Pre-authorizationSeqID] NUMERIC(19, 0)
		,HBItemID NUMERIC(19, 0)
		,ProductNum NVARCHAR(32)
		,HSNum NVARCHAR(10)
		,ProductName NVARCHAR(512)	
		,ProductSDE NVARCHAR(255)	
		,DeclareUOM NVARCHAR(3)	
		,CustomsUOM NVARCHAR(3)	
		,[2ndCustomsUOM] NVARCHAR(3)	
		,OriginalCountry NVARCHAR(3)	
		,DeclareUnitPrice NUMERIC(25, 5)	
		,DeclareTotalPrice NUMERIC(25, 5)	
		,CurrencyCode NVARCHAR(3)	
		,CustomsQty NUMERIC(19, 0)	
		,[2ndCustomsQty] NUMERIC(19, 0)	
		,WeightConvertRatio NUMERIC(19, 0)	
		,[1stCustomsConvertRatio] NUMERIC(19, 0)	
		,[2ndCustomsConvertRatio] NUMERIC(19, 0)	
		,DeclareQty NUMERIC(19, 0)	
		,GrossWeight NUMERIC(19, 0)	
		,NetWeight NUMERIC(19, 0)	
		,DutyMode NVARCHAR(6)	
		,BOMVersion NVARCHAR(8)	
		,ClassificationMark NVARCHAR(4)	
		,RelatedProductLineNum NUMERIC(19, 0)	
		,CombineOrNot NVARCHAR(255)	
		,DestinationCountry NVARCHAR(3)	
		,Remark NVARCHAR(255)
		
	)
END