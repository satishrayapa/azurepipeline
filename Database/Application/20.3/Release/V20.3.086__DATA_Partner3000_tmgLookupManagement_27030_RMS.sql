DECLARE @CorrectBaselineDB AS VARCHAR(50)
SET @CorrectBaselineDB = 'IP_3000_BASELINE'

DECLARE @CorrectProductionDB AS VARCHAR(50)
SET @CorrectProductionDB = 'IP_3000'

DECLARE @CorrectQADB AS VARCHAR(50)
SET @CorrectQADB = 'IP_3000_QA_Baseline'

DECLARE @CurrentDB AS VARCHAR(50)
SET @CurrentDB = (Select db_name())


IF (@CurrentDB IN (@CorrectProductionDB, @CorrectQADB, @CorrectBaselineDB))
BEGIN
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgLookupManagement' --Your Table Here
			AND Type = 'U')
BEGIN	

DECLARE @CustomerRequestLookupsxml AS XML, @FTALookupXML AS XML

SELECT @CustomerRequestLookupsxml = Queries
FROM tmgLookupManagement
WHERE LookupProductIdentifier = 8
	AND LookupCategoryIdentifier = 233

IF (
		SELECT @CustomerRequestLookupsxml.exist('(grids/grid[name="Active Customer Requests"])')
		) = 1
BEGIN
	SET @CustomerRequestLookupsxml.modify('replace value of (grids/grid[name="Active Customer Requests"]/use_biblioteca/text())[1] with "Y"')

	UPDATE tmgLookupManagement
	SET Queries = @CustomerRequestLookupsxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'Customer Request Lookups'
			)
END

IF (
		SELECT @CustomerRequestLookupsxml.exist('(grids/grid[name="Customer Request Completion Rate"])')
		) = 1


BEGIN
		SET @CustomerRequestLookupsxml.modify('replace value of (grids/grid[name="Customer Request Completion Rate"]/use_biblioteca/text())[1] with "Y"')

	UPDATE tmgLookupManagement
	SET Queries = @CustomerRequestLookupsxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'Customer Request Lookups'
			)
END

SELECT @FTALookupXML = Queries
FROM tmgLookupManagement
		WHERE LookupProductIdentifier = 8
			AND LookupCategoryIdentifier = 89
IF (
		SELECT @FTALookupXML.exist('(grids/grid[name="Certificates Lookup"])')
		) = 1

BEGIN

	SET @FTALookupXML.modify('replace value of (grids/grid[name="Certificates Lookup"]/use_biblioteca/text())[1] with "Y"')
	
	UPDATE tmgLookupManagement
	SET Queries = @FTALookupXML
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'FTA'
			)
END

IF (
		SELECT @FTALookupXML.exist('(grids/grid[name="Certificates: Due to Expire"])')
		) = 1

BEGIN

SET @FTALookupXML.modify('replace value of (grids/grid[name="Certificates: Due to Expire"]/use_biblioteca/text())[1] with "Y"')

	UPDATE tmgLookupManagement
	SET Queries = @FTALookupXML
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'FTA'
			)
END

END
END


