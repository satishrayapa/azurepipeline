Declare @PartnerId as int = null;

/**tmgMessages**/
/*********************************************************************************************************************************/
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'InFilterPopup_FilterWarning'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'InFilterPopup_FilterWarning', N'Total number of filters cannot exceed {0}.', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'InFilterPopup_ClearAllFilters'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'InFilterPopup_ClearAllFilters', N'Are you sure you want to clear all applied filters from the list?', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'InFilterPopup_rwProdNumFilter'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'InFilterPopup_rwProdNumFilter', N'Product Number Filter', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

/**tmgPartnerCultureDefinitions**/
/*********************************************************************************************************************************/
delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxProdNumFilterInstructions'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lbxProdNumFilterInstructions', N'Add a new line for each product number to filter.', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lnxbtnClearAllProdFilters'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lnxbtnClearAllProdFilters', N'Clear All', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lnxbtnAddProdFilter'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lnxbtnAddProdFilter', N'+', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lnxbtnRemoveProdFilter'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lnxbtnRemoveProdFilter', N'-', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lbxTotalItemCountText'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lbxTotalItemCountText', N'Filter list item count: ', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lnxbtnApplyProdNumFilter'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lnxbtnApplyProdNumFilter', N'Search', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)

delete from tmgPartnerCultureDefinitions Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and FieldName = 'lnxbtnCancelProdNumFilter'
insert into tmgPartnerCultureDefinitions  select PartnerId, getDate(), 'en-US', 'lnxbtnCancelProdNumFilter', N'Cancel', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)