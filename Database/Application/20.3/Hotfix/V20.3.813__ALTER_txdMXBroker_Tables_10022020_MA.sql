/*
ADO # 51752
DB Script to update Broker Tables provided by Support (Carlos Lira)
*/
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'FilePath' --Any 1 of your NEW columns here
			AND Object_ID = Object_ID('txdMXBrokerPedimentoHeader')) --Your Table Here
BEGIN
	PRINT 'Column Already Exists for Decrementables... Skipping.'
END
ELSE
BEGIN
	alter table txdMXBrokerPedimentoHeader add [FilePath] [varchar](300) NULL

	execute('update txdMXBrokerPedimentoHeader set [FilePath] = '''' ')

	alter table txdMXBrokerPedimentoHeader alter column [FilePath] [varchar](300) NULL
END
GO

-- Pedimento Header Table (Production)
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DecFreightCharges' --Any 1 of your NEW columns here
			AND Object_ID = Object_ID('txdMXBrokerPedimentoHeader')) --Your Table Here
BEGIN
	PRINT 'Column Already Exists for Decrementables... Skipping.'
END
ELSE
		IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdMXBrokerPedimentoHeader]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			PRINT ''
			PRINT 'DROP TEMP TABLE..........'
			DROP TABLE tmdMXBrokerPedimentoHeader
		END
		
		IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdMXBrokerPedimentoHeader]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
		BEGIN
			PRINT ''
			PRINT 'CREATE TEMP TABLE..........'

				SELECT PartnerID,EffDate,PedimentoNum,PedimentoCategory,PedimentoCode,PedimentoRegimen,DestinationOrigin,
						MXExchangeRate,ManifestWeight,ManifestWeightUom,CustomsImportExportLocation,CustomsFilingLocation,
						ArrivalMOT,DepartureMOT,ImportExportMOT,GrossValue,GrossValueCurrencyCode,MXGrossValue,MXGrossValueCurrencyCode,
						MXCommercialValue,MXCommercialValueCurrencyCode,CompanyName,CompanyFederalID,CompanyCURP,CompanyAddress1,
						CompanyAddress2,CompanyCity,CompanyState,CompanyColony,CompanyPostalCode,CompanyCountry,CompanyRNIMCode,
						InsuranceCharges,InsuranceChargesCurrencyCode,InsuredValue,InsuredValueCurrencyCode,FreightCharges,
						FreightChargesCurrencyCode,PackingCharges,PackingChargesCurrencyCode,MiscCharges,MiscChargesCurrencyCode,
						AuthorizationCode,ClosingAuthorizationCode,ManifestQty,ManifestQtyUom,ContainerCount,ProcessingFee,
						ProcessingFeeCurrencyCode,ValidationFee,ValidationFeeCurrencyCode,ProcessingFeeTotal,ValidationFeeTotal,
						InvoiceCount,TotalVAT,TotalDutiesCash,TotalDutiesOther,BrokerCompanyID,BrokerName,BrokerFederalID,
						BrokerCURP,FileSequenceNum,PedimentoBeginDate,PedimentoEndDate,PedimentoEnteredDate,PedimentoPaymentDate,
						LastProcessedDate,SubmissionDate,ElectronicSignatureType,ElectronicSignature,ElectronicSignatureCertificateNum,
						ObservationText,FilePath,
						convert(DECIMAL(38,20), 0) AS FreightDecrements,
						convert(DECIMAL(38,20), 0) AS InsuranceDecrements,
						convert(DECIMAL(38,20), 0) AS ChargeDecrements,
						convert(DECIMAL(38,20), 0) AS DischargeDecrements,
						convert(DECIMAL(38,20), 0) AS MiscDecrements,
						DeletedFlag,
						KeepDuringRollback 
				INTO tmdMXBrokerPedimentoHeader
				FROM txdMXBrokerPedimentoHeader WITH (NOLOCK)

				PRINT ''
				PRINT 'DROP PROD TABLE..........'
				DROP TABLE txdMXBrokerPedimentoHeader

				PRINT ''
				PRINT 'RENAME TABLE....'
				EXECUTE sp_rename N'tmdMXBrokerPedimentoHeader', N'txdMXBrokerPedimentoHeader', 'OBJECT'
		
				PRINT ''
				PRINT 'CREATE PRIMARY KEY......'
				ALTER TABLE [dbo].txdMXBrokerPedimentoHeader ADD CONSTRAINT
					[PK_txdMXBrokerPedimentoHeader] PRIMARY KEY NONCLUSTERED 
					(
					[PartnerID] ASC,
					[PedimentoNum] ASC
					) 
			END
			ELSE
				PRINT 'The table [txdMXBrokerPedimentoHeader] does not exists'

			

-- 506 Dates
IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdMXBrokerPedimentoDates]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT ''
		PRINT 'CREATE Pedimento Dates TABLE..........'
		CREATE TABLE [txdMXBrokerPedimentoDates](
				[PartnerID] [int] NOT NULL,
				[EffDate] [datetime] NOT NULL,
				[PedimentoNum] [varchar](30) NOT NULL,
				[PedimentoDate] [datetime] NOT NULL,
				[DateType] [varchar](10) NOT NULL,
				[DeletedFlag] [varchar](1) NOT NULL,
				[KeepDuringRollback] [varchar](1) NOT NULL
			) ON [PRIMARY]
	END


--507 Identifiers (increasing size)
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'Identification1' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoCompliments')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoCompliments','Identification1','varchar',1,50

	ALTER TABLE txdMXBrokerPedimentoCompliments --Your Table Here
	ALTER COLUMN Identification1 [varchar] (50) NOT NULL --your column here

	ALTER TABLE txdMXBrokerPedimentoCompliments --Your Table Here
	ALTER COLUMN Identification2 [varchar] (50) NOT NULL --your column here

	ALTER TABLE txdMXBrokerPedimentoCompliments --Your Table Here
	ALTER COLUMN Identification3 [varchar] (50) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoCompliments' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoCompliments] does not exists'

--

-- Cuentas Aduaneras
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdMXBrokerPedimentoCuentasAduaneras]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT ''
		PRINT 'DROP TEMP TABLE..........'
		DROP TABLE tmdMXBrokerPedimentoCuentasAduaneras
	END

	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdMXBrokerPedimentoCuentasAduaneras]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT ''
		PRINT 'CREATE TEMP TABLE..........'

		SELECT [PartnerID] ,
				[EffDate] ,
				[PedimentoNum] ,
				CAST([IssuingInstitutionCode] AS [int]) AS [IssuingInstitutionCode],
				CAST([CustomsAccountNumber] AS [numeric](17, 0) ) AS [CustomsAccountNumber],
				[FolioOfConstancy],
				[DateOfConstancy],
				CAST([TypeOfAccountOfWarranty] AS [int] ) AS [TypeOfAccountOfWarranty],
				CAST([TypeOfWarranty] AS [int] ) AS [TypeOfWarranty],
				CAST([UnitValueOfTitle] AS [numeric](38, 20) ) AS [UnitValueOfTitle],
				CAST([TotalAmountOfWarranty] AS [numeric](38, 20) ) AS [TotalAmountOfWarranty],
				CAST([Quantity] AS [numeric](38, 20) ) AS [Quantity],
				CAST([AssignedTitles] AS [numeric](38, 20)) AS [AssignedTitles],
				[DeletedFlag],
				[KeepDuringRollback]  
		INTO tmdMXBrokerPedimentoCuentasAduaneras
		FROM txdMXBrokerPedimentoCuentasAduaneras WITH (NOLOCK)

		PRINT ''
		PRINT 'DROP PROD TABLE..........'
		DROP TABLE txdMXBrokerPedimentoCuentasAduaneras

		PRINT ''
		PRINT 'RENAME TABLE....'
		EXECUTE sp_rename N'tmdMXBrokerPedimentoCuentasAduaneras', N'txdMXBrokerPedimentoCuentasAduaneras', 'OBJECT'
	END
	ELSE
		PRINT 'The table [tmdMXBrokerPedimentoCuentasAduaneras] does not exists'
--

--512 Discharges
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXTariffNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoDischarges')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoDischarges','MXTariffNum','varchar',1,15

	ALTER TABLE txdMXBrokerPedimentoDischarges --Your Table Here
	ALTER COLUMN MXTariffNum [varchar] (15) NOT NULL --your column here

	ALTER TABLE txdMXBrokerPedimentoDischarges --Your Table Here
	ALTER COLUMN MXTariffQuantity [numeric](38, 20) NOT NULL --your column here

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoDischarges' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoDischarges] does not exists'


--514 Payment Documents
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'InstitutionName' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPaymentDocuments')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPaymentDocuments','InstitutionName','varchar',1,200

	ALTER TABLE txdMXBrokerPaymentDocuments ALTER COLUMN [PaymentType] [int]
	ALTER TABLE txdMXBrokerPaymentDocuments ALTER COLUMN [InstitutionName] [varchar](200)
	ALTER TABLE txdMXBrokerPaymentDocuments ALTER COLUMN [DocumentNum] [varchar](100)
	ALTER TABLE txdMXBrokerPaymentDocuments ALTER COLUMN [TotalAmountOfDocument] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPaymentDocuments ALTER COLUMN [AvailableBalanceOfDocument] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPaymentDocuments ALTER COLUMN [TotalPaymentOfPedimento] [numeric](38, 20)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPaymentDocuments' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPaymentDocuments] does not exists'
	


--515 Automotive Industry Inform
IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdMXBrokerAutomotiveIndustry]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT ''
		PRINT 'CREATE Automotive Industry Inform TABLE..........'

		CREATE TABLE [txdMXBrokerAutomotiveIndustry](
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[PedimentoNum] [varchar](30) NOT NULL,
			[CustomsFilingLocation] [varchar](5) NOT NULL,
			[BrokerCURP] [varchar](20) NOT NULL,
			[PedimentoCode] [varchar](5) NOT NULL,
			[CustomsImportExportLocation] [varchar](5) NOT NULL,
			[CompanyFederalID] [varchar](20) NOT NULL,
			[MXExchangeRate] [numeric](38, 20) NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL
		) ON [PRIMARY]

	END


--516 Seals
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'TransportID' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoSeals')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoSeals','TransportID','varchar',1,30

	ALTER TABLE txdMXBrokerPedimentoSeals ALTER COLUMN [TransportID] [varchar](30)
	ALTER TABLE txdMXBrokerPedimentoSeals ALTER COLUMN [SealNum] [varchar](30)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoSeals' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoSeals] does not exists'
	

	

--520 Destination (Ship to)
IF NOT EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdMXBrokerPedimentoDestination]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		PRINT ''
		PRINT 'CREATE Destination (Ship to) TABLE..........'

		CREATE TABLE [txdMXBrokerPedimentoDestination](
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[PedimentoNum] [varchar](30) NOT NULL,
			[CompanyFederalID] [varchar](20) NOT NULL,
			[CompanyName] [varchar](200) NOT NULL,
			[CompanyAddress1] [varchar](200) NOT NULL,
			[CompanyAddress2] [varchar](200) NOT NULL,
			[CompanyPostalCode] [varchar](10) NOT NULL,
			[CompanyCity] [varchar](100) NOT NULL,
			[CompanyState] [varchar](50) NOT NULL,
			[CompanyCountry] [varchar](20) NOT NULL,
		 ) ON [PRIMARY]
	END


 --551 Pedimento Details
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoDetail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoDetail','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerPedimentoDetail ALTER COLUMN [MXHSNum] [varchar](15)
	ALTER TABLE txdMXBrokerPedimentoDetail ALTER COLUMN [ValueMethod] [varchar](5)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoDetail' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoDetail] does not exists'



--552 Merchandises
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerMerchandises')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerMerchandises','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerMerchandises ALTER COLUMN [MXHSNum] [varchar](15)
	ALTER TABLE txdMXBrokerMerchandises ALTER COLUMN [VINOrSerialNum] [varchar](50)
	ALTER TABLE txdMXBrokerMerchandises ALTER COLUMN [Kilometers] [numeric](10, 0)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerMerchandises' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerMerchandises] does not exists'



--553 Permits
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPermits')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPermits','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerPermits ALTER COLUMN [MXHSNum] [varchar](15)
	ALTER TABLE txdMXBrokerPermits ALTER COLUMN [PermitNumber] [varchar](50)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPermits' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPermits] does not exists'


--554 Identifiers
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerIdentifiersDefaultByTariff')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerIdentifiersDefaultByTariff','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerIdentifiersDefaultByTariff ALTER COLUMN [MXTariffNum] [varchar](15)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerIdentifiersDefaultByTariff' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerIdentifiersDefaultByTariff] does not exists'

	

--555 Accounts by Details
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoCuentasAduanerasPartida')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoCuentasAduanerasPartida','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerPedimentoCuentasAduanerasPartida ALTER COLUMN [MXHSNum] [varchar](15)
	ALTER TABLE txdMXBrokerPedimentoCuentasAduanerasPartida ALTER COLUMN [FolioOfConstancy] [varchar](30)
	ALTER TABLE txdMXBrokerPedimentoCuentasAduanerasPartida ALTER COLUMN [UnitValueOfTitle] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPedimentoCuentasAduanerasPartida ALTER COLUMN [TotalAmountOfWarranty] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPedimentoCuentasAduanerasPartida ALTER COLUMN [Quantity] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPedimentoCuentasAduanerasPartida ALTER COLUMN [AssignedTitles] [numeric](38, 20)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoCuentasAduanerasPartida' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoCuentasAduanerasPartida] does not exists'




--556/557  Fees per Detail
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoHSLineItemFees')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoHSLineItemFees','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerPedimentoHSLineItemFees ALTER COLUMN [MXHSNum] [varchar](15)
	ALTER TABLE txdMXBrokerPedimentoHSLineItemFees ALTER COLUMN [TaxType] [varchar](10)
	ALTER TABLE txdMXBrokerPedimentoHSLineItemFees ALTER COLUMN [TaxRate] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPedimentoHSLineItemFees ALTER COLUMN [TaxRateType] [varchar](10)
	ALTER TABLE txdMXBrokerPedimentoHSLineItemFees ALTER COLUMN [TaxTotal] [numeric](38, 20)
	ALTER TABLE txdMXBrokerPedimentoHSLineItemFees ALTER COLUMN [TaxFormOfPayment] [varchar](10)

	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoHSLineItemFees' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoHSLineItemFees] does not exists'
	


--558 and 560 Fees per Detail
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoHSLineItemObservations')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoHSLineItemObservations','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerPedimentoHSLineItemObservations ALTER COLUMN [MXHSNum] [varchar](15)
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoHSLineItemObservations' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoHSLineItemObservations] does not exists'
	


--351 Fees per Detail
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerComplimentaryPedimentoTaxes')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerComplimentaryPedimentoTaxes','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerComplimentaryPedimentoTaxes ALTER COLUMN [MXHTSNum] [varchar](15)
	ALTER TABLE txdMXBrokerComplimentaryPedimentoTaxes ALTER COLUMN [IGI] [numeric](38, 20)
	ALTER TABLE txdMXBrokerComplimentaryPedimentoTaxes ALTER COLUMN [TotalImportTax] [numeric](38, 20)
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerComplimentaryPedimentoTaxes' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerComplimentaryPedimentoTaxes] does not exists'
	


--352 Complementary details
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerComplimentary303Detail')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerComplimentary303Detail','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerComplimentary303Detail ALTER COLUMN [MXHTSNum] [varchar](15)
	ALTER TABLE txdMXBrokerComplimentary303Detail ALTER COLUMN [AddValoremRate] [numeric](38, 20)
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerComplimentary303Detail' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerComplimentary303Detail] does not exists'



--353 Complementary fees
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerPedimentoHSLineArticle303')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerPedimentoHSLineArticle303','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerPedimentoHSLineArticle303 ALTER COLUMN [MXHSNum] [varchar](15)
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerPedimentoHSLineArticle303' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerPedimentoHSLineArticle303] does not exists'
	


--355 Complementary Payment
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerComplimentary303Payment')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerComplimentary303Payment','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerComplimentary303Payment ALTER COLUMN [MXHTSNum] [varchar](15)
	
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerComplimentary303Payment' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerComplimentary303Payment] does not exists'
	


--358 Complementary Observation
IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'MXHSNum' --your column here
			AND Object_ID = OBJECT_ID('txdMXBrokerComplimentary303Observations')) --Your Table Here
BEGIN
	--Do not change 1st and 5th parameter.  
	--4th parameter is the updated data type; 6th paramter is the updated column length if any
	EXEC usp_DBACopyTableIndexesByColumn '','txdMXBrokerComplimentary303Observations','MXHSNum','varchar',1,15

	ALTER TABLE txdMXBrokerComplimentary303Observations ALTER COLUMN [MXHTSNum] [varchar](15)
	ALTER TABLE txdMXBrokerComplimentary303Observations ALTER COLUMN [Observations] [varchar](200)
		
	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdMXBrokerComplimentary303Observations' --Your Table Here
END
ELSE
	PRINT 'The table [txdMXBrokerComplimentary303Observations] does not exists'
