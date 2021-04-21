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


