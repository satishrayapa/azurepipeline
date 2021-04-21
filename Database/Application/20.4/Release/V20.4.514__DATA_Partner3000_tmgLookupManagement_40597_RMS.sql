
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
		IF EXISTS (
				SELECT TOP 1 1
				FROM tmgLookupManagement
				WHERE LookupProductIdentifier = '4'
					AND LookupCategoryIdentifier = '77' --Licenses
				)
		BEGIN
			--Update Licenses category
			UPDATE tmgLookupManagement
			SET Queries = 
				'<grids run_record_counts_synchronous="N" show_global_tariffs="N" show_globe_icon="N" show_create_request="N" show_new="N">
  <grid dock_identifier="152f375b-461d-4cf1-9b1a-6b755aee0b01" active="Y" index="1">
    <name>Exports With License Required</name>
    <sqlguid>6754f933-0d24-4c59-90e2-535bd72db918</sqlguid>
    <tooltip>Displays all of the shipments which require licensing.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="e34eb379-97b4-4c87-a840-a825ca40e454" active="Y" index="2">
    <name>License May Be Required</name>
    <sqlguid>c43387f4-cb76-45cc-a84a-040ca5197e32</sqlguid>
    <tooltip>Displays the shipments that require licensing.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="ba5c8545-603b-41a2-b0f0-bed0c9e4434e" active="Y" index="3">
    <name>Licensable Shipments</name>
    <sqlguid>333b819d-fbba-40a5-ac43-39027a5b5cc2</sqlguid>
    <tooltip>Displays all of the shipments that have been processed and require licensing.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
</grids>'
			WHERE LookupProductIdentifier = '4'
				AND LookupCategoryIdentifier = '77' --Licenses
		END

		IF EXISTS (
				SELECT TOP 1 1
				FROM tmgLookupManagement
				WHERE LookupProductIdentifier = '4'
					AND LookupCategoryIdentifier = '72' --Search and Reporting 
				)
		BEGIN
			--Update Search and Reporting category
			UPDATE tmgLookupManagement
			SET Queries = 
				'<grids run_record_counts_synchronous="N" show_global_tariffs="N" show_globe_icon="N" show_create_request="N" show_new="N">
  <grid dock_identifier="e5700c6f-32bb-4fc6-8def-97aaf637c495" active="Y" index="10">
    <name>Shipments Processed Today</name>
    <sqlguid>cb340c75-a1a6-4f9c-924e-4c6ba2cb4f0a</sqlguid>
    <tooltip>Displays all shipments that have been processed on the current day.  </tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="0eb77319-6fc4-403b-8bc0-0c2999f63a8a" active="Y" index="9">
    <name>Request to Ship Date KPI</name>
    <sqlguid>3b5f7a82-97c6-42cb-af83-90ae77dad245</sqlguid>
    <tooltip>Displays all shipments along with differences between the requested date and the ship date.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="bdea59e8-2329-47e4-a1ee-21bd6efbe09b" active="Y" index="8">
    <name>Domestic Shipments</name>
    <sqlguid>3d45c253-e11f-428c-92a0-ef8366396d34</sqlguid>
    <tooltip>Displays shipments where the ImportCountry is the same as the ExportCountry.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns>
      <bound_column column_identifier="095e0ea7-7795-48c4-bcb0-ab21e5132395" column_index="1" dropdown_value="Default">
        <headertext>Edit</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>Edit</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="7e0018e6-9e9b-4d4b-b015-66f87f696a77" column_index="2" dropdown_value="Default">
        <headertext>OrderNumShip</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>OrderNumShip</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="73ec3c29-4cda-44ee-893e-78e82774cdfe" column_index="3" dropdown_value="Default">
        <headertext>Status</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>Status</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="81b94700-5dda-48f8-880e-db2b340bf26b" column_index="4" dropdown_value="Default">
        <headertext>ShipmentRefNum</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ShipmentRefNum</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <date_column column_identifier="87fe48bc-b25d-4a3f-b198-06e82a21faaa" column_index="5" dropdown_value="Default">
        <headertext>ShipDate</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ShipDate</datafield>
        <remove_time_stamp>Y</remove_time_stamp>
      </date_column>
      <date_column column_identifier="47d15b1a-984f-4f40-b5bb-41206a66dcab" column_index="6" dropdown_value="Default">
        <headertext>ExportDate</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ExportDate</datafield>
        <remove_time_stamp>Y</remove_time_stamp>
      </date_column>
      <bound_column column_identifier="309ce8d4-5ac7-4bb4-9c44-a0ac4f48c5f2" column_index="7" dropdown_value="Default">
        <headertext>ExportCountry</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ExportCountry</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="2230976a-02fe-41e5-b919-c82d190808dd" column_index="8" dropdown_value="Default">
        <headertext>ImportCountry</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ImportCountry</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <numeric_column column_identifier="b3031d73-8aae-4f5f-9017-947a28b890fe" column_index="9" dropdown_value="Default">
        <headertext>NoOrder</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>NoOrder</datafield>
      </numeric_column>
      <numeric_column column_identifier="312707ba-cea7-4c88-ba45-e68b0da6413a" column_index="10" dropdown_value="Default">
        <headertext>RowNum</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>RowNum</datafield>
      </numeric_column>
    </columns>
  </grid>
  <grid dock_identifier="1c3c21c9-144e-4c84-af5a-df895449da79" active="Y" index="7">
    <name>Voided Shipments</name>
    <sqlguid>837ee233-fb26-4e5c-83da-f4d019a945da</sqlguid>
    <tooltip>Displays the shipments that have been voided.  </tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="6c5746db-9632-4e59-b32c-5d19108440c4" active="Y" index="6">
    <name>Finalized Shipments</name>
    <sqlguid>704a868c-d986-4d6e-890a-87423deebb5a</sqlguid>
    <tooltip>Displays the shipments that have been finalized.  </tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="acd3ea77-c336-4a2e-beb4-7bb7d5f7be56" active="Y" index="4">
    <name>Exports With Denied Parties</name>
    <sqlguid>c14dd075-8951-4bd9-b98c-bfefff83f426</sqlguid>
    <tooltip>Displays shipments that have a denied party associated to them.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="047f1819-92e2-4610-8818-f6c5e0a2320c" active="Y" index="3">
    <name>Hold Messages by Count</name>
    <sqlguid>d4edbafe-6d89-4268-b764-94b14ec1e7a3</sqlguid>
    <tooltip>Displays the number of times that a hold has been issued and the reason why it was issued.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract />
    <columns />
  </grid>
  <grid dock_identifier="14b2c5e8-ac6b-490e-ad3b-c1b24be0b401" active="Y" index="2">
    <name>All Export Hold Messages</name>
    <sqlguid>2b07e450-c321-4a80-82b9-712defa584a5</sqlguid>
    <tooltip>Displays all of the shipments which have hold messages assigned to them.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="634bc0f7-33bd-4463-94d7-bdefb3e8dc2a" active="Y" index="1">
    <name>Export Lookup</name>
    <sqlguid>f0405e73-a1f7-4e09-9c3b-a97d5e76c6ce</sqlguid>
    <tooltip>Displays all export transactions.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <hyperlink_column column_identifier="b893c69c-4f00-44fb-8fde-360dd8ffc028" column_index="1" dropdown_value="Default">
        <headertext>Edit</headertext>
        <allowfiltering>N</allowfiltering>
        <allowsorting>N</allowsorting>
        <dockfield></dockfield>
        <statictext>Edit</statictext>
        <target></target>
        <urlformatstring>/Export/fidExportCISLI.aspx?TYPE=E&amp;ExportGuid={0}</urlformatstring>
        <urlfields>ExportGuid</urlfields>
      </hyperlink_column>
      <bound_column column_identifier="e1c601f8-9fa8-4fcd-b20f-541edaa9091a" column_index="2" dropdown_value="Default">
        <headertext>OrderNumShip</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>OrderNumShip</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="ad4a0b22-9d5b-49b1-ac77-194dd0af9628" column_index="3" dropdown_value="Default">
        <headertext>Status</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>Status</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="ee7b6fb4-ff56-4133-8073-4d2961bedb2b" column_index="4" dropdown_value="Default">
        <headertext>Export Date</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ExportDate</datafield>
        <dataformatstring>{0:d}</dataformatstring>
      </bound_column>
    </columns>
  </grid>
  <grid dock_identifier="5f050c9e-edd3-4cc8-b283-c23a831b05a1" active="Y" index="11">
    <name>Shipments Exceeding $2,500</name>
    <sqlguid>1dbad088-4044-489c-b734-5e9d48ce509b</sqlguid>
    <tooltip></tooltip>
    <use_biblioteca>N</use_biblioteca>
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
    <exclude_from_extract />
    <columns />
  </grid>
  <grid dock_identifier="1436fbae-3422-4d32-84de-c2e82f0af906" active="Y" index="19">
    <name>Processed Shipments by User</name>
    <sqlguid>c2e3b4f9-2338-4e16-9eab-66b3818a5f74</sqlguid>
    <tooltip></tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract />
    <columns />
  </grid>
  <grid dock_identifier="e1850a15-4c93-4251-b653-dcedeb3e6974" active="Y" index="17">
    <name>Shipments With Process Overrides</name>
    <sqlguid>b7c06947-0135-4bdc-b264-3d7016ad770f</sqlguid>
    <tooltip>Displays the shipments which were originally put on hold but have been overridden by the user. </tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="f00e2d79-88b2-4a99-90f3-c41a82403e16" active="Y" index="5">
    <name>Processed Shipments</name>
    <sqlguid>0d082f57-1614-45b0-a385-65ad788a2bf2</sqlguid>
    <tooltip>Displays the shipments that have been processed. 
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="47aea5a1-cdd2-49b6-add4-0bfa604c782d" active="Y" index="16">
    <name>Count Of Exports By Country Pairing</name>
    <sqlguid>27a65e7e-8b07-42c8-888d-7db41f5fe428</sqlguid>
    <tooltip>Displays the number of exports for previously observed country pairings.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract />
    <columns />
  </grid>
  <grid dock_identifier="ceb47c59-952a-40e2-8dcc-13a272b19d32" active="Y" index="15">
    <name>Count Of Exports By Carrier</name>
    <sqlguid>2ddfb8db-e07f-4210-9c25-05a24da73f93</sqlguid>
    <tooltip>Displays the number of times the previously used carriers have been used.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="e4aeee33-ebe5-43d9-8db0-faa028a0bdcf" active="Y" index="14">
    <name>All Export Messages By Shipment</name>
    <sqlguid>81f3dead-b16f-4d78-846b-5a386bdd2d55</sqlguid>
    <tooltip>Displays the shipements that have system messages associated to them.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="24c1730b-2aea-42b2-a580-ce8928414f15" active="Y" index="13">
    <name>Shipments With Related Ultimate Consignee</name>
    <sqlguid>ff1c36ee-fa59-4879-be7e-dadf09f247e8</sqlguid>
    <tooltip>Displays the shipments with an ultimate consignee who has an indicated relationship to the client.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="5f4b5036-1f7e-423f-9532-f846ea8f3bf6" active="Y" index="12">
    <name>Exports with Non-EAR99 Products</name>
    <sqlguid>96766873-6ac1-4dd4-87d2-1ebdc5b59036</sqlguid>
    <tooltip>Displays all of the shipments which do not contain items categorized under EAR99.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="3ad69e03-1140-41e9-a625-77ca3cf1c5cc" active="Y" index="18">
    <name>Shipments Processed in the Last 7,30,90 days</name>
    <sqlguid>3afae6c9-68a8-46f9-9c91-bdf2815779da</sqlguid>
    <tooltip></tooltip>
    <use_biblioteca>N</use_biblioteca>
    <client_specific_fields></client_specific_fields>
    <allow_extract>Y</allow_extract>
    <extract_sqlguid></extract_sqlguid>
    <record_count>
      <use>Y</use>
      <sqlguid></sqlguid>
    </record_count>
    <dropdown>
      <show>Y</show>
      <default>7</default>
      <sqlguid>2529546d-5f80-446b-8240-d965cba9df36</sqlguid>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns>
      <hyperlink_column column_identifier="2fa1d5ea-4274-4ad1-b36e-fc4f149fc087" column_index="1" dropdown_value="Default">
        <headertext>Edit</headertext>
        <allowfiltering>N</allowfiltering>
        <allowsorting>N</allowsorting>
        <dockfield></dockfield>
        <statictext>Edit</statictext>
        <target></target>
        <urlformatstring>/Export/fidExportCISLI.aspx?TYPE=E&amp;ExportGuid={0}</urlformatstring>
        <urlfields>ExportGuid</urlfields>
      </hyperlink_column>
      <bound_column column_identifier="9148c2ad-69ef-4a3e-a943-c317d8e1511c" column_index="2" dropdown_value="Default">
        <headertext>InvoiceNum</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>InvoiceNum</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="9d6551d9-0e55-4a31-837e-3d6f9c11b734" column_index="3" dropdown_value="Default">
        <headertext>Status</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>Status</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="be97aa0d-63d7-4da0-b89d-19f749627e3d" column_index="4" dropdown_value="Default">
        <headertext>ProcessedDate</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ProcessedDate</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
    </columns>
  </grid>
</grids>'
			WHERE LookupProductIdentifier = '4'
				AND LookupCategoryIdentifier = '72' --Search and Reporting 
		END

		IF EXISTS (
				SELECT TOP 1 1
				FROM tmgLookupManagement
				WHERE LookupProductIdentifier = '4'
					AND LookupCategoryIdentifier = '76' --ActionRequired
				)
		BEGIN
			--Update ActionRequired category
			UPDATE tmgLookupManagement
			SET Queries = 
				'<grids run_record_counts_synchronous="N" show_global_tariffs="N" show_globe_icon="N" show_create_request="N" show_new="N">
  <grid dock_identifier="b4382323-3718-46ff-bdce-58cbb2122a26" active="Y" index="3">
    <name>Shipments With Products Not In Global Classification</name>
    <sqlguid>c66b01f4-2662-4728-a000-687495fb2e02</sqlguid>
    <tooltip>Displays the shipments that contain products which are not stored in Global Classification.</tooltip>
    <use_biblioteca>N</use_biblioteca>
    <client_specific_fields></client_specific_fields>
    <allow_extract>Y</allow_extract>
    <extract_sqlguid></extract_sqlguid>
    <record_count>
      <use>Y</use>
      <sqlguid></sqlguid>
    </record_count>
    <dropdown>
      <show>Y</show>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="4678a087-cdae-4eac-9646-e59b43d699da" active="Y" index="1">
    <name>All Shipments On Hold</name>
    <sqlguid>ac9a627a-ff70-4d2e-9b31-174b1135f794</sqlguid>
    <tooltip>Displays all of the Shipements that are currently on Hold.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="be602b5a-55fa-4e6b-83cd-887d5dd477f6" active="Y" index="2">
    <name>Denied Parties Hold</name>
    <sqlguid>69a8f10e-78e3-4087-9834-654adc7f5642</sqlguid>
    <tooltip>Displays all of the shipments that have been put on hold.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid> 
  <grid dock_identifier="e81e80fa-ea59-4b5f-a1b0-e87e73ed75af" active="Y" index="8">
    <name>Exports On Hold Within 5 Days of ExportDate</name>
    <sqlguid>00f53a58-e099-46a4-8e8b-bdbd1eee946c</sqlguid>
    <tooltip>Displays the shipments which are within 5 days of their scheduled export date, but are on hold.
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="b1028427-c414-42db-8627-beaea40b7057" active="Y" index="7">
    <name>Shipments Missing Compliance Data</name>
    <sqlguid>2e970280-bba4-49ee-bf5d-539c1b043a52</sqlguid>
    <tooltip>Displays the shipments that contain product that are missing their ECNNum, their ExportTarriffNum, or their CountryOfOrigin. 
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="5bd04bff-9f87-415b-b6bb-dc5c32653681" active="Y" index="6">
    <name>Missing Product Numbers</name>
    <sqlguid>b9b764cc-36ac-48a7-88f2-f4d076b4f003</sqlguid>
    <tooltip>Displays shipments that have products missing product numbers.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="d9ccb7c0-2c17-4d85-8bb3-a1a1c510c2c8" active="Y" index="5">
    <name>Missing ECN</name>
    <sqlguid>93beabb3-bed0-438a-8518-4ddf06f527ea</sqlguid>
    <tooltip>Displays the shipments that have products missing their ECN number.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="473aa19f-d6ae-4ed2-8604-5182f300dbe1" active="Y" index="4">
    <name>Missing Export Tariff</name>
    <sqlguid>d6be8e80-99a5-4506-a748-dbd2c9331fdf</sqlguid>
    <tooltip>Displays the shipements that are missing their export tariff number.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
<grid dock_identifier="3f33c05e-3c4f-4e2b-b1ce-0ba152a12f4f" active="Y" index="9">
    <name>Export Shipments Without Corresponding QP</name>
    <sqlguid>85cef7be-2ed9-4a12-a52b-3fc6f17ed87f</sqlguid>
    <tooltip>Displays the shipments that have been filed as bonded shipments in the Export Management module, but do not have a corresponding shipment in the QP module. 
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract />
    <columns />
  </grid>
  <grid dock_identifier="984b0d33-d4e7-495b-a39d-f851e347a42a" active="Y" index="10">
    <name>QP Shipments Without Corresponding Export Shipment</name>
    <sqlguid>00cf4f44-7cf2-4734-89a4-37da34d69a08</sqlguid>
    <tooltip>Displays the shipments that have been filed as bonded shipments in the QP module, but do not have a corresponding shipment in the Export Management module. 
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract />
    <columns />
  </grid>
 <grid dock_identifier="e59778e3-e391-468f-a2d6-9c33bad0a8b7" active="Y" index="11">
    <name>Duplicate Transactions</name>
    <sqlguid>25480f2e-5b87-460f-8971-698f93d7a12d</sqlguid>
    <tooltip>Displays the shipments that have duplicate records as well as the number of duplications.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
</grids>'
			WHERE LookupProductIdentifier = '4'
				AND LookupCategoryIdentifier = '76' --ActionRequired 
		END

		IF EXISTS (
				SELECT TOP 1 1
				FROM tmgLookupManagement
				WHERE LookupProductIdentifier = '4'
					AND LookupCategoryIdentifier = '78' --Declaration Filing
				)
		BEGIN
			--Update Declaration Filing category
			UPDATE tmgLookupManagement
			SET Queries = 
				'<grids run_record_counts_synchronous="N" show_global_tariffs="N" show_globe_icon="N" show_create_request="N" show_new="N">
  <grid dock_identifier="738da701-5e0c-4246-9f81-281aa6b07f21" active="Y" index="2">
    <name>Shipments Approaching Filing Deadline</name>
    <sqlguid>b2aab4fd-27a6-46fc-8bc4-c9bada344e40</sqlguid>
    <tooltip>Displays shipments that are approaching their export date.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="b3bc099a-bb94-4931-ae63-b2f198c31fcc" active="Y" index="6">
    <name>All AES Messages by Shipment</name>
    <sqlguid>ea5b9a8f-eb0c-4bce-9eba-3c0c65acdd96</sqlguid>
    <tooltip></tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="c5d791db-d3ae-4641-a408-c78c40c14384" active="Y" index="1">
    <name>AES Filings</name>
    <sqlguid>7f70ffaf-3f3b-42d7-b6d8-88d05fdf494c</sqlguid>
    <tooltip>Displays shipments that have been filed with AES and contains the relevant information about AES filings.
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="e2cf17d3-4091-4a5d-9eaa-5408e1996479" active="Y" index="4">
    <name>Accepted Shipments Without ECS Date</name>
    <sqlguid>8bd5a2ef-df05-474b-a9ff-ce6b1e26a968</sqlguid>
    <tooltip>Displays the shipments which have not been put on hold and do not have an ECS date.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="e703cefd-69c6-44ff-8e71-fadaf4b557e6" active="Y" index="3">
    <name>AES Transmissions Today</name>
    <sqlguid>d74730e1-ab11-4991-a405-f31cdf5868a7</sqlguid>
    <tooltip>Displays the shipments that have been processed by AES on the current day.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
  <grid dock_identifier="07cb18c4-68d3-47f1-a2cf-4c3d9e6ded2c" active="Y" index="5">
    <name>AES Transmissions Within Last 7,30,90 Days</name>
    <sqlguid>94248d42-d1b0-4700-96e4-da8e4c1cb6fa</sqlguid>
    <tooltip></tooltip>
    <use_biblioteca>N</use_biblioteca>
    <client_specific_fields></client_specific_fields>
    <allow_extract>Y</allow_extract>
    <extract_sqlguid></extract_sqlguid>
    <record_count>
      <use>Y</use>
      <sqlguid></sqlguid>
    </record_count>
    <dropdown>
      <show>Y</show>
      <default>7</default>
      <sqlguid>2529546d-5f80-446b-8240-d965cba9df36</sqlguid>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns>
      <hyperlink_column column_identifier="11e66be9-4b67-4862-a994-d42a793b0752" column_index="1" dropdown_value="Default">
        <headertext>Edit</headertext>
        <allowfiltering>N</allowfiltering>
        <allowsorting>N</allowsorting>
        <dockfield></dockfield>
        <statictext>Edit</statictext>
        <target></target>
        <urlformatstring>/Export/fidExportCISLI.aspx?TYPE=E&amp;ExportGuid={0}</urlformatstring>
        <urlfields>ExportGuid</urlfields>
      </hyperlink_column>
      <bound_column column_identifier="c97d7fcd-bb38-4b71-8660-f2e30c79d9e3" column_index="2" dropdown_value="Default">
        <headertext>InvoiceNum</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>InvoiceNum</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="1da88dc7-b006-4622-95ac-bc895f132613" column_index="3" dropdown_value="Default">
        <headertext>Status</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>Status</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
      <bound_column column_identifier="97fc98c8-4543-4954-a986-6764be4355c9" column_index="4" dropdown_value="Default">
        <headertext>ProcessedDate</headertext>
        <allowfiltering>Y</allowfiltering>
        <allowsorting>Y</allowsorting>
        <datafield>ProcessedDate</datafield>
        <dataformatstring></dataformatstring>
      </bound_column>
    </columns>
  </grid>
  <grid dock_identifier="d76e0a89-e8b7-4334-a58c-07197416beef" active="Y" index="7">
    <name>Fatally Rejected EEI Filings</name>
    <sqlguid>f9db24ed-b6c1-4de8-b6f6-7f0ae3b9eaa4</sqlguid>
    <tooltip>Displays the shipments which have been rejected in their final dispositions.  
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
<grid dock_identifier="fe232a40-b09a-4b06-8781-fbefc7b57571" active="Y" index="8">
    <name>AES Exports Within 5 Days and No ITN</name>
    <sqlguid>508254b9-cd75-466c-9cae-7bc43834555c</sqlguid>
    <tooltip>Displays the shipments within 5 days of the export date and do not yet have their ITN number.
</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
<grid dock_identifier="205c3c2d-2a51-41d2-940c-8a9c7a3feec9" active="Y" index="9">
    <name>Processed AES Filings With No ITN</name>
    <sqlguid>6bdb9e34-fa0c-4aab-8258-cf1d880aff44</sqlguid>
    <tooltip>Displays the shipments have been processed in AES but have no ITN numbers.</tooltip>
    <use_biblioteca>N</use_biblioteca>
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
      <group>Standard Client Export Full Access</group>
    </visible_groups>
    <exclude_from_extract>
      <column>Edit</column>
    </exclude_from_extract>
    <columns />
  </grid>
</grids>'
			WHERE LookupProductIdentifier = '4'
				AND LookupCategoryIdentifier = '78' --Declaration Filing
		END
	END

END