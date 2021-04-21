DECLARE @PartnerId As integer = null;

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'hyxlnkManageSearchesNew_Tooltip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'hyxlnkManageSearchesNew_Tooltip'
	,N'Administrar pesquisas'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)	
