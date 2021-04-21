IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ImporterAddress','InvoiceCurrency','ProductNum','PreferenceCode1','PreferenceCode2',
														'SupplierID','SupplierName','ManufacturerId','TxnQtyUOM','WeightUOM','ProposalDeclarationID',
														'HandbookID','MOFCOMPermitID','FreightFeeCurrency','FreightFeeType','InsuranceFeeCurrency',
														'InsuranceFeeType','MiscellaneousFeeCurrency','MiscellaneousFeeType','ContractNum',
														'AddlRptQtyUOM','RptQtyUOM','IORNum','BrokerName','ConsigneeID','AttachDocCodes') --your column here
		AND Object_ID = OBJECT_ID('txdCNEntryVisibility')) --Your Table Here
BEGIN
	Declare @columnchanges as ColumnCheckTable

	Insert into @columnchanges 
	(ColumnName,ColumnType,ColumnLength,ColumnPrecision,ColumnScale)
	Values
		('ImporterAddress', 'nvarchar',100,0,0), -->nvarchar, varchar, any text type field will only need ColumnLength, Precision and Scale can be null, blank or 0
		('InvoiceCurrency', 'nvarchar',3,0,0),
		('ProductNum', 'nvarchar',50,0,0),
		('PreferenceCode1', 'nvarchar',10,0,0),
		('PreferenceCode2', 'nvarchar',10,0,0),
		('SupplierID', 'nvarchar',50,0,0),
		('SupplierName', 'nvarchar',100,0,0),
		('ManufacturerId', 'nvarchar',15,0,0),
		('TxnQtyUOM', 'nvarchar',10,0,0),
		('WeightUOM', 'nvarchar',4,0,0),
		('ProposalDeclarationID', 'nvarchar',100,0,0),
		('HandbookID', 'nvarchar',100,0,0),
		('MOFCOMPermitID', 'nvarchar',10,0,0),
		('FreightFeeCurrency', 'nvarchar',50,0,0),
		('FreightFeeType', 'nvarchar',50,0,0),
		('InsuranceFeeCurrency', 'nvarchar',50,0,0),
		('InsuranceFeeType', 'nvarchar',50,0,0),
		('MiscellaneousFeeCurrency', 'nvarchar',50,0,0),
		('MiscellaneousFeeType', 'nvarchar',50,0,0),
		('ContractNum', 'nvarchar',100,0,0),
		('AddlRptQtyUOM', 'nvarchar',100,0,0),
		('RptQtyUOM', 'nvarchar',100,0,0),
		('IORNum', 'nvarchar',20,0,0),
		('BrokerName', 'nvarchar',100,0,0),
		('ConsigneeID', 'nvarchar',100,0,0),
		('AttachDocCodes', 'nvarchar',100,0,0)


	exec usp_DBACopyTableIndexesByMultiColumn NULL,@TableName = 'txdCNEntryVisibility', @Columns = @columnchanges, @ForceCopy = 0


	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN ImporterAddress [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN InvoiceCurrency [nvarchar] (3) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN ProductNum [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN PreferenceCode1 [nvarchar] (10) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN PreferenceCode2 [nvarchar] (10) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN SupplierID [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN SupplierName [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN ManufacturerId [nvarchar] (15) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN TxnQtyUOM [nvarchar] (10) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN WeightUOM [nvarchar] (4) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN ProposalDeclarationID [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN HandbookID [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN MOFCOMPermitID [nvarchar] (10) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN FreightFeeCurrency [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN FreightFeeType [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN InsuranceFeeCurrency [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN InsuranceFeeType [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN MiscellaneousFeeCurrency [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN MiscellaneousFeeType [nvarchar] (50) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN ContractNum [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN AddlRptQtyUOM [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN RptQtyUOM [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN IORNum [nvarchar] (20) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN BrokerName [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN ConsigneeID [nvarchar] (100) NOT NULL --your column here

	ALTER TABLE txdCNEntryVisibility --Your Table Here
	ALTER COLUMN AttachDocCodes [nvarchar] (100) NOT NULL --your column here


	--Do not change 1st paramter.  
	EXEC usp_DBACreateTableIndexes '','txdCNEntryVisibility' --Your Table Here
End