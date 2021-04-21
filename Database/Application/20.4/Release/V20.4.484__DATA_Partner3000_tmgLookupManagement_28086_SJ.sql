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

-- Delete from tmgSQL
IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid='3a29f99a-7a38-4d1e-aa65-81bf5af00d0c'
		)
BEGIN

Delete from tmgSQL  WHERE sqlGuid='3a29f99a-7a38-4d1e-aa65-81bf5af00d0c'

END

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgSQL
		WHERE sqlGuid='aae0dfbd-0948-43d6-82c5-cae681119ac3'
		)
BEGIN

Delete from tmgSQL  WHERE sqlGuid='aae0dfbd-0948-43d6-82c5-cae681119ac3'

END



IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmgLookupManagement' --Your Table Here
			AND Type = 'U')
BEGIN	


Declare @DPSxml as XML
SELECT @DPSxml=Queries  FROM   tmgLookupManagement  
Where  LookupProductIdentifier = 6 and LookupCategoryIdentifier = 80


IF (select @DPSxml.exist('(grids/grid[sqlguid="3a29f99a-7a38-4d1e-aa65-81bf5af00d0c"])'))=1
BEGIN

SET @DPSxml.modify('delete (grids/grid[sqlguid="3a29f99a-7a38-4d1e-aa65-81bf5af00d0c"])')


  UPDATE tmgLookupManagement
   SET  Queries= @DPSxml
     WHERE LookupCategoryIdentifier in 
	 (
	 SELECT LookupCategoryIdentifier from tmgLookupProducts p
JOIN tmgLookupCategories c on c.LookupProductIdentifier=p.LookupProductIdentifier
 Where p.LookupProductName='DPS' AND c.LookupCategoryName ='Search/Reporting'  AND c.PartnerID=3000
	 )


END

IF (select @DPSxml.exist('(grids/grid[sqlguid="aae0dfbd-0948-43d6-82c5-cae681119ac3"])'))=1
BEGIN

SET @DPSxml.modify('delete (grids/grid[sqlguid="aae0dfbd-0948-43d6-82c5-cae681119ac3"])')

 UPDATE tmgLookupManagement
   SET  Queries=@DPSxml
     WHERE LookupCategoryIdentifier in 
	 (
	 SELECT LookupCategoryIdentifier from tmgLookupProducts p
JOIN tmgLookupCategories c on c.LookupProductIdentifier=p.LookupProductIdentifier
 Where p.LookupProductName='DPS' AND c.LookupCategoryName ='Search/Reporting'  AND c.PartnerID=3000
	 )

END


--Move sections from Search/Reporting to Audit
--Insert sections into the Audit
IF EXISTS (
		SELECT TOP 1 1
		FROM tmgLookupManagement
		WHERE LookupProductIdentifier = 6
			AND LookupCategoryIdentifier = 24
		)
BEGIN
	

 DECLARE @ClearPartiesData XML,@BlockedPartiesData XML

SET @ClearPartiesData = '<grid dock_identifier="8af9614d-47e1-4a74-ae80-efbe7d198559" active="Y" index="6">
    <name>Clear Parties</name>
    <sqlguid>1e0d0bb2-730b-418a-8a61-ab8b4a7e435c</sqlguid>
    <tooltip>Displays all parties that have a status of Clear</tooltip>
    <use_biblioteca>Y</use_biblioteca>
    <client_specific_fields></client_specific_fields>
    <allow_extract>Y</allow_extract>
    <extract_sqlguid></extract_sqlguid>
    <record_count>
      <use>Y</use>
      <sqlguid></sqlguid>
    </record_count>
    <dropdown>
      <show>N</show>
      <default></default>
      <sqlguid></sqlguid>
      <values />
    </dropdown>
    <pagination>
      <use>Y</use>
      <throttle>N</throttle>
      <filter_limit></filter_limit>
      <orderby_expression>NoOrder</orderby_expression>
    </pagination>
    <chart>
      <use>N</use>
      <type></type>
      <yaxis_title></yaxis_title>
    </chart>
    <visible_groups>
      <group>IP Full Access Group</group>
      <group>Standard Client DPS Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>'

  SET @BlockedPartiesData=' <grid dock_identifier="d88a0b72-4b7d-415e-883d-784c71380d63" active="Y" index="7">
    <name>Blocked Parties</name>
    <sqlguid>7b7dc548-b62b-4c55-bcde-675e2ba72876</sqlguid>
    <tooltip>Displays all parties that have a status of Blocked</tooltip>
    <use_biblioteca>Y</use_biblioteca>
    <client_specific_fields></client_specific_fields>
    <allow_extract>Y</allow_extract>
    <extract_sqlguid></extract_sqlguid>
    <record_count>
      <use>Y</use>
      <sqlguid></sqlguid>
    </record_count>
    <dropdown>
      <show>N</show>
      <default></default>
      <sqlguid></sqlguid>
      <values />
    </dropdown>
    <pagination>
      <use>Y</use>
      <throttle>N</throttle>
      <filter_limit></filter_limit>
      <orderby_expression>NoOrder</orderby_expression>
    </pagination>
    <chart>
      <use>N</use>
      <type></type>
      <yaxis_title></yaxis_title>
    </chart>
    <visible_groups>
      <group>IP Full Access Group</group>
      <group>Standard Client DPS Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>'


  UPDATE tmgLookupManagement
   SET  Queries.modify('insert sql:variable("@ClearPartiesData") as last into /grids[1]')
     WHERE LookupCategoryIdentifier in 
	 (
	 SELECT LookupCategoryIdentifier from tmgLookupProducts p
JOIN tmgLookupCategories c on c.LookupProductIdentifier=p.LookupProductIdentifier
 Where p.LookupProductName='DPS' AND c.LookupCategoryName ='Audit'  AND c.PartnerID=3000
	 )


	  UPDATE tmgLookupManagement
   SET  Queries.modify('insert sql:variable("@BlockedPartiesData") as last into /grids[1]')
     WHERE LookupCategoryIdentifier in 
	 (
	 SELECT LookupCategoryIdentifier from tmgLookupProducts p
JOIN tmgLookupCategories c on c.LookupProductIdentifier=p.LookupProductIdentifier
 Where p.LookupProductName='DPS' AND c.LookupCategoryName ='Audit'  AND c.PartnerID=3000
	 )

	 

END


IF (select @DPSxml.exist('(grids/grid[name="Clear Parties"])'))=1
BEGIN

SET @DPSxml.modify('delete (grids/grid[name="Clear Parties"])')

	 
  UPDATE tmgLookupManagement
   SET  Queries=@DPSxml
     WHERE LookupCategoryIdentifier in 
	 (
	 SELECT LookupCategoryIdentifier from tmgLookupProducts p
JOIN tmgLookupCategories c on c.LookupProductIdentifier=p.LookupProductIdentifier
 Where p.LookupProductName='DPS' AND c.LookupCategoryName ='Search/Reporting'  AND c.PartnerID=3000
	 )

	 

END

IF (select @DPSxml.exist('(grids/grid[name="Blocked Parties"])'))=1
BEGIN

SET @DPSxml.modify('delete (grids/grid[name="Blocked Parties"])')

 UPDATE tmgLookupManagement
   SET  Queries= @DPSxml
     WHERE LookupCategoryIdentifier in 
	 (
	 SELECT LookupCategoryIdentifier from tmgLookupProducts p
JOIN tmgLookupCategories c on c.LookupProductIdentifier=p.LookupProductIdentifier
 Where p.LookupProductName='DPS' AND c.LookupCategoryName ='Search/Reporting'  AND c.PartnerID=3000
	 )

END



--update all biblioteca flags to Y for DPS lookups
IF EXISTS (
		SELECT TOP 1 1
		FROM tmgLookupManagement
		WHERE LookupProductIdentifier = 6
		)
BEGIN

 UPDATE tmgLookupManagement
 SET Queries = REPLACE(CAST(Queries AS NVARCHAR(MAX)), '<use_biblioteca>N</use_biblioteca>', '<use_biblioteca>Y</use_biblioteca>')
 WHERE tmgLookupManagement.LookupProductIdentifier in (select LookupProductIdentifier from tmgLookupProducts where LookupProductName = 'DPS')


END



END


END


