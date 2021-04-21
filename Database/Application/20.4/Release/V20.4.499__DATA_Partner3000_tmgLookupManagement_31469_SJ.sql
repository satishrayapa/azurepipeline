
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
  
  -- update the indexes for DPS lookup for Search/Reporting category

IF EXISTS (
		SELECT TOP 1 1
		FROM tmgLookupManagement WITH(NOLOCK)
		WHERE LookupProductIdentifier = 6
			AND LookupCategoryIdentifier = 80
		)
BEGIN


DECLARE @updatedxml AS XML ='
<grids run_record_counts_synchronous="N" show_global_tariffs="N" show_globe_icon="N" show_create_request="N" show_new="N">
  <grid dock_identifier="dae0d2e8-d9a5-4ec6-ae3d-0a04714aab89" active="Y" index="1">
		<name>DPS Lookup</name>
		<sqlguid>2bf48c36-3a3b-4228-a989-5e3a9a3223ed</sqlguid>
		<tooltip></tooltip>
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
	</grid>
  <grid dock_identifier="828f8e56-8db8-4204-b6a7-4188247e36a4" active="Y" index="2">
    <name>Percent of DPS Statuses</name>
    <sqlguid>03808ed6-f20c-4550-ad59-380bf472e320</sqlguid>
    <tooltip>Displays the number and percentage of parties in DPS for each status (blocked, clear, not screened) </tooltip>
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
  </grid>
  <grid dock_identifier="d88a0653-0f66-4ba8-b356-ad55c043bafd" active="Y" index="3">
    <name>Hits per Company Partner</name>
    <sqlguid>f62c8dcb-b571-4835-ab8f-7e1797f0c22b</sqlguid>
    <tooltip></tooltip>
    <use_biblioteca>Y</use_biblioteca>
    <client_specific_fields></client_specific_fields>
    <allow_extract>Y</allow_extract>
    <extract_sqlguid></extract_sqlguid>
    <record_count>
      <use>Y</use>
      <sqlguid></sqlguid>
    </record_count>
    <dropdown>
      <show>Y</show>
      <default>30</default>
      <sqlguid>da43a0b6-e499-4b3b-8898-dfbfca3a17f1</sqlguid>
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
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="1542d068-ec69-4df3-b5ba-351a8e1f5f28" active="Y" index="4">
		<name>Number of Hits per Month</name>
		<sqlguid>bf71bc09-d413-4998-ba08-abf32d0ca859</sqlguid>
		<tooltip>This query shows the total number of hits, across all company partners, broken down by Year and Month.</tooltip>
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
		</visible_groups>
		<exclude_from_extract>
			<column>Edit</column>
		</exclude_from_extract>
		<columns>
			<bound_column column_identifier="111bd870-2f50-4a85-b2f3-f29a85e76716" column_index="1" dropdown_value="Default">
				<headertext>Year</headertext>
				<allowfiltering>Y</allowfiltering>
				<allowsorting>Y</allowsorting>
				<datafield>Year</datafield>
				<dataformatstring></dataformatstring>
			</bound_column>
			<bound_column column_identifier="f46cc63a-f5cd-4802-a2a4-b8cd5a5e88b6" column_index="2" dropdown_value="Default">
				<headertext>Month</headertext>
				<allowfiltering>Y</allowfiltering>
				<allowsorting>Y</allowsorting>
				<datafield>Month</datafield>
				<dataformatstring></dataformatstring>
			</bound_column>
			<bound_column column_identifier="7316a264-8468-4d6a-b6b5-c531ba07b03b" column_index="3" dropdown_value="Default">
				<headertext>TotalHits</headertext>
				<allowfiltering>Y</allowfiltering>
				<allowsorting>Y</allowsorting>
				<datafield>TotalHits</datafield>
				<dataformatstring></dataformatstring>
			</bound_column>
		</columns>
	</grid>
</grids>'


UPDATE tmgLookupManagement set Queries =@updatedxml WHERE LookupProductIdentifier=6 and LookupCategoryIdentifier =80


END

END