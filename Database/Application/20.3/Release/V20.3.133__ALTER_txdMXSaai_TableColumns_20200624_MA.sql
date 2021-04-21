--------------------------------------------------------------------------------------------------------------
-- MODIFY Multiple Tables and EXISTING COLUMN(S) for SAAI M3 file
-- ADO # 28521
-- Release 20.3
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('TotalPackage','TransportIdentifier') --your columns here
			AND Object_ID = OBJECT_ID('txdMXSaaiInvoices')) --Your Table Here
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdMXSaaiInvoices','TotalPackage','numeric',1,5,5,0

	ALTER TABLE txdMXSaaiInvoices --Your Table Here
	ALTER COLUMN TotalPackage numeric(5,0) NOT NULL--your column here
	
	EXEC usp_DBACreateTableIndexes '','txdMXSaaiInvoices' --Your Table Here

	ALTER TABLE txdMXSaaiInvoices --Your Table Here
	ALTER COLUMN TransportIdentifier varchar(30) NOT NULL --your column here
	
	PRINT 'The [TotalPackage] and [TransportIdentifier] fields for table [txdMXSaaiInvoices] have been updated.'

END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('AssignedTitles') --your column here
			AND Object_ID = OBJECT_ID('txdMXSaaiCuentasAduaneras')) --Your Table Here
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdMXSaaiCuentasAduaneras','AssignedTitles','numeric',1,9,14,2

	ALTER TABLE txdMXSaaiCuentasAduaneras --Your Table Here
	ALTER COLUMN AssignedTitles numeric(14,2) NOT NULL--your column here
	
	PRINT 'The [AssignedTitles] field for table [txdMXSaaiCuentasAduaneras] has been updated.'

	EXEC usp_DBACreateTableIndexes '','txdMXSaaiCuentasAduaneras' --Your Table Here

END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('MXTariffQuantity') --your column here
			AND Object_ID = OBJECT_ID('txdMXSaaiDischarges')) --Your Table Here
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdMXSaaiDischarges','MXTariffQuantity','numeric',1,9,18,5

	ALTER TABLE txdMXSaaiDischarges --Your Table Here
	ALTER COLUMN MXTariffQuantity numeric(18,5) NOT NULL--your column here
	
	PRINT 'The [MXTariffQuantity] field for table [txdMXSaaiDischarges] has been updated.'

	EXEC usp_DBACreateTableIndexes '','txdMXSaaiDischarges' --Your Table Here

END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('VINOrSerialNum') --your column here
			AND Object_ID = OBJECT_ID('txdMXSaaiMerchandises')) --Your Table Here
BEGIN

	ALTER TABLE txdMXSaaiMerchandises --Your Table Here
	ALTER COLUMN VINOrSerialNum varchar(25) NOT NULL--your column here
	
	PRINT 'The [VINOrSerialNum] field for table [txdMXSaaiMerchandises] has been updated.'

END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('PermitQty') --your column here
			AND Object_ID = OBJECT_ID('txdMXSaaiPermits')) --Your Table Here
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdMXSaaiPermits','PermitQty','numeric',1,9,18,5

	ALTER TABLE txdMXSaaiPermits --Your Table Here
	ALTER COLUMN PermitQty numeric(18,5) NOT NULL--your column here
	
	PRINT 'The [PermitQty] field for table [txdMXSaaiPermits] has been updated.'

	EXEC usp_DBACreateTableIndexes '','txdMXSaaiPermits' --Your Table Here

END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('HTSUOM') --your column here
			AND Object_ID = OBJECT_ID('txdMXSaaiComplimentaryExports')) --Your Table Here
BEGIN

	EXEC usp_DBACopyTableIndexesByColumn '','txdMXSaaiComplimentaryExports','HTSUOM','numeric',1,5,5,0

	ALTER TABLE txdMXSaaiComplimentaryExports --Your Table Here
	ALTER COLUMN HTSUOM numeric(5,0) NOT NULL--your column here
	
	PRINT 'The [HTSUOM] field for table [txdMXSaaiComplimentaryExports] has been updated.'

	EXEC usp_DBACreateTableIndexes '','txdMXSaaiComplimentaryExports' --Your Table Here

END