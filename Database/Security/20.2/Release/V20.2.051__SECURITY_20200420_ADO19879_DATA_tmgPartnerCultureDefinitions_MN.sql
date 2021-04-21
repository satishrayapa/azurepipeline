DECLARE @PartnerId AS INTEGER = NULL;

DELETE
FROM tmgPartnerCultureDefinitions
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND FieldName = 'lbxBackToTop'

INSERT INTO tmgPartnerCultureDefinitions
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'lbxBackToTop'
	,N'De volta ao topo'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)