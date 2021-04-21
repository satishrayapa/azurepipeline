DECLARE @tmgMessages AS VARCHAR(50) = 'tmgMessages'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @FieldHdnInstructions1 AS VARCHAR(128) = 'hdnInstructions_CCManager'
DECLARE @FieldHdnInstructions2 AS VARCHAR(128) = 'hdnInstructions2_CCManager'
DECLARE @FieldHdnInstructions3 AS VARCHAR(128) = 'hdnInstructions3_CCManager'


DECLARE @TranslationHdnInstructions1 AS NVARCHAR(128) = N'通过点击章节，子章节进行扩展页面，将会显示出所有的税则编号。'
DECLARE @TranslationHdnInstructions2 AS NVARCHAR(128) = N'对于包含有效税则编码的产品，用户可以在税则更新页面对此税则编码进行变更。用户可以更新此产品的税则编码，也可以选择忽略此产品。'
DECLARE @TranslationHdnInstructions3 AS NVARCHAR(128) = N'部分税则更新可能不会影响到您存在主数据库中的产品。如果点击确认此产品税则不会改变，与此税则相关的产品将从税则更新管理页面消失。'


IF EXISTS (
        SELECT TOP 1 *
        FROM INFORMATION_SCHEMA.COLUMNS
        WHERE table_name =  @tmgMessages
        )
BEGIN
    IF EXISTS (
            SELECT TOP 1 [MessageGUID]
            FROM tmgMessages
            WHERE [MessageGUID] = @FieldHdnInstructions1
                AND CultureGUID = @CultureGUID
            )
    BEGIN
        DELETE
        FROM tmgMessages
        WHERE [MessageGUID] = @FieldHdnInstructions1
            AND CultureGUID = @CultureGUID
    END


    INSERT INTO tmgMessages
    SELECT PartnerId AS [PartnerId]
        ,@EffDate AS [EffDate]
        ,@CultureGUID AS [CultureGUID]
        ,@FieldHdnInstructions1 AS [MessageGUID]
        ,@TranslationHdnInstructions1 AS [Message]
        ,@Value_N AS [DeletedFlag]
        ,@Value_N AS [KeepDuringRollback]
    FROM tmgPartnerDataConnection
    GROUP BY PartnerId
    ---
    IF EXISTS (
            SELECT TOP 1 [MessageGUID]
            FROM tmgMessages
            WHERE [MessageGUID] = @FieldHdnInstructions2
                AND CultureGUID = @CultureGUID
            )
    BEGIN
        DELETE
        FROM tmgMessages
        WHERE [MessageGUID] = @FieldHdnInstructions2
            AND CultureGUID = @CultureGUID
    END


    INSERT INTO tmgMessages
    SELECT PartnerId AS [PartnerId]
        ,@EffDate AS [EffDate]
        ,@CultureGUID AS [CultureGUID]
        ,@FieldHdnInstructions2 AS [MessageGUID]
        ,@TranslationHdnInstructions2 AS [Message]
        ,@Value_N AS [DeletedFlag]
        ,@Value_N AS [KeepDuringRollback]
    FROM tmgPartnerDataConnection
    GROUP BY PartnerId
    --
    IF EXISTS (
            SELECT TOP 1 [MessageGUID]
            FROM tmgMessages
            WHERE [MessageGUID] = @FieldHdnInstructions3
                AND CultureGUID = @CultureGUID
            )
    BEGIN
        DELETE
        FROM tmgMessages
        WHERE [MessageGUID] = @FieldHdnInstructions3
            AND CultureGUID = @CultureGUID
    END


    INSERT INTO tmgMessages
    SELECT PartnerId AS [PartnerId]
        ,@EffDate AS [EffDate]
        ,@CultureGUID AS [CultureGUID]
        ,@FieldHdnInstructions3 AS [MessageGUID]
        ,@TranslationHdnInstructions3 AS [Message]
        ,@Value_N AS [DeletedFlag]
        ,@Value_N AS [KeepDuringRollback]
    FROM tmgPartnerDataConnection
    GROUP BY PartnerId


END











