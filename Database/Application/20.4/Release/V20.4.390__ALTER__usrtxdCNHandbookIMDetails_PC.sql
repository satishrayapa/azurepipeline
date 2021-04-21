IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'eHandbookNum'
			AND Object_ID = OBJECT_ID('usrtxdCNHandbookIMDetail'))
BEGIN
	ALTER TABLE usrtxdCNHandbookIMDetail
	DROP COLUMN eHandbookNum
END
