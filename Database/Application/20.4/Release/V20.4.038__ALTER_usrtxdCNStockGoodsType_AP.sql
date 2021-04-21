IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'usrtxdCNStockGoodsType' 
			AND Type = 'U')
BEGIN
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('Pre-authorizationSeqID','2ndCustomsUOM','2ndCustomsQty','1stCustomsConvertRatio','2ndCustomsConvertRatio')
			AND ID = OBJECT_ID('usrtxdCNStockGoodsType')	
		) = 5
	BEGIN
	-- rename column
	EXEC sp_rename 'usrtxdCNStockGoodsType.Pre-authorizationSeqID', 'PreauthorizationSeqID', 'COLUMN';
	EXEC sp_rename 'usrtxdCNStockGoodsType.2ndCustomsUOM', 'SecondCustomsUOM', 'COLUMN';
	EXEC sp_rename 'usrtxdCNStockGoodsType.2ndCustomsQty', 'SecondCustomsQty', 'COLUMN';
	EXEC sp_rename 'usrtxdCNStockGoodsType.1stCustomsConvertRatio', 'FirstCustomsConvertRatio', 'COLUMN';
	EXEC sp_rename 'usrtxdCNStockGoodsType.2ndCustomsConvertRatio', 'SecondCustomsConvertRatio', 'COLUMN';

	END

END
