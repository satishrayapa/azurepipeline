DECLARE @MessageTable AS VARCHAR(50) = 'tmgMessages'
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @PendingGUID AS VARCHAR(50) = 'PendingToolTip_CCEditor'
DECLARE @PendingToolTipMessage AS NVARCHAR(100) = N'在此页面中的产品将会被审核。新的税则编号可能在未来被更改。用户在点击采用新的税则编码后，此产品的税则编码将会更新到相对应产品的主数据库中。'

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
			WHERE [MessageGUID] = @PendingGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @PendingGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@PendingGUID AS [MessageGUID]
			,@PendingToolTipMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
END

