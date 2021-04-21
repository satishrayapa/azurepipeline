IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdFieldConfiguration]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF Object_ID('tempdb..#tmdFieldConfiguration') IS NOT NULL DROP TABLE #tmdFieldConfiguration
	Select * into #tmdFieldConfiguration from dbo.tmdFieldConfiguration where 1 = 2

	INSERT INTO #tmdFieldConfiguration(PartnerId,Effdate,ControlGUID,ControlInstanceGUID,FieldName,GroupName,FieldAttributes,DeletedFlag,KeepDuringRollback)
	 select PartnerID, getdate(),'B82FFDE1-E560-4E58-B837-A02A1F3EB7E4','AC9659A7-5413-4548-8A01-0E55C4564992','ModeOfTransport','Transportation Information','<field_configuration>
  <name>ModeOfTransport</name>
  <length>5</length>
  <type>System.String</type>
  <default />
  <column_order>6</column_order>
  <hidden permanent="N" permanent_reason="" value="N" />
  <display_name>Mode Of Transport</display_name>
  <format />
  <required>N</required>
  <disabled permanent="N" permanent_reason="" value="N" />
  <audit>N</audit>
  <group_name>Transportation Information</group_name>
  <disable_calendars>N</disable_calendars>
  <mask />
  <use_time>N</use_time>
  <twenty_four_hour>N</twenty_four_hour>
  <textbox_rows>0</textbox_rows>
  <numeric_type digits="0">Default</numeric_type>
  <url />
  <disabled_groups>Standard Import Read Only Access|</disabled_groups>
  <enabled_groups />
  <hidden_groups />
  <visible_groups />
  <dropdown_type>Search</dropdown_type>
  <selection_query>select Decode,code from tmgCCSCodes where FieldName = ''TransportMode'' and PartnerID = @PartnerID order by CODE asc</selection_query>
  <max_ws_results>-1</max_ws_results>
  <params_query />
  <custom_configuration name="Disabled Status" action="SetDisabled" enabled="N" type="IPRules.ContainsRestriction, IPRules, Version=19.2.0.0, Culture=neutral, PublicKeyToken=null">
    <restriction>
      <operand type="field" value="@Status" />
      <operator>Contains</operator>
      <operand type="constant" value="P" />
    </restriction>
  </custom_configuration>
  <custom_configuration name="Disabled Source" action="SetDisabled" enabled="N" type="IPRules.ContainsRestriction, IPRules, Version=19.2.0.0, Culture=neutral, PublicKeyToken=null">
    <restriction>
      <operand type="field" value="@Source" />
      <operator>Contains</operator>
      <operand type="constant" value="E" />
    </restriction>
  </custom_configuration>
  <custom_configuration name="Disable When Processed" action="SetDisabled" enabled="Y" type="IPRules.Restriction, IPRules, Version=19.2.0.0, Culture=neutral, PublicKeyToken=null">
    <restriction>
      <operand type="field" value="@ProcessedFlag" />
      <operator>Equals</operator>
      <operand type="constant" value="Y" />
    </restriction>
  </custom_configuration>
</field_configuration>','N','N' from tmfDefaults

INSERT INTO #tmdFieldConfiguration(PartnerId,Effdate,ControlGUID,ControlInstanceGUID,FieldName,GroupName,FieldAttributes,DeletedFlag,KeepDuringRollback)
	 select PartnerID, getdate(),'B82FFDE1-E560-4E58-B837-A02A1F3EB7E4','B82FFDE1-E560-4E58-B837-A02A1F3EB7E4','ModeOfTransport','Transportation Information','<field_configuration>
  <name>ModeOfTransport</name>
  <length>5</length>
  <type>System.String</type>
  <default />
  <column_order>6</column_order>
  <hidden permanent="N" permanent_reason="" value="N" />
  <display_name>Mode Of Transport</display_name>
  <format />
  <required>N</required>
  <disabled permanent="N" permanent_reason="" value="N" />
  <audit>N</audit>
  <group_name>Transportation Information</group_name>
  <disable_calendars>N</disable_calendars>
  <mask />
  <use_time>N</use_time>
  <twenty_four_hour>N</twenty_four_hour>
  <textbox_rows>0</textbox_rows>
  <numeric_type digits="0">Default</numeric_type>
  <url />
  <disabled_groups>Standard Export Read Only Access|</disabled_groups>
  <enabled_groups />
  <hidden_groups />
  <visible_groups />
  <dropdown_type>Search</dropdown_type>
  <selection_query>select Decode,code from tmgCCSCodes where FieldName = ''TransportMode'' and PartnerID = @PartnerID order by CODE asc</selection_query>
  <max_ws_results>-1</max_ws_results>
  <params_query />
  <custom_configuration name="Disabled Status" action="SetDisabled" enabled="N" type="IPRules.ContainsRestriction, IPRules, Version=19.2.0.0, Culture=neutral, PublicKeyToken=null">
    <restriction>
      <operand type="field" value="@Status" />
      <operator>Contains</operator>
      <operand type="constant" value="P" />
    </restriction>
  </custom_configuration>
  <custom_configuration name="Disabled Source" action="SetDisabled" enabled="N" type="IPRules.ContainsRestriction, IPRules, Version=19.2.0.0, Culture=neutral, PublicKeyToken=null">
    <restriction>
      <operand type="field" value="@Source" />
      <operator>Contains</operator>
      <operand type="constant" value="" />
    </restriction>
  </custom_configuration>
  <custom_configuration name="Disable When Processed" action="SetDisabled" enabled="Y" type="IPRules.Restriction, IPRules, Version=19.2.0.0, Culture=neutral, PublicKeyToken=null">
    <restriction>
      <operand type="field" value="@ProcessedFlag" />
      <operator>Equals</operator>
      <operand type="constant" value="Y" />
    </restriction>
  </custom_configuration>
</field_configuration>','N','N' from tmfDefaults
	

	MERGE dbo.tmdFieldConfiguration dt
		USING #tmdFieldConfiguration te
			ON  dt.ControlGUID			= te.ControlGUID
			AND dt.ControlInstanceGUID	= te.ControlInstanceGUID
			AND dt.	FieldName = te.FieldName			
	WHEN MATCHED
			THEN UPDATE SET
				dt.PartnerId		= te.PartnerId,
				dt.	Effdate			= te.Effdate,
				dt.GroupName = te.GroupName,
				dt.FieldAttributes = te.FieldAttributes,
				dt.DeletedFlag = te.DeletedFlag,
				dt.KeepDuringRollback = te.KeepDuringRollback
	WHEN NOT MATCHED BY TARGET
			THEN INSERT (PartnerId,Effdate,ControlGUID,ControlInstanceGUID,FieldName,GroupName,FieldAttributes,DeletedFlag,KeepDuringRollback) 
			VALUES (PartnerId,te.Effdate,te.ControlGUID,te.ControlInstanceGUID,te.FieldName,te.GroupName,te.FieldAttributes,te.DeletedFlag,te.KeepDuringRollback);

	IF OBJECT_ID('tempdb..#tmdFieldConfiguration') IS NOT NULL DROP TABLE #tmdFieldConfiguration
END
