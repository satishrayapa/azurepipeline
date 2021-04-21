IF NOT EXISTS(SELECT TOP 1 1 FROM tmgForm where FormGUID = 'fugUploadErrors_aspx' and Description = 'fugUploadErrors_aspx' and SystemTypeID = 2)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fugUploadErrors_aspx', 'fugUploadErrors_aspx', 2, getdate(), 'N', 'N'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess where GroupGUID = '1002' and FormGUID = 'fugUploadErrors_aspx' and AccessType = 2)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002', 'fugUploadErrors_aspx', '2', getdate(), 'N', 'N'
END