
IF ( SELECT count(*)  FROM sys.tables WHERE name = 'trdExportHeader' and len(name)*2 <> DATALENGTH(name)	) = 1
  AND 
  ( SELECT count(*)  FROM sys.tables WHERE name = 'trdExportHeader' and len(name)*2 = DATALENGTH(name) ) = 0
BEGIN
	print 'correcting trdExportHeader with a space'
	exec sp_RENAME N'[dbo].[trdExportHeader ]' , N'trdExportHeader';
END
ELSE
BEGIN
	print 'table already correct'
END