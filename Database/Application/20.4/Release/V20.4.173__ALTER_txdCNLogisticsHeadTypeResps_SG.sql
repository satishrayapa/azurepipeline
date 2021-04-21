IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'HandbookType'
			AND Object_ID = OBJECT_ID('txdCNLogisticsHeadTypeResps'))
BEGIN

	ALTER TABLE txdCNLogisticsHeadTypeResps
	DROP COLUMN HandbookType

END