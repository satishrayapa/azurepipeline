DECLARE @tmgMessages AS VARCHAR(50) = 'tmgMessages'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @zhCNCultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @AuditLogTooltip AS VARCHAR(128) = 'INSTRUCTIONS_AL_CCManager'
DECLARE @AuditLogTooltip_Translation AS NVARCHAR(128) = N'此页面显示所有税则更新历史记录。'

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgMessages
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @AuditLogTooltip
				AND CultureGUID = @zhCNCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE [MessageGUID] = @AuditLogTooltip
			AND CultureGUID = @zhCNCultureGUID
	END

	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@zhCNCultureGUID AS [CultureGUID]
		,@AuditLogTooltip AS [MessageGUID]
		,@AuditLogTooltip_Translation AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

END