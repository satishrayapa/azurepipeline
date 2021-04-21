IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'NOTE'
			AND Object_ID = OBJECT_ID('txdCNLogisticsHBInfoResps'))
BEGIN

	ALTER TABLE txdCNLogisticsHBInfoResps
	DROP COLUMN NOTE

END