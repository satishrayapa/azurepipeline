
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