
declare @baselinePartner as int = 3000

-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------
declare @isBaseline as bit = 0
declare @isBaselineTemp as varchar(30) = '${isBaseline}' --flyway will pass in for AWS when creating a new partner database

if not @isBaselineTemp = '$' + '{isBaseline}' and not @isBaselineTemp = '0' --either flyway passes 1 or we fallback to on-prem way of looking for 3000
	set @isBaseline = @isBaselineTemp
else
begin
	--on-prem we create new partners from 3000 so lets check for that

    --if there is only one defaults record and it is for 3000
    if exists (select TOP 1 1 from sys.tables where Name = 'tmfDefaults' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmfDefaults where partnerID = @base and not exists (select top 1 1 from tmfDefaults where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
       
    --based on db_name (ie IP_3000 or IP_3000_REG)
    if @isBaseline = 0
            select @isBaseline = case when DB_NAME() like '%[_]' + cast(@baselinePartner as varchar(10)) or DB_NAME() like '%[_]'+ cast(@baselinePartner as varchar(10)) +'[_]%' then 1 else 0 end
       
    --if there is only one security record and it is for 3000
    if @isBaseline = 0 and exists (select TOP 1 1 from sys.tables where Name = 'tmgPartnerDataConnection' AND Type = 'U') 
            exec sp_executesql N'select @isBaseline = count(*) from tmgPartnerDataConnection where partnerID = @base and not exists (select top 1 1 from tmgPartnerDataConnection where partnerID <> @base)', 
                    N'@isBaseline int output, @base int', @isBaseline output, @base = @baselinePartner;
end
-------------------boiler plate tests to determine if this is for baseline, do not change-----------------------


IF @isBaseline = 1
BEGIN
    PRINT 'running script for baseline'
  
  -- Delete from tmgSQL
IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = '9cee5c33-0bc1-402b-ad9a-debda32f3bde'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = '9cee5c33-0bc1-402b-ad9a-debda32f3bde'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = 'f94548f6-0c62-495b-885c-8fc278f4541c'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = 'f94548f6-0c62-495b-885c-8fc278f4541c'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = 'fb8185fb-39fd-42f8-9f33-20154f2fef6b'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = 'fb8185fb-39fd-42f8-9f33-20154f2fef6b'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = '0fbf1ec4-9cdf-463f-93f0-796464d62a21'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = '0fbf1ec4-9cdf-463f-93f0-796464d62a21'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = 'bde2cd82-b52f-4f21-8536-03fde2220518'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = 'bde2cd82-b52f-4f21-8536-03fde2220518'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = '2cceeb60-fadc-4bba-a15e-fec0d65a98c7'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = '2cceeb60-fadc-4bba-a15e-fec0d65a98c7'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = '71932eee-3568-41cb-9513-355aca90fa01'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = '71932eee-3568-41cb-9513-355aca90fa01'
END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid = '815dcf7e-e034-4dc4-8434-4726d8f8e7c6'
		)
BEGIN
	DELETE
	FROM tmgSQL
	WHERE sqlGuid = '815dcf7e-e034-4dc4-8434-4726d8f8e7c6'
END

--Delete Docks from the tmgLookupManagement
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgLookupManagement' --Your Table Here
			AND Type = 'U')
BEGIN
DECLARE @AuditLookupsxml AS XML
	,@ClassificationLookupXML AS XML
	,@SearchLookupXML AS XML

SELECT @AuditLookupsxml = Queries
FROM tmgLookupManagement
WHERE LookupProductIdentifier = 2
	AND LookupCategoryIdentifier = 12

IF (
		SELECT @AuditLookupsxml.exist('(grids/grid[sqlguid="9cee5c33-0bc1-402b-ad9a-debda32f3bde"])')
		) = 1
BEGIN
	SET @AuditLookupsxml.modify('delete (grids/grid[sqlguid="9cee5c33-0bc1-402b-ad9a-debda32f3bde"])')

	UPDATE tmgLookupManagement
	SET Queries = @AuditLookupsxml 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Audit'
				AND c.PartnerID = 3000
			)
END

IF (
		SELECT @AuditLookupsxml.exist('(grids/grid[sqlguid="f94548f6-0c62-495b-885c-8fc278f4541c"])')
		) = 1
BEGIN
	SET @AuditLookupsxml.modify('delete (grids/grid[sqlguid="f94548f6-0c62-495b-885c-8fc278f4541c"])')

	UPDATE tmgLookupManagement
	SET Queries = @AuditLookupsxml 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Audit'
				AND c.PartnerID = 3000
			)
END

IF (
		SELECT @AuditLookupsxml.exist('(grids/grid[sqlguid="fb8185fb-39fd-42f8-9f33-20154f2fef6b"])')
		) = 1
BEGIN
	SET @AuditLookupsxml.modify('delete (grids/grid[sqlguid="fb8185fb-39fd-42f8-9f33-20154f2fef6b"])')

	UPDATE tmgLookupManagement
	SET Queries = @AuditLookupsxml 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Audit'
				AND c.PartnerID = 3000
			)
END

IF (
		SELECT @AuditLookupsxml.exist('(grids/grid[sqlguid="0fbf1ec4-9cdf-463f-93f0-796464d62a21"])')
		) = 1
BEGIN
	SET @AuditLookupsxml.modify('delete (grids/grid[sqlguid="0fbf1ec4-9cdf-463f-93f0-796464d62a21"])')

	UPDATE tmgLookupManagement
	SET Queries = @AuditLookupsxml 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Audit'
				AND c.PartnerID = 3000
			)
END

SELECT @ClassificationLookupXML = Queries
FROM tmgLookupManagement
WHERE LookupProductIdentifier = 2
	AND LookupCategoryIdentifier = 14

IF (
		SELECT @ClassificationLookupXML.exist('(grids/grid[sqlguid="bde2cd82-b52f-4f21-8536-03fde2220518"])')
		) = 1
BEGIN
	SET @ClassificationLookupXML.modify('delete (grids/grid[sqlguid="bde2cd82-b52f-4f21-8536-03fde2220518"])')

	UPDATE tmgLookupManagement
	SET Queries = @ClassificationLookupXML 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Missing or Inaccurate Classification'
				AND c.PartnerID = 3000
			)
END

SELECT @SearchLookupXML = Queries
FROM tmgLookupManagement
WHERE LookupProductIdentifier = 2
	AND LookupCategoryIdentifier = 71

IF (
		SELECT @SearchLookupXML.exist('(grids/grid[sqlguid="2cceeb60-fadc-4bba-a15e-fec0d65a98c7"])')
		) = 1
BEGIN
	SET @SearchLookupXML.modify('delete (grids/grid[sqlguid="2cceeb60-fadc-4bba-a15e-fec0d65a98c7"])')

	UPDATE tmgLookupManagement
	SET Queries = @SearchLookupXML 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Search/Reporting'
				AND c.PartnerID = 3000
			)
END

IF (
		SELECT @SearchLookupXML.exist('(grids/grid[sqlguid="815dcf7e-e034-4dc4-8434-4726d8f8e7c6"])')
		) = 1
BEGIN
	SET @SearchLookupXML.modify('delete (grids/grid[sqlguid="815dcf7e-e034-4dc4-8434-4726d8f8e7c6"])')

	UPDATE tmgLookupManagement
	SET Queries = @SearchLookupXML 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Search/Reporting'
				AND c.PartnerID = 3000
			)
END

IF (
		SELECT @SearchLookupXML.exist('(grids/grid[sqlguid="71932eee-3568-41cb-9513-355aca90fa01"])')
		) = 1
BEGIN
	SET @SearchLookupXML.modify('delete (grids/grid[sqlguid="71932eee-3568-41cb-9513-355aca90fa01"])')

	UPDATE tmgLookupManagement
	SET Queries = @SearchLookupXML 
	WHERE LookupCategoryIdentifier IN (
			SELECT LookupCategoryIdentifier
			FROM tmgLookupProducts p
			JOIN tmgLookupCategories c ON c.LookupProductIdentifier = p.LookupProductIdentifier
			WHERE p.LookupProductName = 'Global Classification'
				AND c.LookupCategoryName = 'Search/Reporting'
				AND c.PartnerID = 3000
			)
END

--SET biblioteca flag to Y 
IF EXISTS (
		SELECT TOP 1 1
		FROM tmgLookupManagement
		WHERE LookupProductIdentifier = 2
		)
BEGIN
	UPDATE tmgLookupManagement
	SET Queries = REPLACE(CAST(Queries AS NVARCHAR(MAX)), '<use_biblioteca>N</use_biblioteca>', '<use_biblioteca>Y</use_biblioteca>')
	WHERE tmgLookupManagement.LookupProductIdentifier IN (
			SELECT LookupProductIdentifier
			FROM tmgLookupProducts
			WHERE LookupProductName = 'Global Classification'
				AND PartnerID = 3000
			)
END

END

END