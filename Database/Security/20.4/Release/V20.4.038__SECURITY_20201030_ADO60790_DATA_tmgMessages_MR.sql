DECLARE @PartnerId AS INTEGER = NULL;

DELETE FROM tmgMessages WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL) AND CultureGuid = 'en-US' AND MessageGuid = 'rgdCountryControls_NoMasterRecordsText'
INSERT INTO tmgMessages SELECT PartnerId, getDate(), 'en-US', 'rgdCountryControls_NoMasterRecordsText', N'There are no Country Controls to display', 'N', 'N' FROM tmgPartnerDataConnection(NOLOCK) WHERE (PartnerId = @PartnerId OR @PartnerId IS NULL)



