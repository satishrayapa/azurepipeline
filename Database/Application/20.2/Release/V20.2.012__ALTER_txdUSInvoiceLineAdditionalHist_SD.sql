--================================================================
--txdUSInvoiceLineAdditionalHist SHCHEMA CHANGES 
--==============================================================

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'UnitADDepositValue' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditionalHist')) --Your Table Here
BEGIN
 EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditionalHist','UnitADDepositValue','numeric',1,'',38,20
	ALTER TABLE txdUSInvoiceLineAdditionalHist ALTER COLUMN UnitADDepositValue numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditionalHist' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'UnitCVDepositValue' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditionalHist')) --Your Table Here
BEGIN
 EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditionalHist','UnitCVDepositValue','numeric',1,'',38,20
  	ALTER TABLE txdUSInvoiceLineAdditionalHist ALTER COLUMN UnitCVDepositValue numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditionalHist' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'VisaQuantity' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditionalHist')) --Your Table Here
BEGIN
EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditionalHist','VisaQuantity','numeric',1,'',38,20
   	ALTER TABLE txdUSInvoiceLineAdditionalHist ALTER COLUMN VisaQuantity numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditionalHist' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'ADDQuantity' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditionalHist')) --Your Table Here
BEGIN
 EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditionalHist','ADDQuantity','numeric',1,'',38,20
  	ALTER TABLE txdUSInvoiceLineAdditionalHist ALTER COLUMN ADDQuantity numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditionalHist' --Your Table Here
END


IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'CVDQuantity' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditionalHist')) --Your Table Here
BEGIN
 EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditionalHist','CVDQuantity','numeric',1,'',38,20
	ALTER TABLE txdUSInvoiceLineAdditionalHist ALTER COLUMN CVDQuantity numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditionalHist' --Your Table Here
END

IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'SoftwoodExportCharges' --your column here
			AND Object_ID = OBJECT_ID('txdUSInvoiceLineAdditionalHist')) --Your Table Here
BEGIN
EXEC usp_DBACopyTableIndexesByColumn '','txdUSInvoiceLineAdditionalHist','SoftwoodExportCharges','numeric',1,'',38,20
	ALTER TABLE txdUSInvoiceLineAdditionalHist ALTER COLUMN SoftwoodExportCharges numeric(38,20)
EXEC usp_DBACreateTableIndexes '','txdUSInvoiceLineAdditionalHist' --Your Table Here
END

