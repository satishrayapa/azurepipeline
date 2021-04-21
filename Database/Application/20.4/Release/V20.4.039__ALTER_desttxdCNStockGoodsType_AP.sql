IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'desttxdCNStockGoodsType' 
			AND Type = 'U')
BEGIN
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('Pre-authorizationSeqID','2ndCustomsUOM','2ndCustomsQty','1stCustomsConvertRatio','2ndCustomsConvertRatio')
			AND ID = OBJECT_ID('desttxdCNStockGoodsType')	
		) = 5
	BEGIN
	-- rename column
	EXEC sp_rename 'desttxdCNStockGoodsType.Pre-authorizationSeqID', 'PreauthorizationSeqID', 'COLUMN';
	EXEC sp_rename 'desttxdCNStockGoodsType.2ndCustomsUOM', 'SecondCustomsUOM', 'COLUMN';
	EXEC sp_rename 'desttxdCNStockGoodsType.2ndCustomsQty', 'SecondCustomsQty', 'COLUMN';
	EXEC sp_rename 'desttxdCNStockGoodsType.1stCustomsConvertRatio', 'FirstCustomsConvertRatio', 'COLUMN';
	EXEC sp_rename 'desttxdCNStockGoodsType.2ndCustomsConvertRatio', 'SecondCustomsConvertRatio', 'COLUMN';

	END

END