/* CREATE txdDEImpGoodsItemAdditionalProcedure */
PRINT '.........CREATE/MODIFY txdDEImpGoodsItemAdditionalProcedure.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdDEImpGoodsItemAdditionalProcedure'
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdDEImpGoodsItemAdditionalProcedure] (
		PartnerID INT NOT NULL
		,EffDate DATETIME NOT NULL
		,DeclarationGUID VARCHAR(50) NOT NULL
		,DeclarationDataGUID VARCHAR(50) NOT NULL
		,GoodsItemGUID VARCHAR(50) NOT NULL
		,AdditionalProcedureGUID VARCHAR(50) NOT NULL
		,SequenceNum INT NOT NULL
		,Code NVARCHAR(3) NOT NULL
		,DeletedFlag VARCHAR(1) NOT NULL
		,KeepDuringRollback VARCHAR(1) NOT NULL
		) ON [PRIMARY]

	ALTER TABLE [dbo].[txdDEImpGoodsItemAdditionalProcedure] ADD CONSTRAINT PK_txdDEImpGoodsItemAdditionalProcedure PRIMARY KEY NONCLUSTERED (
		PartnerID
		,DeclarationGUID
		,DeclarationDataGUID
		,GoodsItemGUID
		,AdditionalProcedureGUID
		)
END

/* CREATE txdDEImpGoodsItemAdditionalProcedure */
PRINT '.........CREATE/MODIFY txdDeImpMessageLog.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdDeImpMessageLog'
			AND Type = 'U'
		)
BEGIN
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdDeImpMessageLog] (
		[PartnerID] [int] NOT NULL,
		[MessageGUID] [varchar](50) NOT NULL,
		[SequenceNum] [int] NOT NULL,
		[EffDateUTC] [datetime] NOT NULL,
		[FileName] [nvarchar](500) NOT NULL,
		[UserName] [varchar](200) NOT NULL,
		[MetaDataPreparationDateTime] [datetime] NOT NULL,
		[MetaDataInterchangeControlReference] [nvarchar](200) NOT NULL,
		[MetaDataMessageReferenceNumber] [nvarchar](500) NOT NULL,
		[MetaDataMessageIdentifier] [nvarchar](200) NOT NULL,
		[MetaDataMessageGroup] [nvarchar](500) NOT NULL,
		[MetaDataTestIndicator] [nvarchar](500) NOT NULL,
		[MetaDataMessageType] [nvarchar](500) NOT NULL,
		[MetaDataInterchangeSenderIdentificationReferenceNumber] [nvarchar](500) NOT NULL,
		[MetaDataInterchangeSenderIdentificationSubsidiaryNumber] [nvarchar](500) NOT NULL,
		[MetaDataInterchangeRecipientIdentificationReferenceNumber] [nvarchar](500) NOT NULL,
		[MetaDataInterchangeRecipientIdentificationSubsidiaryNumber] [nvarchar](500) NOT NULL,
		[HeaderMessageVersion] [nvarchar](500) NOT NULL,
		[HeaderTemporaryReferenceNumber] [nvarchar](500) NOT NULL,
		[HeaderReferencedMessageIdentifier] [nvarchar](500) NOT NULL,
		[HeaderReferenceNumber] [nvarchar](500) NOT NULL,
		[HeaderRegistrationNumber] [nvarchar](500) NOT NULL,
		[HeaderLocalReferenceNumber] [nvarchar](500) NOT NULL,
		[ErrorFlag] [nvarchar](500) NOT NULL,
		[Direction] [nvarchar](500) NOT NULL,
		) ON [PRIMARY]

	ALTER TABLE [dbo].[txdDeImpMessageLog] ADD CONSTRAINT [PK_txdDeImpMessageLog] PRIMARY KEY NONCLUSTERED (
		[PartnerID] ASC,
		[MessageGUID] ASC,
		[FileName] ASC,
		[MetaDataInterchangeControlReference] ASC
		)
END


/* ALTER txdDEImpDeclarationData.DeferredPaymentVat */
PRINT '.........CREATE/MODIFY txdDEImpDeclarationData.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.columns
		WHERE name = 'DeferredPaymentVat'
			AND Object_ID = OBJECT_ID('txdDEImpDeclarationData')
		)
BEGIN
	EXEC usp_DBACopyTableIndexesByColumn '','txdDEImpDeclarationData','DeferredPaymentVat','nvarchar',1,20
	
	ALTER TABLE txdDEImpDeclarationData

	ALTER COLUMN DeferredPaymentVat NVARCHAR(20) NOT NULL
	
	EXEC usp_DBACreateTableIndexes '','txdDEImpDeclarationData'
END

/* ALTER txdDEImpDeclarationData.UltimateConsigneeVatNumber */
PRINT '.........CREATE/MODIFY txdDEImpDeclarationData.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.columns
		WHERE name = 'UltimateConsigneeVatNumber'
			AND Object_ID = OBJECT_ID('txdDEImpDeclarationData')
		)
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdDEImpDeclarationData','UltimateConsigneeVatNumber','nvarchar',1,20
	
	ALTER TABLE txdDEImpDeclarationData

	ALTER COLUMN UltimateConsigneeVatNumber NVARCHAR(20) NOT NULL
	
	EXEC usp_DBACreateTableIndexes '','txdDEImpDeclarationData'
END

/* ALTER txdDEImpPeriodicDeclarationData.DeferredPaymentVat */
PRINT '.........CREATE/MODIFY txdDEImpPeriodicDeclarationData.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.columns
		WHERE name = 'UltimateConsigneeVatNumber'
			AND Object_ID = OBJECT_ID('txdDEImpPeriodicDeclarationData')
		)
BEGIN	
	EXEC usp_DBACopyTableIndexesByColumn '','txdDEImpPeriodicDeclarationData','DeferredPaymentVat','nvarchar',1,20
	
	ALTER TABLE txdDEImpPeriodicDeclarationData

	ALTER COLUMN DeferredPaymentVat NVARCHAR(20) NOT NULL
	
	EXEC usp_DBACreateTableIndexes '','txdDEImpPeriodicDeclarationData'
END

/* ALTER txdDEImpResponseMessage.ErrorCode */
PRINT '.........CREATE/MODIFY txdDEImpResponseMessage.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.columns
		WHERE name = 'ErrorCode'
			AND Object_ID = OBJECT_ID('txdDEImpResponseMessage')
		)
BEGIN
	EXEC usp_DBACopyTableIndexesByColumn '','txdDEImpResponseMessage','ErrorCode','nvarchar',1,8

	ALTER TABLE txdDEImpResponseMessage

	ALTER COLUMN ErrorCode NVARCHAR(8) NOT NULL
	
	EXEC usp_DBACreateTableIndexes '','txdDEImpResponseMessage'
END

/* ALTER txdDEImpResponseInvestigation.VATNumber */
PRINT '.........CREATE/MODIFY txdDEImpResponseInvestigation.............'
IF EXISTS (
		SELECT TOP 1 1
		FROM sys.columns
		WHERE name = 'VATNumber'
			AND Object_ID = OBJECT_ID('txdDEImpResponseInvestigation')
		)
BEGIN
	EXEC usp_DBACopyTableIndexesByColumn '','txdDEImpResponseInvestigation','VATNumber','nvarchar',1,20

	ALTER TABLE txdDEImpResponseInvestigation

	ALTER COLUMN VATNumber NVARCHAR(20) NOT NULL
	
	EXEC usp_DBACreateTableIndexes '','txdDEImpResponseInvestigation'
END



/* ALTER txdDEImpResponse: VATNumber NVARCHAR(20), ADD  AppealCustomsOfficeDEEmail NVARCHAR(256)*/
PRINT '.........CREATE/MODIFY txdDEImpResponse.............'

IF EXISTS (
		SELECT TOP 1 1
		FROM sys.tables
		WHERE Name = 'txdDEImpResponse' --Your Table Here
			AND Type = 'U'
		)
BEGIN
	IF EXISTS (
			SELECT TOP 1 1
			FROM sys.columns
			WHERE name = 'AppealCustomsOfficeDEEmail'
				AND Object_ID = Object_ID('txdDEImpResponse')
			)
	BEGIN
		PRINT ''
		PRINT 'Column(s) Already Exist(s)... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (
				SELECT TOP 1 1
				FROM sys.tables
				WHERE Name = 'tmp_txdDEImpResponse'
					AND Type = 'U'
				)
		BEGIN
			DROP TABLE tmp_txdDEImpResponse
		END

		CREATE TABLE [dbo].[Tmp_txdDEImpResponse] (
			PartnerID INT NOT NULL,
			EffDate DATETIME NOT NULL,
			DeclarationGUID VARCHAR(50) NOT NULL,
			ResponseGUID VARCHAR(50) NOT NULL,
			SequenceNum INT NOT NULL,
			RegistrationDate DATETIME NOT NULL,
			MovementReferenceNumber VARCHAR(21) NOT NULL,
			LocalReferenceNumber VARCHAR(35) NOT NULL,
			NumEdifactMsgFromParicipants VARCHAR(35) NOT NULL,
			Editor VARCHAR(30) NOT NULL,
			DeductionFlag VARCHAR(1) NOT NULL,
			JobNumberEarlyRegistration VARCHAR(21) NOT NULL,
			NotificationPrePresentation NVARCHAR(2000) NOT NULL,
			CustomsOfficerName NVARCHAR(30) NOT NULL,
			CollateralToBeCollected NUMERIC(11, 2) NOT NULL,
			CollateralTotalCalculated NUMERIC(11, 2) NOT NULL,
			CollateralTotalNonCashDue NUMERIC(11, 2) NOT NULL,
			CollateralCashDue NUMERIC(11, 2) NOT NULL,
			GuaranteeReleasedAmount NUMERIC(11, 2) NOT NULL,
			GuaranteeDueAmount NUMERIC(11, 2) NOT NULL,
			GuaranteeRetainedAmount NUMERIC(11, 2) NOT NULL,
			GuaranteeType VARCHAR(1) NOT NULL,
			GuaranteeWaiver VARCHAR(1) NOT NULL,
			GuaranteePaymentMethod VARCHAR(1) NOT NULL,
			FindingsNotice NVARCHAR(4000) NOT NULL,
			PaymentsNotice NVARCHAR(240) NOT NULL,
			AmendmentRejectionReason NVARCHAR(240) NOT NULL,
			FurtherEvidence VARCHAR(20) NOT NULL,
			SpecialTreatmentGranted VARCHAR(3) NOT NULL,
			InspectionType VARCHAR(1) NOT NULL,
			ImportVATValue NUMERIC(11, 2) NOT NULL,
			CustomsValue NUMERIC(11, 2) NOT NULL,
			CompletionFlag VARCHAR(1) NOT NULL,
			AmendmentAcceptance VARCHAR(1) NOT NULL,
			GuaranteeRequiredAmount NUMERIC(11, 2) NOT NULL,
			SimplifiedMovementReferenceNumber VARCHAR(1) NOT NULL,
			SimplifiedItemNumber INT NOT NULL,
			ApplicationType VARCHAR(3) NOT NULL,
			DefaultCurrency VARCHAR(3) NOT NULL,
			TotalTaxDue NUMERIC(11, 2) NOT NULL,
			TaxPayableAmount NUMERIC(11, 2) NOT NULL,
			DutyRefundAmount NUMERIC(11, 2) NOT NULL,
			AgentStatus VARCHAR(1) NOT NULL,
			PaymentRequestDeferral VARCHAR(1) NOT NULL,
			PaymentRequestCharges VARCHAR(1) NOT NULL,
			PaymentRequestSecurity VARCHAR(1) NOT NULL,
			SmallAmountRule VARCHAR(1) NOT NULL,
			RightToAppeal VARCHAR(1) NOT NULL,
			LiabilityIndicator VARCHAR(1) NOT NULL,
			OfficeOfEntryChanged VARCHAR(1) NOT NULL,
			UserCreatedIndicator VARCHAR(1) NOT NULL,
			ImportVATChanged VARCHAR(1) NOT NULL,
			VATNumber VARCHAR(20) NOT NULL,
			RegistrationMarkNice VARCHAR(23) NOT NULL,
			RegistrationMarkGuaranteeNice VARCHAR(23) NOT NULL,
			CompletionIndicator VARCHAR(1) NOT NULL,
			AgencyIdentification VARCHAR(4) NOT NULL,
			AgencyName NVARCHAR(120) NOT NULL,
			AgencyAddressLine1 NVARCHAR(30) NOT NULL,
			AgencyPostCode NVARCHAR(6) NOT NULL,
			AgencyCity NVARCHAR(35) NOT NULL,
			AgencyContactTel VARCHAR(30) NOT NULL,
			AppealCustomsOfficeName NVARCHAR(120) NOT NULL,
			AppealCustomsOfficeEmail NVARCHAR(256) NOT NULL,
			AppealCustomsOfficeAddressLine1 NVARCHAR(30) NOT NULL,
			AppealCustomsOfficePostCode NVARCHAR(6) NOT NULL,
			AppealCustomsOfficeCity NVARCHAR(35) NOT NULL,
			AppealCustomsOfficeRegion NVARCHAR(30) NOT NULL,
			AppealCustomsOfficePOBoxPostal NVARCHAR(20) NOT NULL,
			AppealCustomsOfficePostCodePostal NVARCHAR(6) NOT NULL,
			AppealCustomsOfficeCityPostal NVARCHAR(35) NOT NULL,
			PaymentOfficeName NVARCHAR(120) NOT NULL,
			PaymentOfficeBankName NVARCHAR(30) NOT NULL,
			PaymentOfficeAccountNumber VARCHAR(22) NOT NULL,
			PaymentOfficeAccountSortCode VARCHAR(8) NOT NULL,
			PaymentOfficeIBAN VARCHAR(22) NOT NULL,
			PaymentOfficeBIC VARCHAR(11) NOT NULL,
			PaymentOfficeAddressLine1 NVARCHAR(30) NOT NULL,
			PaymentOfficePostCode NVARCHAR(6) NOT NULL,
			PaymentOfficeCity NVARCHAR(35) NOT NULL,
			PaymentOfficePOBoxPostal NVARCHAR(20) NOT NULL,
			PaymentOfficePostCodePostal NVARCHAR(6) NOT NULL,
			PaymentOfficeCityPostal NVARCHAR(35) NOT NULL,
			DeclarantID VARCHAR(17) NOT NULL,
			DeclarantAuthorisedIdentity VARCHAR(4) NOT NULL,
			VATDeductedAsInputTaxIndicator VARCHAR(1) NOT NULL,
			DeclarantName NVARCHAR(120) NOT NULL,
			DeclarantAddressLine1 NVARCHAR(35) NOT NULL,
			DeclarantCountry NVARCHAR(2) NOT NULL,
			DeclarantPostCode NVARCHAR(9) NOT NULL,
			DeclarantCity NVARCHAR(35) NOT NULL,
			DeclarantRegion NVARCHAR(35) NOT NULL,
			AgentId VARCHAR(17) NOT NULL,
			AgentAuthorisedIdentity VARCHAR(4) NOT NULL,
			AgentName NVARCHAR(120) NOT NULL,
			AgentAddressLine1 NVARCHAR(35) NOT NULL,
			AgentCountry VARCHAR(2) NOT NULL,
			AgentPostCode NVARCHAR(9) NOT NULL,
			AgentCity NVARCHAR(35) NOT NULL,
			AgentRegion NVARCHAR(35) NOT NULL,
			BeneficiaryId VARCHAR(17) NOT NULL,
			BeneficiaryAuthorisedIdentity VARCHAR(4) NOT NULL,
			BeneficiaryName NVARCHAR(120) NOT NULL,
			BeneficiaryAddressLine1 NVARCHAR(35) NOT NULL,
			BeneficiaryCountry VARCHAR(2) NOT NULL,
			BeneficiaryPostCode NVARCHAR(9) NOT NULL,
			BeneficiaryCity NVARCHAR(35) NOT NULL,
			BeneficiaryRegion NVARCHAR(35) NOT NULL,
			WarehouseDepositorId VARCHAR(17) NOT NULL,
			WarehouseDepositorAuthorisedIdentity VARCHAR(4) NOT NULL,
			WarehouseDepositorName NVARCHAR(120) NOT NULL,
			WarehouseDepositorAddressLine1 NVARCHAR(35) NOT NULL,
			WarehouseDepositorCountry NVARCHAR(35) NOT NULL,
			WarehouseDepositorPostCode NVARCHAR(9) NOT NULL,
			WarehouseDepositorCity NVARCHAR(35) NOT NULL,
			WarehouseDepositorRegion NVARCHAR(35) NOT NULL,
			ConsigneeId VARCHAR(17) NOT NULL,
			ConsigneeAuthorisedIdentity VARCHAR(4) NOT NULL,
			ConsigneeName NVARCHAR(120) NOT NULL,
			ConsigneeAddressLine1 NVARCHAR(35) NOT NULL,
			ConsigneeCountry VARCHAR(2) NOT NULL,
			ConsigneePostCode NVARCHAR(9) NOT NULL,
			ConsigneeCity NVARCHAR(35) NOT NULL,
			ConsigneeRegion NVARCHAR(35) NOT NULL,
			PayeeId VARCHAR(17) NOT NULL,
			PayeeAuthorisedIdentity VARCHAR(4) NOT NULL,
			PayeeAccountNumber VARCHAR(10) NOT NULL,
			PayeeAccountSortCode VARCHAR(8) NOT NULL,
			PayeeIBAN VARCHAR(34) NOT NULL,
			PayeeCreditInstitution VARCHAR(30) NOT NULL,
			PayeeBIC VARCHAR(11) NOT NULL,
			PayeeName NVARCHAR(120) NOT NULL,
			PayeeAddressLine1 NVARCHAR(35) NOT NULL,
			PayeeCountry VARCHAR(2) NOT NULL,
			PayeePostCode NVARCHAR(9) NOT NULL,
			PayeeCity NVARCHAR(35) NOT NULL,
			PayeeRegion NVARCHAR(35) NOT NULL,
			CommunicationDate DATETIME NOT NULL,
			JurisdictionDate DATETIME NOT NULL,
			CashMaturityDate DATETIME NOT NULL,
			SecurityMaturityDate DATETIME NOT NULL,
			AccountingPeriodStart DATETIME NOT NULL,
			AccountingPeriodEnd DATETIME NOT NULL,
			TypePart1 VARCHAR(2) NOT NULL,
			CommercialReference VARCHAR(35) NOT NULL,
			CancellationDate DATETIME NOT NULL,
			InvestigationDate DATETIME NOT NULL,
			ExitDate DATETIME NOT NULL,
			DepartureOffice VARCHAR(8) NOT NULL,
			ExitOffice VARCHAR(11) NOT NULL,
			PlaceOfCustomsExamination NVARCHAR(35) NOT NULL,
			IssuePlace NVARCHAR(14) NOT NULL,
			IssueDate DATETIME NOT NULL,
			INCOTermsCode VARCHAR(3) NOT NULL,
			INCOTermsLocationText NVARCHAR(35) NOT NULL,
			SensitiveNotification VARCHAR(2) NOT NULL,
			SensitiveAdditionnal NUMERIC(38, 20) NOT NULL,
			UndgCode VARCHAR(4) NOT NULL,
			DeclarantRegistrationNumber VARCHAR(35) NOT NULL,
			LocalReferenceNumberWarehousing VARCHAR(35) NOT NULL,
			ReleaseDateWarehousing DATETIME NOT NULL,
			ExitConfirmationDate DATETIME NOT NULL,
			MovementReferenceNumberBEShareZL VARCHAR(21) NOT NULL,
			ItemNumberBEShareZL INT NOT NULL,
			CancellationFlagBEShareZL VARCHAR(1) NOT NULL,
			WarehouseOperatorIdOrAuth VARCHAR(17) NOT NULL,
			MovementReferenceNumberProcessAtlas VARCHAR(21) NOT NULL,
			MovementReferenceNumberProcessOther VARCHAR(35) NOT NULL,
			SettlementType VARCHAR(4) NOT NULL,
			DepositoryIdSumA VARCHAR(17) NOT NULL,
			DepositoryAuthorisedIdentitySumA VARCHAR(4) NOT NULL,
			TransmitterId VARCHAR(17) NOT NULL,
			TransmitterAuthorisedIdentity VARCHAR(4) NOT NULL,
			ScenarioNumber VARCHAR(1) NOT NULL,
			VATIndicator VARCHAR(1) NOT NULL,
			NewMovementReferenceNumber VARCHAR(21) NOT NULL,
			CancellationReasonCode VARCHAR(1) NOT NULL,
			ReasonCancellation NVARCHAR(2000) NOT NULL,
			AgencyRegion NVARCHAR(30) NOT NULL,
			AgencyPOBOXNumber NVARCHAR(20) NOT NULL,
			RegistrationNumberPayment VARCHAR(28) NOT NULL,
			TotalAmount NUMERIC(11, 2) NOT NULL,
			RegistrationNumberSecurityPayment VARCHAR(28) NOT NULL,
			CashCollateralAmountPaid NUMERIC(11, 2) NOT NULL,
			PaymentOfficeTelephoneNumber NVARCHAR(30) NOT NULL,
			PaymentOfficeRegion NVARCHAR(30) NOT NULL,
			TotalAmountReleasedSecurity NUMERIC(11, 2) NOT NULL,
			ReleasedSecurityEuro NUMERIC(11, 2) NOT NULL,
			ReleasedSecurityIndicatorHeader VARCHAR(1) NOT NULL,
			TypeReleasedSecurity VARCHAR(1) NOT NULL,
			TypePaymentReimbursedDutiesReleasedSecurity VARCHAR(1) NOT NULL,
			AdditionalCommunication NVARCHAR(2000) NOT NULL,
			CommunicationConsigneeTIN VARCHAR(17) NOT NULL,
			CommunicationConsigneeBranchNumber VARCHAR(4) NOT NULL,
			CommunicationConsigneeName NVARCHAR(120) NOT NULL,
			CommunicationConsigneeStreet NVARCHAR(35) NOT NULL,
			CommunicationConsigneeCountry VARCHAR(2) NOT NULL,
			CommunicationConsigneePostalCode NVARCHAR(9) NOT NULL,
			CommunicationConsigneeCity NVARCHAR(35) NOT NULL,
			CommunicationConsigneeRegion NVARCHAR(35) NOT NULL,
			CommunicationConsigneeBankName NVARCHAR(30) NOT NULL,
			CommunicationConsigneeAccountNumber VARCHAR(34) NOT NULL,
			CommunicationConsigneeBIC VARCHAR(11) NOT NULL,
			DebtorTIN VARCHAR(17) NOT NULL,
			DebtorBranchNumber VARCHAR(4) NOT NULL,
			DebtorName NVARCHAR(120) NOT NULL,
			DebtorStreet NVARCHAR(35) NOT NULL,
			DebtorCountry VARCHAR(2) NOT NULL,
			DebtorPostalCode NVARCHAR(9) NOT NULL,
			DebtorCity NVARCHAR(35) NOT NULL,
			DebtorRegion NVARCHAR(35) NOT NULL,
			PayeeReleasedCollateralTIN VARCHAR(17) NOT NULL,
			PayeeReleasedCollateralBranchNumber VARCHAR(4) NOT NULL,
			PayeeReleasedCollateralName NVARCHAR(120) NOT NULL,
			PayeeReleasedCollateralStreet NVARCHAR(35) NOT NULL,
			PayeeReleasedCollateralCountry VARCHAR(2) NOT NULL,
			PayeeReleasedCollateralPostalCode NVARCHAR(9) NOT NULL,
			PayeeReleasedCollateralCity NVARCHAR(35) NOT NULL,
			PayeeReleasedCollateralRegion NVARCHAR(35) NOT NULL,
			PayeeReleasedCollateralBankName NVARCHAR(30) NOT NULL,
			PayeeReleasedCollateralAccountNumber VARCHAR(34) NOT NULL,
			PayeeReleasedCollateralBIC VARCHAR(11) NOT NULL,
			ImportTaxAssessmentType VARCHAR(1) NOT NULL,
			CopyNumber VARCHAR(2) NOT NULL,
			DateReceipt DATETIME NOT NULL,
			MaturityDate DATETIME NOT NULL,
			SecurityWaiverIndicator VARCHAR(1) NOT NULL,
			Reason NVARCHAR(4000) NOT NULL,
			RegistrationIndicatorTotalDebtRatioNICE VARCHAR(23) NOT NULL,
			AddresseeTIN VARCHAR(17) NOT NULL,
			AddresseeBranchNumber VARCHAR(4) NOT NULL,
			AddresseeName NVARCHAR(240) NOT NULL,
			AddresseeStreetNumber NVARCHAR(35) NOT NULL,
			AddresseeCountry VARCHAR(2) NOT NULL,
			AddresseePostCode VARCHAR(9) NOT NULL,
			AddresseeCity NVARCHAR(35) NOT NULL,
			AddresseeRegion NVARCHAR(35) NOT NULL,
			CustomsOfficerTelephoneNumber NVARCHAR(30) NOT NULL,
			CustomsOfficerFaxNumber NVARCHAR(30) NOT NULL,
			CustomsOfficerEmail NVARCHAR(50) NOT NULL,
			SimplifiedGrantAuthorisationFlag VARCHAR(1) NOT NULL,
			AuthorisationCriteriaTypeAVUV VARCHAR(1) NOT NULL,
			AuthorisationDischargeBillFlagAVUV VARCHAR(1) NOT NULL,
			AuthorisationSimplifiedMovementFlagAVUV VARCHAR(1) NOT NULL,
			AuthorisationAdditionalInformationAVUV VARCHAR(1) NOT NULL,
			AuthorisationGuaranteeWaiverAVUV VARCHAR(1) NOT NULL,
			AuthorisationGuaranteeDescriptionAVUV NVARCHAR(512) NOT NULL,
			AuthorisationTotalGuaranteeAmountAVUV NUMERIC(11, 2) NOT NULL,
			MonitoringCustomsOfficeAVUV VARCHAR(8) NOT NULL,
			AuthorisationIntendedActivityDetailDescriptionAVUV NVARCHAR(512) NOT NULL,
			AuthorisationMainAccountingLineAVUV NVARCHAR(70) NOT NULL,
			AuthorisationMainAccountingCountryAVUV VARCHAR(2) NOT NULL,
			AuthorisationMainAccountingPostcodeAVUV VARCHAR(9) NOT NULL,
			AuthorisationMainAccountingCityAVUV NVARCHAR(35) NOT NULL,
			AuthorisationMainAccountingDistrictAVUV NVARCHAR(35) NOT NULL,
			AuthorisationFirstPlaceLineAVUV NVARCHAR(70) NOT NULL,
			AuthorisationFirstPlaceCountryAVUV VARCHAR(2) NOT NULL,
			AuthorisationFirstPlacePostcodeAVUV VARCHAR(9) NOT NULL,
			AuthorisationFirstPlaceCityAVUV NVARCHAR(35) NOT NULL,
			AuthorisationFirstPlaceDistrictAVUV NVARCHAR(35) NOT NULL,
			AppealCustomsOfficeDEEmail NVARCHAR(256) NOT NULL,
			DeletedFlag VARCHAR(1) NOT NULL,
			KeepDuringRollback VARCHAR(1) NOT NULL
			) ON [PRIMARY]

		DECLARE @Before_HasData BIT;

		SET @Before_HasData = 0

		IF (
				SELECT TOP 1 1
				FROM [txdDEImpResponse]
				) = 1
		BEGIN
			SET @Before_HasData = 1
		END

		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdDEImpResponse (PartnerID,EffDate,DeclarationGUID,ResponseGUID,SequenceNum,RegistrationDate,MovementReferenceNumber,LocalReferenceNumber,NumEdifactMsgFromParicipants,Editor,DeductionFlag,JobNumberEarlyRegistration,NotificationPrePresentation,CustomsOfficerName,CollateralToBeCollected,CollateralTotalCalculated,CollateralTotalNonCashDue,CollateralCashDue,GuaranteeReleasedAmount,GuaranteeDueAmount,GuaranteeRetainedAmount,GuaranteeType,GuaranteeWaiver,GuaranteePaymentMethod,FindingsNotice,PaymentsNotice,AmendmentRejectionReason,FurtherEvidence,SpecialTreatmentGranted,InspectionType,ImportVATValue,CustomsValue,CompletionFlag,AmendmentAcceptance,GuaranteeRequiredAmount,SimplifiedMovementReferenceNumber,SimplifiedItemNumber,ApplicationType,DefaultCurrency,TotalTaxDue,TaxPayableAmount,DutyRefundAmount,AgentStatus,PaymentRequestDeferral,PaymentRequestCharges,PaymentRequestSecurity,SmallAmountRule,RightToAppeal,LiabilityIndicator,OfficeOfEntryChanged,UserCreatedIndicator,ImportVATChanged,VATNumber,RegistrationMarkNice,RegistrationMarkGuaranteeNice,CompletionIndicator,AgencyIdentification,AgencyName,AgencyAddressLine1,AgencyPostCode,AgencyCity,AgencyContactTel,AppealCustomsOfficeName,AppealCustomsOfficeEmail,AppealCustomsOfficeAddressLine1,AppealCustomsOfficePostCode,AppealCustomsOfficeCity,AppealCustomsOfficeRegion,AppealCustomsOfficePOBoxPostal,AppealCustomsOfficePostCodePostal,AppealCustomsOfficeCityPostal,PaymentOfficeName,PaymentOfficeBankName,PaymentOfficeAccountNumber,PaymentOfficeAccountSortCode,PaymentOfficeIBAN,PaymentOfficeBIC,PaymentOfficeAddressLine1,PaymentOfficePostCode,PaymentOfficeCity,PaymentOfficePOBoxPostal,PaymentOfficePostCodePostal,PaymentOfficeCityPostal,DeclarantID,DeclarantAuthorisedIdentity,VATDeductedAsInputTaxIndicator,DeclarantName,DeclarantAddressLine1,DeclarantCountry,DeclarantPostCode,DeclarantCity,DeclarantRegion,AgentId,AgentAuthorisedIdentity,AgentName,AgentAddressLine1,AgentCountry,AgentPostCode,AgentCity,AgentRegion,BeneficiaryId,BeneficiaryAuthorisedIdentity,BeneficiaryName,BeneficiaryAddressLine1,BeneficiaryCountry,BeneficiaryPostCode,BeneficiaryCity,BeneficiaryRegion,WarehouseDepositorId,WarehouseDepositorAuthorisedIdentity,WarehouseDepositorName,WarehouseDepositorAddressLine1,WarehouseDepositorCountry,WarehouseDepositorPostCode,WarehouseDepositorCity,WarehouseDepositorRegion,ConsigneeId,ConsigneeAuthorisedIdentity,ConsigneeName,ConsigneeAddressLine1,ConsigneeCountry,ConsigneePostCode,ConsigneeCity,ConsigneeRegion,PayeeId,PayeeAuthorisedIdentity,PayeeAccountNumber,PayeeAccountSortCode,PayeeIBAN,PayeeCreditInstitution,PayeeBIC,PayeeName,PayeeAddressLine1,PayeeCountry,PayeePostCode,PayeeCity,PayeeRegion,CommunicationDate,JurisdictionDate,CashMaturityDate,SecurityMaturityDate,AccountingPeriodStart,AccountingPeriodEnd,TypePart1,CommercialReference,CancellationDate,InvestigationDate,ExitDate,DepartureOffice,ExitOffice,PlaceOfCustomsExamination,IssuePlace,IssueDate,INCOTermsCode,INCOTermsLocationText,SensitiveNotification,SensitiveAdditionnal,UndgCode,DeclarantRegistrationNumber,LocalReferenceNumberWarehousing,ReleaseDateWarehousing,ExitConfirmationDate,MovementReferenceNumberBEShareZL,ItemNumberBEShareZL,CancellationFlagBEShareZL,WarehouseOperatorIdOrAuth,MovementReferenceNumberProcessAtlas,MovementReferenceNumberProcessOther,SettlementType,DepositoryIdSumA,DepositoryAuthorisedIdentitySumA,TransmitterId,TransmitterAuthorisedIdentity,ScenarioNumber,VATIndicator,NewMovementReferenceNumber,CancellationReasonCode,ReasonCancellation,AgencyRegion,AgencyPOBOXNumber,RegistrationNumberPayment,TotalAmount,RegistrationNumberSecurityPayment,CashCollateralAmountPaid,PaymentOfficeTelephoneNumber,PaymentOfficeRegion,TotalAmountReleasedSecurity,ReleasedSecurityEuro,ReleasedSecurityIndicatorHeader,TypeReleasedSecurity,TypePaymentReimbursedDutiesReleasedSecurity,AdditionalCommunication,CommunicationConsigneeTIN,CommunicationConsigneeBranchNumber,CommunicationConsigneeName,CommunicationConsigneeStreet,CommunicationConsigneeCountry,CommunicationConsigneePostalCode,CommunicationConsigneeCity,CommunicationConsigneeRegion,CommunicationConsigneeBankName,CommunicationConsigneeAccountNumber,CommunicationConsigneeBIC,DebtorTIN,DebtorBranchNumber,DebtorName,DebtorStreet,DebtorCountry,DebtorPostalCode,DebtorCity,DebtorRegion,PayeeReleasedCollateralTIN,PayeeReleasedCollateralBranchNumber,PayeeReleasedCollateralName,PayeeReleasedCollateralStreet,PayeeReleasedCollateralCountry,PayeeReleasedCollateralPostalCode,PayeeReleasedCollateralCity,PayeeReleasedCollateralRegion,PayeeReleasedCollateralBankName,PayeeReleasedCollateralAccountNumber,PayeeReleasedCollateralBIC,ImportTaxAssessmentType,CopyNumber,DateReceipt,MaturityDate,SecurityWaiverIndicator,Reason,RegistrationIndicatorTotalDebtRatioNICE,AddresseeTIN,AddresseeBranchNumber,AddresseeName,AddresseeStreetNumber,AddresseeCountry,AddresseePostCode,AddresseeCity,AddresseeRegion,CustomsOfficerTelephoneNumber,CustomsOfficerFaxNumber,CustomsOfficerEmail,SimplifiedGrantAuthorisationFlag,AuthorisationCriteriaTypeAVUV,AuthorisationDischargeBillFlagAVUV,AuthorisationSimplifiedMovementFlagAVUV,AuthorisationAdditionalInformationAVUV,AuthorisationGuaranteeWaiverAVUV,AuthorisationGuaranteeDescriptionAVUV,AuthorisationTotalGuaranteeAmountAVUV,MonitoringCustomsOfficeAVUV,AuthorisationIntendedActivityDetailDescriptionAVUV,AuthorisationMainAccountingLineAVUV,AuthorisationMainAccountingCountryAVUV,AuthorisationMainAccountingPostcodeAVUV,AuthorisationMainAccountingCityAVUV,AuthorisationMainAccountingDistrictAVUV,AuthorisationFirstPlaceLineAVUV,AuthorisationFirstPlaceCountryAVUV,AuthorisationFirstPlacePostcodeAVUV,AuthorisationFirstPlaceCityAVUV,AuthorisationFirstPlaceDistrictAVUV,AppealCustomsOfficeDEEmail,DeletedFlag,KeepDuringRollback)
		SELECT PartnerID,EffDate,DeclarationGUID,ResponseGUID,SequenceNum,RegistrationDate,MovementReferenceNumber,LocalReferenceNumber,NumEdifactMsgFromParicipants,Editor,DeductionFlag,JobNumberEarlyRegistration,NotificationPrePresentation,CustomsOfficerName,CollateralToBeCollected,CollateralTotalCalculated,CollateralTotalNonCashDue,CollateralCashDue,GuaranteeReleasedAmount,GuaranteeDueAmount,GuaranteeRetainedAmount,GuaranteeType,GuaranteeWaiver,GuaranteePaymentMethod,FindingsNotice,PaymentsNotice,AmendmentRejectionReason,FurtherEvidence,SpecialTreatmentGranted,InspectionType,ImportVATValue,CustomsValue,CompletionFlag,AmendmentAcceptance,GuaranteeRequiredAmount,SimplifiedMovementReferenceNumber,SimplifiedItemNumber,ApplicationType,DefaultCurrency,TotalTaxDue,TaxPayableAmount,DutyRefundAmount,AgentStatus,PaymentRequestDeferral,PaymentRequestCharges,PaymentRequestSecurity,SmallAmountRule,RightToAppeal,LiabilityIndicator,OfficeOfEntryChanged,UserCreatedIndicator,ImportVATChanged,VATNumber,RegistrationMarkNice,RegistrationMarkGuaranteeNice,CompletionIndicator,AgencyIdentification,AgencyName,AgencyAddressLine1,AgencyPostCode,AgencyCity,AgencyContactTel,AppealCustomsOfficeName,AppealCustomsOfficeEmail,AppealCustomsOfficeAddressLine1,AppealCustomsOfficePostCode,AppealCustomsOfficeCity,AppealCustomsOfficeRegion,AppealCustomsOfficePOBoxPostal,AppealCustomsOfficePostCodePostal,AppealCustomsOfficeCityPostal,PaymentOfficeName,PaymentOfficeBankName,PaymentOfficeAccountNumber,PaymentOfficeAccountSortCode,PaymentOfficeIBAN,PaymentOfficeBIC,PaymentOfficeAddressLine1,PaymentOfficePostCode,PaymentOfficeCity,PaymentOfficePOBoxPostal,PaymentOfficePostCodePostal,PaymentOfficeCityPostal,DeclarantID,DeclarantAuthorisedIdentity,VATDeductedAsInputTaxIndicator,DeclarantName,DeclarantAddressLine1,DeclarantCountry,DeclarantPostCode,DeclarantCity,DeclarantRegion,AgentId,AgentAuthorisedIdentity,AgentName,AgentAddressLine1,AgentCountry,AgentPostCode,AgentCity,AgentRegion,BeneficiaryId,BeneficiaryAuthorisedIdentity,BeneficiaryName,BeneficiaryAddressLine1,BeneficiaryCountry,BeneficiaryPostCode,BeneficiaryCity,BeneficiaryRegion,WarehouseDepositorId,WarehouseDepositorAuthorisedIdentity,WarehouseDepositorName,WarehouseDepositorAddressLine1,WarehouseDepositorCountry,WarehouseDepositorPostCode,WarehouseDepositorCity,WarehouseDepositorRegion,ConsigneeId,ConsigneeAuthorisedIdentity,ConsigneeName,ConsigneeAddressLine1,ConsigneeCountry,ConsigneePostCode,ConsigneeCity,ConsigneeRegion,PayeeId,PayeeAuthorisedIdentity,PayeeAccountNumber,PayeeAccountSortCode,PayeeIBAN,PayeeCreditInstitution,PayeeBIC,PayeeName,PayeeAddressLine1,PayeeCountry,PayeePostCode,PayeeCity,PayeeRegion,CommunicationDate,JurisdictionDate,CashMaturityDate,SecurityMaturityDate,AccountingPeriodStart,AccountingPeriodEnd,TypePart1,CommercialReference,CancellationDate,InvestigationDate,ExitDate,DepartureOffice,ExitOffice,PlaceOfCustomsExamination,IssuePlace,IssueDate,INCOTermsCode,INCOTermsLocationText,SensitiveNotification,SensitiveAdditionnal,UndgCode,DeclarantRegistrationNumber,LocalReferenceNumberWarehousing,ReleaseDateWarehousing,ExitConfirmationDate,MovementReferenceNumberBEShareZL,ItemNumberBEShareZL,CancellationFlagBEShareZL,WarehouseOperatorIdOrAuth,MovementReferenceNumberProcessAtlas,MovementReferenceNumberProcessOther,SettlementType,DepositoryIdSumA,DepositoryAuthorisedIdentitySumA,TransmitterId,TransmitterAuthorisedIdentity,ScenarioNumber,VATIndicator,NewMovementReferenceNumber,CancellationReasonCode,ReasonCancellation,AgencyRegion,AgencyPOBOXNumber,RegistrationNumberPayment,TotalAmount,RegistrationNumberSecurityPayment,CashCollateralAmountPaid,PaymentOfficeTelephoneNumber,PaymentOfficeRegion,TotalAmountReleasedSecurity,ReleasedSecurityEuro,ReleasedSecurityIndicatorHeader,TypeReleasedSecurity,TypePaymentReimbursedDutiesReleasedSecurity,AdditionalCommunication,CommunicationConsigneeTIN,CommunicationConsigneeBranchNumber,CommunicationConsigneeName,CommunicationConsigneeStreet,CommunicationConsigneeCountry,CommunicationConsigneePostalCode,CommunicationConsigneeCity,CommunicationConsigneeRegion,CommunicationConsigneeBankName,CommunicationConsigneeAccountNumber,CommunicationConsigneeBIC,DebtorTIN,DebtorBranchNumber,DebtorName,DebtorStreet,DebtorCountry,DebtorPostalCode,DebtorCity,DebtorRegion,PayeeReleasedCollateralTIN,PayeeReleasedCollateralBranchNumber,PayeeReleasedCollateralName,PayeeReleasedCollateralStreet,PayeeReleasedCollateralCountry,PayeeReleasedCollateralPostalCode,PayeeReleasedCollateralCity,PayeeReleasedCollateralRegion,PayeeReleasedCollateralBankName,PayeeReleasedCollateralAccountNumber,PayeeReleasedCollateralBIC,ImportTaxAssessmentType,CopyNumber,DateReceipt,MaturityDate,SecurityWaiverIndicator,Reason,RegistrationIndicatorTotalDebtRatioNICE,AddresseeTIN,AddresseeBranchNumber,AddresseeName,AddresseeStreetNumber,AddresseeCountry,AddresseePostCode,AddresseeCity,AddresseeRegion,CustomsOfficerTelephoneNumber,CustomsOfficerFaxNumber,CustomsOfficerEmail,SimplifiedGrantAuthorisationFlag,AuthorisationCriteriaTypeAVUV,AuthorisationDischargeBillFlagAVUV,AuthorisationSimplifiedMovementFlagAVUV,AuthorisationAdditionalInformationAVUV,AuthorisationGuaranteeWaiverAVUV,AuthorisationGuaranteeDescriptionAVUV,AuthorisationTotalGuaranteeAmountAVUV,MonitoringCustomsOfficeAVUV,AuthorisationIntendedActivityDetailDescriptionAVUV,AuthorisationMainAccountingLineAVUV,AuthorisationMainAccountingCountryAVUV,AuthorisationMainAccountingPostcodeAVUV,AuthorisationMainAccountingCityAVUV,AuthorisationMainAccountingDistrictAVUV,AuthorisationFirstPlaceLineAVUV,AuthorisationFirstPlaceCountryAVUV,AuthorisationFirstPlacePostcodeAVUV,AuthorisationFirstPlaceCityAVUV,AuthorisationFirstPlaceDistrictAVUV,'''',DeletedFlag,KeepDuringRollback FROM dbo.txdDEImpResponse TABLOCKX'
				)

		DECLARE @After_HasData BIT;

		SET @After_HasData = 0

		IF (
				SELECT TOP 1 1
				FROM [dbo].[Tmp_txdDEImpResponse]
				) = 1
		BEGIN
			SET @After_HasData = 1
		END

		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'

			EXEC usp_DBACopyTableIndexes '', 'txdDEImpResponse'

			PRINT ''
			PRINT 'DROP TABLE..........'

			DROP TABLE [txdDEImpResponse]

			PRINT ''
			PRINT 'RENAME TABLE....'

			EXECUTE sp_rename N'Tmp_txdDEImpResponse',
				N'txdDEImpResponse',
				'OBJECT'

			PRINT ''
			PRINT 'CREATE INDEXES...........'

			EXEC usp_DBACreateTableIndexes '', 'txdDEImpResponse'

			PRINT ''
		END
		ELSE
		BEGIN
			IF EXISTS (
					SELECT TOP 1 1
					FROM sys.tables
					WHERE Name = 'tmp_txdDEImpResponse'
						AND Type = 'U'
					)
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
				PRINT ''
				PRINT 'DROP TMP TABLE..........'

				DROP TABLE [tmp_txdDEImpResponse]
			END

			PRINT ''

			RAISERROR (
					'Error:  Changes rolled back to avoid data loss.',
					16,
					1
					)
		END
	END
END
