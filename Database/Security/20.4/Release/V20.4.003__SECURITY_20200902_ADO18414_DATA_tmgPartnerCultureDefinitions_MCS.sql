Declare @PartnerId as int = null;
/** tmgPartnerCultureDefinitions
*** Screen Name Translation
*********************************************************************************************************************************/
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'SmartHSAutoClassifier_aspx'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'SmartHSAutoClassifier_aspx', N'Smart HS Classification', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'es-MX' and FieldName = 'SmartHSAutoClassifier_aspx'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'es-MX', 'SmartHSAutoClassifier_aspx', N'Clasificación Inteligente de Fracción Arancelaria', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)