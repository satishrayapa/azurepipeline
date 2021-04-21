DECLARE @MessageTable AS VARCHAR(50) = 'tmgMessages'
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @NeedsReviewGUID AS VARCHAR(50) = 'NeedsReviewToolTip_CCEditor'
DECLARE @NeedsReviewToolTipMessage AS NVARCHAR(max) = N'税则更新物料更新页面帮助用户周期性管理政府发布的相关税则更新.用户可以通过此页面来管理相关产品的税则变化。 等待审核页面：这些归类的产品可能在未来受到税则更新变化的影响.用户可以更新此产品的税则编码，也可以选择忽略此产品。如果选择忽略此税则更新提示，产品将从此页面中消失。'

------------- Needs Review Tab Tool Tip ---------------

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @MessageTable
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @NeedsReviewGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @NeedsReviewGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@NeedsReviewGUID AS [MessageGUID]
			,@NeedsReviewToolTipMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId

END