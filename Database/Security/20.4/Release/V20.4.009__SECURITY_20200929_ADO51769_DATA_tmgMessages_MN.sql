DECLARE @PartnerId AS INTEGER = NULL;

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'en-US'
	AND MessageGuid = 'chxbxSelectAll_Tooltip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'en-US'
	,'chxbxSelectAll_Tooltip'
	,N'Select All'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'en-US'
	AND MessageGuid = 'chxbxSearchTypeADDCVD_ToolTip'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'en-US'
	,'chxbxSearchTypeADDCVD_ToolTip'
	,N'Include ADD/CVD Search Result'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'en-US'
	AND MessageGuid = 'SearchDetail_PageTitle'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'en-US'
	,'SearchDetail_PageTitle'
	,N'Advanced Search'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
