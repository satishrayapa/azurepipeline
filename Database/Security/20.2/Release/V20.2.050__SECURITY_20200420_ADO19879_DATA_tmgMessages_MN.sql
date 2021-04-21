DECLARE @PartnerId AS INTEGER = NULL;

DELETE
FROM tmgMessages
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'Filter'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'Filter'
	,N'Filtrar'
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
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'HeaderText_Charge Description'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'HeaderText_Charge Description'
	,N'Descrição do cargo'
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
	AND MessageGuid = 'expcol... (Show Full Description)'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'en-US'
	,'expcol... (Show Full Description)'
	,N' ... (Show Full Description)'
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
	AND CultureGuid = 'es-MX'
	AND MessageGuid = 'expcol... (Show Full Description)'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'es-MX'
	,'expcol... (Show Full Description)'
	,N'… (Mostrar Descripción Completa)'
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
	AND CultureGuid = 'fr-FR'
	AND MessageGuid = 'expcol... (Show Full Description)'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'fr-FR'
	,'expcol... (Show Full Description)'
	,N' ... (Afficher la Description Complète)'
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
	AND CultureGuid = 'ru-RU'
	AND MessageGuid = 'expcol... (Show Full Description)'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'ru-RU'
	,'expcol... (Show Full Description)'
	,N'... (Показать Полное Описание)'
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
	AND CultureGuid = 'pt-PT'
	AND MessageGuid = 'expcol... (Show Full Description)'

INSERT INTO tmgMessages
SELECT PartnerId
	,getDate()
	,'pt-PT'
	,'expcol... (Show Full Description)'
	,N' ... (Mostrar Descrição Completa)'
	,'N'
	,'N'
FROM tmgPartnerDataConnection(NOLOCK)
WHERE (
		PartnerId = @PartnerId
		OR @PartnerId IS NULL
		)
