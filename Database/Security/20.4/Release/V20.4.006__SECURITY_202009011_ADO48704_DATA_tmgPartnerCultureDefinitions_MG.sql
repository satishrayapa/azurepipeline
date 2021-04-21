Declare @PartnerId as int = null;

/**tmgMessages**/
/*********************************************************************************************************************************/
delete from tmgMessages  Where (PartnerId = @PartnerId Or @PartnerId Is Null) and CultureGuid = 'en-US' and MessageGuid = 'SmartHSAutoClass_NoSubscription'
insert into tmgMessages  select PartnerId, getDate(), 'en-US', 'SmartHSAutoClass_NoSubscription', N'Your Partner does not have a subscription for the Smart HS functionality. Please contact your System Administrator.', 'N', 'N' From tmgPartnerDataConnection (nolock) Where (PartnerId = @PartnerId Or @PartnerId Is Null)
