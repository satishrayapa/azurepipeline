IF (SELECT COUNT(*) FROM sys.tables WHERE name = '[trdExportHeader]'	) = 1
  AND 
  (SELECT COUNT(*) FROM sys.tables WHERE name = 'trdExportHeader'	) = 0
BEGIN
	print 'correcting trdExportHeader with []'
	exec sp_RENAME N'[dbo]."[trdExportHeader]"' , N'trdExportHeader';
END
ELSE
BEGIN
	print 'table already correct'
END