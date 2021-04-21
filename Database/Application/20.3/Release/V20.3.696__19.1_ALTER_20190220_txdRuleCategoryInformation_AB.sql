--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------
PRINT '.........CREATE/MODIFY txdRuleCategoryInformation.............'

IF EXISTS (
		SELECT *
		FROM dbo.syscolumns
		WHERE name = 'UsesCountryOfOrigin'
			AND ID = OBJECT_ID('txdRuleCategoryInformation')
		)
BEGIN
	PRINT 'Column Already Exists... Skipping'
END
ELSE
BEGIN
	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE name = 'PK_txdRuleCategoryInformation'
			)
	BEGIN
		ALTER TABLE [dbo].[txdRuleCategoryInformation]

		DROP CONSTRAINT [PK_txdRuleCategoryInformation]
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[tmp_txdRuleCategoryInformation]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		DROP TABLE tmp_txdRuleCategoryInformation
	END

	CREATE TABLE [dbo].[Tmp_txdRuleCategoryInformation] (
		[PartnerID] [int] NOT NULL
		,[EffDate] [datetime] NOT NULL
		,[RuleCategory] [varchar](50) NOT NULL
		,[ParentFTA] [varchar](50) NOT NULL
		,[DeMinimisAmount] [numeric](38, 20) NOT NULL
		,[DMUseNetCost] [varchar](1) NOT NULL
		,[GenerateDocOnSolicit] [varchar](1) NOT NULL
		,[UseContinuation] [varchar](1) NOT NULL
		,[UsesDepartureDate] [varchar](1) NOT NULL
		,[UsesVesselOrAircraftNum] [varchar](1) NOT NULL
		,[UsesPortOfDischarge] [varchar](1) NOT NULL
		,[UsesTransportDetail] [varchar](1) NOT NULL
		,[UsesCountryOfDestination] [varchar](1) NOT NULL
		,[UsesRemarks] [varchar](1) NOT NULL
		,[UsesIssuingCountry] [varchar](1) NOT NULL
		,[UsesPortOfLading] [varchar](1) NOT NULL
		,[UsesBillOfLading] [varchar](1) NOT NULL
		,[UsesOriginatingCountries] [varchar](1) NOT NULL
		,[UsesSpecificCircumstances] [varchar](1) NOT NULL
		,[UsesSupportingDocuments] [varchar](1) NOT NULL
		,[UsesCumulationIndicator] [varchar](1) NOT NULL
		,[UsesCumulationCountries] [varchar](1) NOT NULL
		,[UsesImportingCountry] [varchar](1) NOT NULL
		,[UsesPhytosanitaryITDICertNum] [varchar](1) NOT NULL
		,[UsesQualifying] [varchar](1) NOT NULL
		,[UsesHSNum] [varchar](1) NOT NULL
		,[UsesProducer] [varchar](1) NOT NULL
		,[UsesNetCost] [varchar](1) NOT NULL
		,[UsesPrefCrit] [varchar](1) NOT NULL
		,[UsesMarksNumbers] [varchar](1) NOT NULL
		,[UsesPackages] [varchar](1) NOT NULL
		,[UsesWeightQty] [varchar](1) NOT NULL
		,[WeightQtyFlag] [varchar](1) NOT NULL
		,[UsesMisc] [varchar](1) NOT NULL
		,[MiscAlias] [varchar](50) NOT NULL
		,[UsesValue] [varchar](1) NOT NULL
		,[UsesCurrency] [varchar](1) NOT NULL
		,[UsesInvoiceDate] [varchar](1) NOT NULL
		,[UsesInvoice] [varchar](1) NOT NULL
		,[UsesCompanyPlace] [varchar](1) NOT NULL
		,[UsesCountryOfOrigin] [varchar](1) NOT NULL
		,[UserName] [varchar](50) NOT NULL
		,[LastUpdatedUser] [varchar](50) NOT NULL
		,[LastUpdatedDate] [datetime] NOT NULL
		,[DeletedFlag] [varchar](1) NOT NULL
		,[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdRuleCategoryInformation]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT 'INSERT INTO TEMP TABLE......'

		EXEC (
				'INSERT INTO dbo.Tmp_txdRuleCategoryInformation (
							PartnerID
							,EffDate
							,RuleCategory
							,ParentFTA
							,DeMinimisAmount
							,DMUseNetCost
							,GenerateDocOnSolicit
							,UseContinuation
							,UsesDepartureDate
							,UsesVesselOrAircraftNum
							,UsesPortOfDischarge
							,UsesTransportDetail
							,UsesCountryOfDestination
							,UsesRemarks
							,UsesIssuingCountry
							,UsesPortOfLading
							,UsesBillOfLading
							,UsesOriginatingCountries
							,UsesSpecificCircumstances
							,UsesSupportingDocuments
							,UsesCumulationIndicator
							,UsesCumulationCountries
							,UsesImportingCountry
							,UsesPhytosanitaryITDICertNum
							,UsesQualifying
							,UsesHSNum
							,UsesProducer
							,UsesNetCost
							,UsesPrefCrit
							,UsesMarksNumbers
							,UsesPackages
							,UsesWeightQty
							,WeightQtyFlag
							,UsesMisc
							,MiscAlias
							,UsesValue
							,UsesCurrency
							,UsesInvoiceDate
							,UsesInvoice
							,UsesCompanyPlace
							,UsesCountryOfOrigin
							,UserName
							,LastUpdatedUser
							,LastUpdatedDate
							,DeletedFlag
							,KeepDuringRollback
							)
						SELECT PartnerID
							,EffDate
							,RuleCategory
							,ParentFTA
							,DeMinimisAmount
							,DMUseNetCost
							,GenerateDocOnSolicit
							,UseContinuation
							,UsesDepartureDate
							,UsesVesselOrAircraftNum
							,UsesPortOfDischarge
							,UsesTransportDetail
							,UsesCountryOfDestination
							,UsesRemarks
							,UsesIssuingCountry
							,UsesPortOfLading
							,UsesBillOfLading
							,UsesOriginatingCountries
							,UsesSpecificCircumstances
							,UsesSupportingDocuments
							,UsesCumulationIndicator
							,UsesCumulationCountries
							,UsesImportingCountry
							,UsesPhytosanitaryITDICertNum
							,UsesQualifying
							,UsesHSNum
							,UsesProducer
							,UsesNetCost
							,UsesPrefCrit
							,UsesMarksNumbers
							,UsesPackages
							,UsesWeightQty
							,WeightQtyFlag
							,UsesMisc
							,MiscAlias
							,UsesValue
							,UsesCurrency
							,UsesInvoiceDate
							,UsesInvoice
							,UsesCompanyPlace
							,''Y'' AS [UsesCountryOfOrigin]
							,UserName
							,LastUpdatedUser
							,LastUpdatedDate
							,DeletedFlag
							,KeepDuringRollback
						FROM dbo.txdRuleCategoryInformation TABLOCKX'
				)
	END

	IF EXISTS (
			SELECT *
			FROM dbo.sysobjects
			WHERE id = object_id(N'[dbo].[txdRuleCategoryInformation]')
				AND OBJECTPROPERTY(id, N'IsUserTable') = 1
			)
	BEGIN
		PRINT ''
		PRINT 'DROP TABLE..........'

		DROP TABLE [dbo].[txdRuleCategoryInformation]
	END

	PRINT ''
	PRINT 'RENAME TABLE....'
	PRINT ''

	EXECUTE sp_rename N'dbo.Tmp_txdRuleCategoryInformation'
		,N'txdRuleCategoryInformation'
		,'OBJECT'

	PRINT ''
	PRINT 'NO PRIMARY KEY......'
	PRINT ''
	PRINT 'CREATE CLUSTERED INDEX...........'

	CREATE CLUSTERED INDEX [CIX_txdRuleCategoryInformation] ON [dbo].[txdRuleCategoryInformation] ([EffDate] ASC)

	PRINT ''
	PRINT 'NO NONCLUSTERED INDEX...........'
END