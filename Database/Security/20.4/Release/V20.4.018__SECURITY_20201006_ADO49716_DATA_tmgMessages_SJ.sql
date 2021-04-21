DECLARE @tmgMessages AS VARCHAR(50) = 'tmgMessages'
DECLARE @EffDate AS DATETIME = GetDate()
DECLARE @USCultureGUID AS VARCHAR(50) = 'en-US'
DECLARE @Value_N AS VARCHAR(1) = 'N'

DECLARE @MessageGUID_ConfirmAlert AS VARCHAR(128) = 'MassAlertClear_ConfirmRemoval'
DECLARE @MessageGUID_ConfirmAlertText AS NVARCHAR(128) = N'Confirm Removal?'

DECLARE @MessageGUID_AlertDetails AS VARCHAR(128) = 'MassAlertClear_RemovalMessage'
DECLARE @MessageGUID_AlertDetailsText AS NVARCHAR(128) = N'Are you sure you want to clear all the hits for this alert ?'


DECLARE @MassAlertClear_MaxCountMessage AS VARCHAR(128) = 'MassAlertClear_MaxCountMessage'
DECLARE @MassAlertClear_MaxCountMessageText AS NVARCHAR(128) = N'1500 Alerts are cleared'


DECLARE @MessageGUID_NoRows AS VARCHAR(128) = 'MassAlertClear_NoRowsFound'
DECLARE @MessageGUID_NoRowsText AS NVARCHAR(128) = N'No rows were Found'


DECLARE @MassAlertClear_ClearedMessage AS VARCHAR(128) = 'MassAlertClear_ClearedMessage'
DECLARE @MassAlertClear_ClearedMessageText AS NVARCHAR(128) = N'All Alerts Cleared'


IF EXISTS (
		SELECT TOP 1 *
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE table_name = @tmgMessages
		)
BEGIN

----------- Confirm Alert

	IF EXISTS (
			SELECT TOP 1 MessageGUID
			FROM tmgMessages
			WHERE MessageGUID = @MessageGUID_ConfirmAlert
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE MessageGUID = @MessageGUID_ConfirmAlert
			AND CultureGUID = @USCultureGUID
	END

	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MessageGUID_ConfirmAlert AS [MessageGUID]
		,@MessageGUID_ConfirmAlertText AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId


----------- Confirm Alert Message
	
	IF EXISTS (
			SELECT TOP 1 MessageGUID
			FROM tmgMessages
			WHERE MessageGUID = @MessageGUID_AlertDetails
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE MessageGUID = @MessageGUID_AlertDetails
			AND CultureGUID = @USCultureGUID
	END

	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MessageGUID_AlertDetails AS [MessageGUID]
		,@MessageGUID_AlertDetailsText AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId

	----------- Wait Message


	
	IF EXISTS (
			SELECT TOP 1 MessageGUID
			FROM tmgMessages
			WHERE MessageGUID = @MassAlertClear_MaxCountMessage
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE MessageGUID = @MassAlertClear_MaxCountMessage
			AND CultureGUID = @USCultureGUID
	END

	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MassAlertClear_MaxCountMessage AS [MessageGUID]
		,@MassAlertClear_MaxCountMessageText AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId



	----------- No Data Message

	
	
	IF EXISTS (
			SELECT TOP 1 MessageGUID
			FROM tmgMessages
			WHERE MessageGUID = @MessageGUID_NoRows
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE MessageGUID = @MessageGUID_NoRows
			AND CultureGUID = @USCultureGUID
	END

	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MessageGUID_NoRows AS [MessageGUID]
		,@MessageGUID_NoRowsText AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId


	

	----------- Total Alerts cleared Message
	
	
	IF EXISTS (
			SELECT TOP 1 MessageGUID
			FROM tmgMessages
			WHERE MessageGUID = @MassAlertClear_ClearedMessage
				AND CultureGUID = @USCultureGUID
			)
	BEGIN
		DELETE
		FROM tmgMessages
		WHERE MessageGUID = @MassAlertClear_ClearedMessage
			AND CultureGUID = @USCultureGUID
	END

	INSERT INTO tmgMessages
	SELECT PartnerId AS [PartnerId]
		,@EffDate AS [EffDate]
		,@USCultureGUID AS [CultureGUID]
		,@MassAlertClear_ClearedMessage AS [MessageGUID]
		,@MassAlertClear_ClearedMessageText AS [Message]
		,@Value_N AS [DeletedFlag]
		,@Value_N AS [KeepDuringRollback]
	FROM tmgPartnerDataConnection
	GROUP BY PartnerId




END