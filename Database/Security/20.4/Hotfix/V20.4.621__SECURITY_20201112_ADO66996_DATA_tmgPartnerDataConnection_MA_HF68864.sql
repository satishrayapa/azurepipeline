
Declare @PartnerId as int = null;
/** tmgPartnerCultureDefinitions
*** Screen Name Translation
*********************************************************************************************************************************/

-------------------------------------------------------------------------------
-- ADO # 66996
-- Adding New Title form names for DODA screens
-- V21.1.009__SECURITY_20201112_ADO66996_DATA_tmgPartnerDataConnection_MA.sql
-- HF: 68864
-------------------------------------------------------------------------------


delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'fxdMXDODA_aspx'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'fxdMXDODA_aspx', N'DODA/PITA', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'fxdMXDODAInvoiceSelection_aspx'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'fxdMXDODAInvoiceSelection_aspx', N'DODA/PITA Invoice Selection', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'fxdMXMaintainDODA_aspx	'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'fxdMXMaintainDODA_aspx	', N'Maintain DODA/PITA', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)




delete from tmgPartnerCultureDefinitions  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'fxdMXDODA_aspx'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'fxdMXDODA_aspx', N'DODA/PITA', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'fxdMXDODAInvoiceSelection_aspx'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'fxdMXDODAInvoiceSelection_aspx', N'DODA/PITA Selección de Facturas', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'fxdMXMaintainDODA_aspx	'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'fxdMXMaintainDODA_aspx	', N'Mantenimiento DODA/PITA', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)


