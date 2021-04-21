--------------------------------------------------------------------------------------------------------------
--txdUSInvoiceLineAdditional SHCHEMA CHANGES 
--------------------------------------------------------------------------------------------------------------

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'UnitADDepositValue' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditional')) --Your Table Here
BEGIN
 EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditional','UnitADDepositValue','numeric',1,'',38,20
   	ALTER TABLE txdUSInvoiceLineAdditional ALTER COLUMN UnitADDepositValue numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditional' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'UnitCVDepositValue' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditional')) --Your Table Here
BEGIN
EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditional','UnitCVDepositValue','numeric',1,'',38,20 
	ALTER TABLE txdUSInvoiceLineAdditional ALTER COLUMN UnitCVDepositValue numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditional' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'VisaQuantity' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditional')) --Your Table Here
BEGIN
EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditional','VisaQuantity','numeric',1,'',38,20
   	ALTER TABLE txdUSInvoiceLineAdditional ALTER COLUMN VisaQuantity numeric(38,20)
	EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditional' --Your Table Here

END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ADDQuantity' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditional')) --Your Table Here
BEGIN
EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditional','ADDQuantity','numeric',1,'',38,20
	ALTER TABLE txdUSInvoiceLineAdditional ALTER COLUMN ADDQuantity numeric(38,20)
	EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditional' --Your Table Here

END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CVDQuantity' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditional')) --Your Table Here
BEGIN
 EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditional','CVDQuantity','numeric',1,'',38,20
   	ALTER TABLE txdUSInvoiceLineAdditional ALTER COLUMN CVDQuantity numeric(38,20)
	EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditional' --Your Table Here

END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'SoftwoodExportCharges' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditional')) --Your Table Here
BEGIN
EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditional','SoftwoodExportCharges','numeric',1,'',38,20
	ALTER TABLE txdUSInvoiceLineAdditional ALTER COLUMN SoftwoodExportCharges numeric(38,20)
	EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditional' --Your Table Here

END
