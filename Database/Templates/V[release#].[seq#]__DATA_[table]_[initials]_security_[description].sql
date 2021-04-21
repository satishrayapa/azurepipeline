--------------------------------------------------------------------------------------------------------------
--FOR SECURITY DATA SCRIPTS...EXAMPLE...
--Make sure records don't already exists or remove them
--DO NOT FORGET TRANSLATIONs (tmgMessages, tmgPartnerCultureDefinitions)
--------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgForm where FormGUID = 'frdHMFDetailReport_aspx' and Description = 'frdHMFDetailReport_aspx' and SystemTypeID = 2)
BEGIN
	INSERT INTO tmgForm
	SELECT 'frdHMFDetailReport_aspx', 'frdHMFDetailReport_aspx', 2, getdate(), 'N', 'N'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess where GroupGUID = '1002' and FormGUID = 'frdHMFDetailReport_aspx' and AccessType = 2)
BEGIN
	INSERT INTO tmgGroupAccess
	SELECT '1002', 'frdHMFDetailReport_aspx', '2', getdate(), 'N', 'N'
END