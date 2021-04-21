
DECLARE @FieldName_Req AS NVARCHAR(max) = '_ReqFieldText'
DECLARE @LikeFieldName_Req AS NVARCHAR(max) = '%_ReqFieldText'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @FieldName_Empty AS NVARCHAR(max) = '_EmptyFieldText'
DECLARE @LikeFieldName_Empty AS NVARCHAR(max) = '%_EmptyFieldText'
DECLARE @PartnerCultureDefinitionTable AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @cultureEN AS VARCHAR(10) = 'en-US'
DECLARE @cultureCN AS VARCHAR(10) = 'zh-CN'


IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @PartnerCultureDefinitionTable
		)
BEGIN
	INSERT INTO tmgPartnerCultureDefinitions
	SELECT  PartnerId
		,@EffDate AS [EffDate]
		,CultureGUID
		,@FieldName_Empty AS FieldName
		,FieldTranslation
		,DeletedFlag
		,KeepDuringRollback
	FROM tmgPartnerCultureDefinitions
	WHERE FieldName LIKE @LikeFieldName_Empty
		AND FieldName <> @FieldName_Empty
		AND CultureGUID NOT IN (
			@cultureEN
			,@cultureCN
			)
				group by
			 PartnerId,CultureGUID,FieldTranslation,DeletedFlag,KeepDuringRollback

	INSERT INTO tmgPartnerCultureDefinitions
	SELECT  PartnerId
		,@EffDate AS [EffDate]
		,CultureGUID
		,@FieldName_Req AS FieldName
		,FieldTranslation
		,DeletedFlag
		,KeepDuringRollback
	FROM tmgPartnerCultureDefinitions
	WHERE FieldName LIKE @LikeFieldName_Req
		AND FieldName <> @FieldName_Req
		AND CultureGUID NOT IN (
			@cultureEN
			,@cultureCN
			)
			group by
			 PartnerId,CultureGUID,FieldTranslation,DeletedFlag,KeepDuringRollback
			
END

