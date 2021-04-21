 IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'eHandbookNum'
			AND Object_ID = OBJECT_ID('usrtxdCNHandbookPCDetail'))
BEGIN
	ALTER TABLE usrtxdCNHandbookPCDetail
	DROP COLUMN eHandbookNum
END