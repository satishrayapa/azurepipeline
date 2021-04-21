DECLARE @pagename VARCHAR(80) = 'SmartHSAutoClassifier_aspx'
DECLARE @GroupGUID VARCHAR(50) = '1002'

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgForm where FormGUID = @pagename and Description = @pagename and SystemTypeID = 1)
BEGIN
	INSERT INTO tmgForm
	SELECT @pagename, @pagename, 1, getdate(), 'N', 'N'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess where GroupGUID = @GroupGUID and FormGUID = @pagename and AccessType = 2)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT @GroupGUID, @pagename, 2, getdate(), 'N', 'N'
END