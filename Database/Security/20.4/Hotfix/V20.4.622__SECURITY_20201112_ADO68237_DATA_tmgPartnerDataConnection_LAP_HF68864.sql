
Declare @PartnerId as int = null;
/** tmgPartnerCultureDefinitions
*** Screen Name Translation
*********************************************************************************************************************************/

-------------------------------------------------------------------------------
-- ADO # 68237
-- Adding New Title form names for DODA screens
-- HF #68864
-------------------------------------------------------------------------------

-- *** Work with DODA-PITA ***
-- Clearance
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'Clearance'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'Clearance', N'Clearance', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'Clearance'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'Clearance', N'Despacho', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
-- BadgeNum
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'BadgeNum'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'BadgeNum', N'Badge Num', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'BadgeNum'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'BadgeNum', N'Numero Gafete', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
-- IntegrationNum
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'IntegrationNum'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'IntegrationNum', N'Integration Num', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'IntegrationNum'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'IntegrationNum', N'Número Integración', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
-- *** New DODA-PITA ***
-- lbxClearanceTitle
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxClearanceTitle'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lbxClearanceTitle', N'Clearance', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxClearanceTitle'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'lbxClearanceTitle', N'Despacho', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
-- *** Maintain DODA-PITA ***
-- lbxBadgeNum
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxBadgeNum'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lbxBadgeNum', N'Badge Num', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'lbxBadgeNum'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'lbxBadgeNum', N'Número Gafete', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
