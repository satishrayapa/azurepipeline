DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @FieldTabName AS VARCHAR(128) = 'Changes_CCM'
DECLARE @TranslationTabName AS NVARCHAR(128) = N'更改'

IF EXISTS (
        SELECT TOP 1 *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_name =  @tmgPartnerCultureDefinitions
        )
BEGIN
    IF EXISTS (
            SELECT TOP 1 [FieldName]
            FROM tmgPartnerCultureDefinitions
            WHERE [FieldName] = @FieldTabName
                AND CultureGUID = @CultureGUID
            )
    BEGIN
        DELETE
        FROM tmgPartnerCultureDefinitions
        WHERE [FieldName] = @FieldTabName
            AND CultureGUID = @CultureGUID
    END


    INSERT INTO tmgPartnerCultureDefinitions
    SELECT PartnerId AS [PartnerId]
        ,@EffDate AS [EffDate]
        ,@CultureGUID AS [CultureGUID]
        ,@FieldTabName AS [FieldName]
        ,@TranslationTabName AS [FieldTranslation]
        ,@Value_N AS [DeletedFlag]
        ,@Value_N AS [KeepDuringRollback]
    FROM tmgPartnerDataConnection
    GROUP BY PartnerId
END