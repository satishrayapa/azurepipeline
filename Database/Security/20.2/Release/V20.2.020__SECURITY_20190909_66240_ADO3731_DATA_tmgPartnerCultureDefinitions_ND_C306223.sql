
DECLARE @tmgPartnerCultureDefinitions AS VARCHAR(50) = 'tmgPartnerCultureDefinitions'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @template AS VARCHAR(128) = 'Template'
DECLARE @template_Translation AS NVARCHAR(128) = N'模板'


IF EXISTS (
              SELECT TOP 1 *
              FROM INFORMATION_SCHEMA.COLUMNS
              WHERE table_name = @tmgPartnerCultureDefinitions
              )
BEGIN
       IF EXISTS (
                     SELECT TOP 1 [FieldName]
                     FROM tmgPartnerCultureDefinitions
                     WHERE [FieldName] = @template
                           AND CultureGUID = @zhCNCultureGUID
                     )
       BEGIN
              DELETE
              FROM tmgPartnerCultureDefinitions
              WHERE [FieldName] = @template
                     AND CultureGUID = @zhCNCultureGUID
       END

       INSERT INTO tmgPartnerCultureDefinitions
       SELECT PartnerId AS [PartnerId]
              ,@EffDate AS [EffDate]
              ,@zhCNCultureGUID AS [CultureGUID]
              ,@template AS [FieldName]
              ,@template_Translation AS [FieldTranslation]
              ,@Value_N AS [DeletedFlag]
              ,@Value_N AS [KeepDuringRollback]
       FROM tmgPartnerDataConnection
       GROUP BY PartnerId

END
