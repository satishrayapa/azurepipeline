DECLARE @MessageTable AS VARCHAR(50) = 'tmgMessages'
DECLARE @CultureGUID AS VARCHAR(50) = 'zh-CN'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @TariffGUID AS VARCHAR(50) = 'HeaderText_Tariff'
DECLARE @TariffMessage AS NVARCHAR(50) = N'税则'

DECLARE @DPSGUID AS VARCHAR(50) = 'HeaderText_Denied Party Screening'
DECLARE @DPSMessage AS NVARCHAR(50) = N'黑名单检索'

DECLARE @ECNGUID AS VARCHAR(50) = 'HeaderText_ECN/ML'
DECLARE @ECNMessage AS NVARCHAR(50) = N'ECN说明'

DECLARE @ExchangeRateGUID AS VARCHAR(50) = 'HeaderText_Exchange Rates'
DECLARE @ExchangeRateMessage AS NVARCHAR(50) = N'汇率'

DECLARE @WCONOTESGUID AS VARCHAR(50) = 'HeaderText_WCO Notes'
DECLARE @WCONOTESMessage AS NVARCHAR(50) = N'WCO注释'

DECLARE @BindingRulingsGUID AS VARCHAR(50) = 'HeaderText_Binding Rulings'
DECLARE @BindingRulingsMessage AS NVARCHAR(50) = N'归类裁决'

-------------1. HeaderText_Tariff ---------------

IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name =  @MessageTable
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @TariffGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @TariffGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@TariffGUID AS [MessageGUID]
			,@TariffMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
END

--------------2. HeaderText_Denied Party Screening ------------------


	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @DPSGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @DPSGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@DPSGUID AS [MessageGUID]
			,@DPSMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId


----------------------3. HeaderText_ECN/ML ---------------


	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @ECNGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @ECNGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@ECNGUID AS [MessageGUID]
			,@ECNMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId


---------------4. HeaderText_Exchange Rates ----------------


	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @ExchangeRateGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @ExchangeRateGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@ExchangeRateGUID AS [MessageGUID]
			,@ExchangeRateMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId


------------------5. HeaderText_WCO Notes --------------


	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @WCONOTESGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @WCONOTESGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@WCONOTESGUID AS [MessageGUID]
			,@WCONOTESMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId


----------------6. HeaderText_Binding Rulings -------------


	IF EXISTS (
			SELECT TOP 1 [MessageGUID]
			FROM tmgMessages
			WHERE [MessageGUID] = @BindingRulingsGUID
			AND CultureGUID = @CultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
			WHERE [MessageGUID] = @BindingRulingsGUID
			AND CultureGUID = @CultureGUID
	END

	INSERT INTO tmgMessages
		SELECT PartnerId AS [PartnerId]
			,@EffDate AS [EffDate]
			,@CultureGUID AS [CultureGUID]
			,@BindingRulingsGUID AS [MessageGUID]
			,@BindingRulingsMessage AS [Message]
			,@Value_N AS [DeletedFlag]
			,@Value_N AS [KeepDuringRollback]
		FROM tmgPartnerDataConnection
		GROUP BY PartnerId
