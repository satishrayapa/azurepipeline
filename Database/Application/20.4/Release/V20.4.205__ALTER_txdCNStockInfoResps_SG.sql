IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'NOTE'
			AND Object_ID = OBJECT_ID('txdCNStockInfoResps'))
BEGIN
	ALTER TABLE txdCNStockInfoResps
	DROP COLUMN NOTE
END