--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

PRINT '.........CREATE/MODIFY txdMXAnnualMaquilaReportHeader.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdMXAnnualMaquilaReportHeader' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ChildPartner' --NEW column here
				AND Object_ID = Object_ID('txdMXAnnualMaquilaReportHeader')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdMXAnnualMaquilaReportHeader' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_txdMXAnnualMaquilaReportHeader --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_txdMXAnnualMaquilaReportHeader] --"tmp" + Your Table Here
		(
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[ReportingYear] [varchar](4) NOT NULL,
			[SubmissionDate] [datetime] NOT NULL,
			[PeriodBeginDate] [datetime] NOT NULL,
			[PeriodEndDate] [datetime] NOT NULL,
			[MXExchangeRate] [numeric](38, 20) NOT NULL,
			[YearEmployeesCurrent] [varchar](4) NOT NULL,
			[YearEmployeesPrevious] [varchar](4) NOT NULL,
			[AdministrativeEmployeesCurrentYear] [int] NOT NULL,
			[AdministrativeEmployeesPreviousYear] [int] NOT NULL,
			[FactoryEmployeesCurrentYear] [int] NOT NULL,
			[FactoryEmployeesPreviousYear] [int] NOT NULL,
			[YearInvestmentCurrent] [varchar](4) NOT NULL,
			[YearInvestmentPrevious] [varchar](4) NOT NULL,
			[InvestingCountryCurrentYear] [varchar](50) NOT NULL,
			[InvestingCountryPreviousYear] [varchar](50) NOT NULL,
			[InvestmentAmountCurrentYear] [int] NOT NULL,
			[InvestmentAmountPreviousYear] [int] NOT NULL,
			[ExportProductDescriptions] [text] NULL,
			[TotalDutyPaid] [numeric](38, 20) NOT NULL,
			[TotalDutyDeclared] [numeric](38, 20) NOT NULL,
			[TotalFixedAssetTemporaryImportation] [numeric](38, 20) NOT NULL,
			[TotalRawMaterialTemporaryImportation] [numeric](38, 20) NOT NULL,
			[TotalFixedAssetPermanentImportation] [numeric](38, 20) NOT NULL,
			[TotalRawMaterialPermanentImportation] [numeric](38, 20) NOT NULL,
			[TotalFixedAssetRegimenChange] [numeric](38, 20) NOT NULL,
			[TotalRawMaterialRegimenChange] [numeric](38, 20) NOT NULL,
			[TotalSales] [numeric](38, 20) NOT NULL,
			[TotalAddedValueExport] [numeric](38, 20) NOT NULL,
			[TotalValueImport] [numeric](38, 20) NOT NULL,
			[TotalRawMaterialVirtualImport] [numeric](38, 20) NOT NULL,
			[ChildPartner] [int] NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL,
		) ON [PRIMARY] 
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdMXAnnualMaquilaReportHeader]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_txdMXAnnualMaquilaReportHeader (PartnerID,EffDate,ReportingYear,SubmissionDate,PeriodBeginDate,PeriodEndDate,MXExchangeRate,YearEmployeesCurrent,YearEmployeesPrevious,AdministrativeEmployeesCurrentYear,AdministrativeEmployeesPreviousYear,FactoryEmployeesCurrentYear,FactoryEmployeesPreviousYear,YearInvestmentCurrent,YearInvestmentPrevious,InvestingCountryCurrentYear,InvestingCountryPreviousYear,InvestmentAmountCurrentYear,InvestmentAmountPreviousYear,ExportProductDescriptions,TotalDutyPaid,TotalDutyDeclared,TotalFixedAssetTemporaryImportation,TotalRawMaterialTemporaryImportation,TotalFixedAssetPermanentImportation,TotalRawMaterialPermanentImportation,TotalFixedAssetRegimenChange,TotalRawMaterialRegimenChange,TotalSales,TotalAddedValueExport,TotalValueImport,TotalRawMaterialVirtualImport,ChildPartner,DeletedFlag,KeepDuringRollback)
			SELECT PartnerID,EffDate,ReportingYear,SubmissionDate,PeriodBeginDate,PeriodEndDate,MXExchangeRate,YearEmployeesCurrent,YearEmployeesPrevious,AdministrativeEmployeesCurrentYear,AdministrativeEmployeesPreviousYear,FactoryEmployeesCurrentYear,FactoryEmployeesPreviousYear,YearInvestmentCurrent,YearInvestmentPrevious,InvestingCountryCurrentYear,InvestingCountryPreviousYear,InvestmentAmountCurrentYear,InvestmentAmountPreviousYear,ExportProductDescriptions,TotalDutyPaid,TotalDutyDeclared,TotalFixedAssetTemporaryImportation,TotalRawMaterialTemporaryImportation,TotalFixedAssetPermanentImportation,TotalRawMaterialPermanentImportation,TotalFixedAssetRegimenChange,TotalRawMaterialRegimenChange,TotalSales,TotalAddedValueExport,TotalValueImport,TotalRawMaterialVirtualImport,PartnerID,DeletedFlag,KeepDuringRollback FROM txdMXAnnualMaquilaReportHeader TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdMXAnnualMaquilaReportHeader]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'txdMXAnnualMaquilaReportHeader' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdMXAnnualMaquilaReportHeader] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdMXAnnualMaquilaReportHeader', N'txdMXAnnualMaquilaReportHeader', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'txdMXAnnualMaquilaReportHeader' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdMXAnnualMaquilaReportHeader' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_txdMXAnnualMaquilaReportHeader] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END