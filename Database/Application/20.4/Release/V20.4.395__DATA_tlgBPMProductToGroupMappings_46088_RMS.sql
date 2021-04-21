DECLARE @TradePartyGUID AS UNIQUEIDENTIFIER

IF EXISTS(
	SELECT TOP 1 1
			FROM sys.tables
			WHERE Name = 'tlgBPMProductToGroupMapping'
				AND Type = 'U'
)
BEGIN
IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tlgBPMProductToGroupMapping WITH (NOLOCK)
		WHERE ProductName = 'GTM'
		AND GroupGUID = '1002'
			AND PartnerID = (
				SELECT TOP 1 PartnerID
				FROM tmfDefaults WITH (NOLOCK)
				)
		)
BEGIN
	DECLARE @TempGUID AS VARCHAR(50) = '00000000-0000-0000-0000-'
	DECLARE @PartnerID AS VARCHAR(12) = (
			SELECT TOP 1 PartnerID
			FROM tmfdefaults WITH (NOLOCK)
			)

	WHILE LEN(@PartnerID) <> 12
	BEGIN
		SET @PartnerID = '0' + @PartnerID
	END

	SET @TempGUID = @TempGUID + @PartnerID
	SET @TradePartyGUID = @TempGUID

	INSERT INTO tlgBPMProductToGroupMapping
	SELECT PartnerID,
		GETDATE(),
		'GTM',
		'IP Full Access Group',
		'1002',
		@TradePartyGUID,
		'N',
		'N'
	FROM tmfDefaults
END
ELSE
BEGIN
	SET @TradePartyGUID = (
			SELECT TOP 1 TradePartyGUID
			FROM tlgBPMProductToGroupMapping WITH (NOLOCK)
			WHERE ProductName = 'GTM'
			AND GroupGUID = '1002'
				AND PartnerID = (
					SELECT TOP 1 PartnerID
					FROM tmfDefaults WITH (NOLOCK)
					)
			)
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tlgBPMProductToStepMapping WITH (NOLOCK)
		WHERE StepInfo = 'dxgGenericFileExportWorkflow.dll~GenericFileExportWorkflow'
			AND StepType = 'Action'
			AND ProductName = 'GTM'
			AND PartnerID = (
				SELECT TOP 1 PartnerID
				FROM tmfDefaults WITH (NOLOCK)
				)
		)
BEGIN
	INSERT INTO tlgBPMProductToStepMapping
	SELECT PartnerID,
		GETDATE(),
		'GTM',
		'Action',
		'dxgGenericFileExportWorkflow.dll~GenericFileExportWorkflow',
		@TradePartyGUID,
		'N',
		'N'
	FROM tmfDefaults
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tlgBPMProductToStepMapping WITH (NOLOCK)
		WHERE StepInfo = 'dxdGenericSpreadSheetValidations.dll~SystemAnnouncement'
			AND StepType = 'Action'
			AND ProductName = 'GTM'
			AND PartnerID = (
				SELECT TOP 1 PartnerID
				FROM tmfDefaults WITH (NOLOCK)
				)
		)
BEGIN
	INSERT INTO tlgBPMProductToStepMapping
	SELECT PartnerID,
		GETDATE(),
		'GTM',
		'Action',
		'dxdGenericSpreadSheetValidations.dll~SystemAnnouncement',
		@TradePartyGUID,
		'N',
		'N'
	FROM tmfDefaults
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tlgBPMProductToStepMapping WITH (NOLOCK)
		WHERE StepInfo = 'dxdGenericSpreadSheetValidations.dll~GenericSpreadSheetValidations'
			AND StepType = 'Action'
			AND ProductName = 'GTM'
			AND PartnerID = (
				SELECT TOP 1 PartnerID
				FROM tmfDefaults WITH (NOLOCK)
				)
		)
BEGIN
	INSERT INTO tlgBPMProductToStepMapping
	SELECT PartnerID,
		GETDATE(),
		'GTM',
		'Action',
		'dxdGenericSpreadSheetValidations.dll~GenericSpreadSheetValidations',
		@TradePartyGUID,
		'N',
		'N'
	FROM tmfDefaults
END

IF NOT EXISTS (
		SELECT TOP 1 1
		FROM tlgBPMProductToStepMapping WITH (NOLOCK)
		WHERE StepInfo = 'dxdGenericSourceToDestinationMove.dll~GenericSourceToDestinationMoveForBPM'
			AND StepType = 'Action'
			AND ProductName = 'GTM'
			AND PartnerID = (
				SELECT TOP 1 PartnerID
				FROM tmfDefaults WITH (NOLOCK)
				)
		)
BEGIN
	INSERT INTO tlgBPMProductToStepMapping
	SELECT PartnerID,
		GETDATE(),
		'GTM',
		'Action',
		'dxdGenericSourceToDestinationMove.dll~GenericSourceToDestinationMoveForBPM',
		@TradePartyGUID,
		'N',
		'N'
	FROM tmfDefaults
END
END