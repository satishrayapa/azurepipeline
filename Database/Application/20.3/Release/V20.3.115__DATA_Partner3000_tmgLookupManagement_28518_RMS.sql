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
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'tmgLookupManagement' --Your Table Here
			AND Type = 'U'
		)
BEGIN
	DECLARE @SearchLookupxml AS XML

	SELECT @SearchLookupxml = Queries
	FROM tmgLookupManagement
	WHERE LookupProductIdentifier = 2
		AND LookupCategoryIdentifier = 71

	IF (
			SELECT @SearchLookupxml.exist('(grids/grid[name="Products With Extract Queue"])')
			) = 1
	BEGIN
		SET @SearchLookupxml.modify('replace value of (grids/grid[sqlguid="afef7b6f-936d-4887-8d3e-d4a9ad836c50"]/name/text())[1] with "Products in Outbound Interface Queue"')

		UPDATE tmgLookupManagement
		SET Queries = @SearchLookupxml
		WHERE LookupCategoryIdentifier IN (
				SELECT LookupCategoryIdentifier
				FROM tmgLookupProducts p
				JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
				WHERE LookupProductName = 'Global Classification'
					AND LookupCategoryName = 'Search/Reporting'
				)
	END
END

END

