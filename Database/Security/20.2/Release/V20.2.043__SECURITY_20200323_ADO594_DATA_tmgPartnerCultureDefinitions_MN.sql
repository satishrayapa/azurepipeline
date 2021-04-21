DECLARE @PartnerId AS INT = NULL;

DELETE
FROM tmgPartnerCultureDefinitions
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND FieldName = 'hyxlnkExit'

INSERT INTO tmgPartnerCultureDefinitions
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'hyxlnkExit'
	,N'Saída'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
