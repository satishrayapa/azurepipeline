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

Declare @BOMxml as XML
SELECT @BOMxml=Queries  FROM   tmgLookupManagement  
Where  LookupProductIdentifier = 8 and LookupCategoryIdentifier = 231
IF (
		SELECT @BOMxml.exist('(grids/grid[name="BOM: Missing Info"])')
		) = 1
BEGIN
    SET  @BOMxml.modify('replace value of (grids/grid[name="BOM: Missing Info"]/use_biblioteca/text())[1] with "Y"')
	UPDATE tmgLookupManagement
	SET Queries= @BOMxml	
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'BOM Lookups'
			)
END

IF (
		SELECT @BOMxml.exist('(grids/grid[name="BOM: Analysis Results"])')
		) = 1
BEGIN
	SET  @BOMxml.modify('replace value of (grids/grid[name="BOM: Analysis Results"]/use_biblioteca/text())[1] with "Y"')														
	UPDATE tmgLookupManagement
	SET Queries= @BOMxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'BOM Lookups'
			)
END

IF (
		SELECT @BOMxml.exist('(grids/grid[name="BOM: By Status"])')
		) = 1
BEGIN
	SET  @BOMxml.modify('replace value of (grids/grid[name="BOM: By Status"]/use_biblioteca/text())[1] with "Y"')													  
	UPDATE tmgLookupManagement
	SET Queries= @BOMxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'BOM Lookups'
			)
END

IF  (
		SELECT @BOMxml.exist('(grids/grid[name="BOMs Without Analysis"])')
		) = 1
BEGIN
	SET  @BOMxml.modify('replace value of (grids/grid[name="BOMs Without Analysis"]/use_biblioteca/text())[1] with "Y"')			  
	UPDATE tmgLookupManagement
	SET Queries= @BOMxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'BOM Lookups'
			)
END

END
END