DECLARE @MessageTable AS VARCHAR(50) = 'tmgMessages'
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @AuditLogGUID AS VARCHAR(50) = 'AuditLogToolTip_CCEditor'
DECLARE @AuditLogToolTipMessage AS NVARCHAR(50) = N'此页面显示所有税则更新历史记录。'

------------- Pending Tab Tool Tip ---------------

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @MessageTable
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @AuditLogGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @AuditLogGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@AuditLogGUID AS [MessageGUID]
			,@AuditLogToolTipMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
END

