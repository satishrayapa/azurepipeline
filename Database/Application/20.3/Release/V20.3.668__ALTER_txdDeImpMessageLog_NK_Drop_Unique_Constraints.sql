PRINT '.........MODIFY txdDeImpMessageLog.............'
PRINT 'DROPPING CONSTRAINT UIX_txdDEImpGoodsItem_MetaDataInterchangeControlReference'

IF EXISTS (
		SELECT TOP 1 1
		FROM sys.indexes
		WHERE object_id = Object_ID('txdDeImpMessageLog') AND name = 'UIX_txdDEImpGoodsItem_MetaDataInterchangeControlReference' AND is_unique_constraint = 1
		)
BEGIN
	ALTER TABLE txdDeImpMessageLog

	DROP CONSTRAINT UIX_txdDEImpGoodsItem_MetaDataInterchangeControlReference
END
ELSE
	PRINT 'Table/Index does not exist...'

PRINT '.........MODIFY txdDeImpMessageLog.............'
PRINT 'DROPPING CONSTRAINT UIX_txdDEImpGoodsItem_MetaDataMessageIdentifier'

IF EXISTS (
		SELECT TOP 1 1
		FROM sys.indexes
		WHERE object_id = Object_ID('txdDeImpMessageLog') AND name = 'UIX_txdDEImpGoodsItem_MetaDataMessageIdentifier' AND is_unique_constraint = 1
		)
BEGIN
	ALTER TABLE txdDeImpMessageLog

	DROP CONSTRAINT UIX_txdDEImpGoodsItem_MetaDataMessageIdentifier
END
ELSE
	PRINT 'Table/Index does not exist...'
