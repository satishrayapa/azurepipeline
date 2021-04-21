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
	DECLARE  @FTALookupXML AS XML,@SolicitationXML AS XML
	SELECT @FTALookupXML = Queries
	FROM tmgLookupManagement
	WHERE LookupProductIdentifier = 8 AND LookupCategoryIdentifier = 89
	SELECT @SolicitationXML = Queries
	FROM tmgLookupManagement
	WHERE LookupProductIdentifier = 8	AND LookupCategoryIdentifier = 232
	IF (
			SELECT @FTALookupXML.exist('(grids/grid[name="FTA Lookup"])')
			) = 1
	BEGIN
		SET @FTALookupXML.modify('replace value of (grids/grid[name="FTA Lookup"]/use_biblioteca/text())[1] with "Y"')											
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
	IF  (								
			SELECT @FTALookupXML.exist('(grids/grid[name="FTA Records: By Agreement"])')
			) = 1
	BEGIN
		SET @FTALookupXML.modify('replace value of (grids/grid[name="FTA Records: By Agreement"]/use_biblioteca/text())[1] with "Y"')											 
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
	IF(										
			SELECT @FTALookupXML.exist('(grids/grid[name="FTA Records: By Plant"])')
			) = 1		
	BEGIN
		SET @FTALookupXML.modify('replace value of (grids/grid[name="FTA Records: By Plant"]/use_biblioteca/text())[1] with "Y"')															
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
			SELECT @FTALookupXML.exist('(grids/grid[name="FTA Records: Set to Expire"])')
			) = 1
	BEGIN
		SET @FTALookupXML.modify('replace value of (grids/grid[name="FTA Records: Set to Expire"]/use_biblioteca/text())[1] with "Y"')	   
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
			SELECT @SolicitationXML.exist('(grids/grid[name="Solicitation: Outstanding Products"])')
			) = 1
	BEGIN
		SET @SolicitationXML.modify('replace value of (grids/grid[name="Solicitation: Outstanding Products"]/use_biblioteca/text())[1] with "Y"')
		UPDATE tmgLookupManagement
		SET Queries = @SolicitationXML
		WHERE LookupCategoryIdentifier IN (
				SELECT LookupCategoryIdentifier
				FROM tmgLookupProducts p
				JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
				WHERE LookupProductName = 'FTA'
					AND LookupCategoryName = 'Solicitation Lookups'
				)
	END
	IF (									 
			SELECT @SolicitationXML.exist('(grids/grid[name="Solicitation: New Comments"])')
			) = 1
	BEGIN
		SET @SolicitationXML.modify('replace value of (grids/grid[name="Solicitation: New Comments"]/use_biblioteca/text())[1] with "Y"')
		UPDATE tmgLookupManagement
		SET Queries = @SolicitationXML
		WHERE LookupCategoryIdentifier IN (
				SELECT LookupCategoryIdentifier
				FROM tmgLookupProducts p
				JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
				WHERE LookupProductName = 'FTA'
					AND LookupCategoryName = 'Solicitation Lookups'
				)
	END
	IF (								 
			SELECT @SolicitationXML.exist('(grids/grid[name="Solicitation: Available Products"])') 
			) = 1
	BEGIN
		SET @SolicitationXML.modify('replace value of (grids/grid[name="Solicitation: Available Products"]/use_biblioteca/text())[1] with "Y"')
		UPDATE tmgLookupManagement
		SET Queries = @SolicitationXML
		WHERE LookupCategoryIdentifier IN (
				SELECT LookupCategoryIdentifier
				FROM tmgLookupProducts p
				JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
				WHERE LookupProductName = 'FTA'
					AND LookupCategoryName = 'Solicitation Lookups'
				)
	END
	IF (									 
			SELECT @SolicitationXML.exist('(grids/grid[name="Solicitation: Invalid Products"])')
			) = 1
	BEGIN
		SET @SolicitationXML.modify('replace value of (grids/grid[name="Solicitation: Invalid Products"]/use_biblioteca/text())[1] with "Y"')
		UPDATE tmgLookupManagement
		SET Queries = @SolicitationXML
		WHERE LookupCategoryIdentifier IN (
				SELECT LookupCategoryIdentifier
				FROM tmgLookupProducts p
				JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
				WHERE LookupProductName = 'FTA'
					AND LookupCategoryName = 'Solicitation Lookups'
				)
	END
	IF (									 
			SELECT @SolicitationXML.exist('(grids/grid[name="Solicitation Response Rate"])')
			) = 1
	BEGIN
		SET @SolicitationXML.modify('replace value of (grids/grid[name="Solicitation Response Rate"]/use_biblioteca/text())[1] with "Y"')
		UPDATE tmgLookupManagement
		SET Queries = @SolicitationXML
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