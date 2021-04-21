IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'HandbookNum'
			AND Object_ID = OBJECT_ID('usrtxdCNHandbookConsDetail'))
BEGIN
	ALTER TABLE usrtxdCNHandbookConsDetail
	DROP COLUMN HandbookNum
END