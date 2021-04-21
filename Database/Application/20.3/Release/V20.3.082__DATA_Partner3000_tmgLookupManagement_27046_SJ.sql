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

Declare @BOMxml as XML,@Solicitationxml as XML
SELECT @BOMxml=Queries  FROM   tmgLookupManagement  
Where  LookupProductIdentifier = 8 and LookupCategoryIdentifier = 231

SELECT @Solicitationxml=Queries  FROM   tmgLookupManagement  
WHERE LookupProductIdentifier = 8
	AND LookupCategoryIdentifier = 232

IF (SELECT @BOMxml.exist('(grids/grid[name="BOM Lookup"])'))=1
BEGIN

SET @BOMxml.modify('replace value of (/grids/grid[name="BOM Lookup"]/use_biblioteca/text())[1]
        with "Y"
    ')

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



IF (SELECT @BOMxml.exist('(grids/grid[name="BOM: Components Due to Expire"])'))=1
BEGIN
SET @BOMxml.modify('replace value of (/grids/grid[name="BOM: Components Due to Expire"]/use_biblioteca/text())[1]
        with "Y"
    ')

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



IF (SELECT @BOMxml.exist('(grids/grid[name="BOM: Components with New Certificates"])'))=1
BEGIN
SET @BOMxml.modify('replace value of (/grids/grid[name="BOM: Components with New Certificates"]/use_biblioteca/text())[1]
        with "Y"
    ')
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





IF (SELECT @BOMxml.exist('(grids/grid[name="BOM: Finished Goods Due to Expire"])'))=1
BEGIN
SET @BOMxml.modify('replace value of (/grids/grid[name="BOM: Finished Goods Due to Expire"]/use_biblioteca/text())[1]
        with "Y"
    ')
	UPDATE tmgLookupManagement
	SET Queries=@BOMxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'BOM Lookups'
			)
END





IF (SELECT @Solicitationxml.exist('(grids/grid[name="Solicitations with Action Required"])'))=1
BEGIN
SET @Solicitationxml.modify('replace value of (/grids/grid[name="Solicitations with Action Required"]/use_biblioteca/text())[1]
        with "Y"
    ')
	UPDATE tmgLookupManagement
	SET Queries=@Solicitationxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'Solicitation Lookups'
			)
END



IF (SELECT @Solicitationxml.exist('(grids/grid[name="Solicitation: Past due"])'))=1
BEGIN
SET @Solicitationxml.modify('replace value of (/grids/grid[name="Solicitation: Past due"]/use_biblioteca/text())[1]
        with "Y"
    ')
	UPDATE tmgLookupManagement
	SET Queries=@Solicitationxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'Solicitation Lookups'
			)
END



IF (SELECT @Solicitationxml.exist('(grids/grid[name="Solicitation Lookup"])'))=1
BEGIN
SET @Solicitationxml.modify('replace value of (/grids/grid[name="Solicitation Lookup"]/use_biblioteca/text())[1]
        with "Y"
    ')
	UPDATE tmgLookupManagement
	SET Queries=@Solicitationxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'Solicitation Lookups'
			)
END


IF (SELECT @Solicitationxml.exist('(grids/grid[name="Active Solicitations"])'))=1
BEGIN
SET @Solicitationxml.modify('replace value of (/grids/grid[name="Active Solicitations"]/use_biblioteca/text())[1]
        with "Y"
    ')
	UPDATE tmgLookupManagement
	SET Queries=@Solicitationxml
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE LookupProductName = 'FTA'
				AND LookupCategoryName = 'Solicitation Lookups'
			)
END



END

END
