DECLARE @MessageTable AS VARCHAR(50) = 'tmgMessages'
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @Value_N AS VARCHAR(1) = 'N'
DECLARE @DismissedGUID AS VARCHAR(50) = 'DismissedToolTip_CCEditor'
DECLARE @DismissedToolTipMessage AS NVARCHAR(MAX) = N'在此页面中的产品已经被审核，用户已确认税则编码无需更新。用户也可以点击撤回键，把产品添加到等待审核的页面。'
------------- Dismissed Tab Tool Tip ---------------
IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @MessageTable
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @DismissedGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @DismissedGUID
			AND CultureGUID = @CultureGUID
	END
	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@DismissedGUID AS [MessageGUID]
			,@DismissedToolTipMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
END