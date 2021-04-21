IF EXISTS (select * from dbo.sysobjects where id = object_id(N'dbo.txdCNPTR3ReconcilePCAvePrice') 
AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNPTR3ReconcilePCAvePrice] 
	(
		 [PartnerID] INT NOT NULL
		,[Effdate] DATETIME NOT NULL
		,[CNReconciliationHeaderGUID] VARCHAR(50) NOT NULL
		,[eHandbookNum] VARCHAR(20) NOT NULL
		,[ReconciliationTimes] VARCHAR(5) NOT NULL
		,[DeclarationGUID] VARCHAR(50) NOT NULL
		,[DeclarationDataGUID] VARCHAR(50) NOT NULL
		,[DecListGUID] VARCHAR(50) NOT NULL
		,[PCProductNum] VARCHAR(50) NOT NULL
		,[DeclaredUnitValue] NUMERIC(38,20) NOT NULL
		,[DeclaredQty] NUMERIC(38,20) NOT NULL
		,[DeclaredTotalValue] NUMERIC(38,20) NOT NULL
		,[DeclaredCurrencyCode] VARCHAR(10) NOT NULL
		,[ConvertedUnitValue] NUMERIC(38,20) NOT NULL
		,[ConvertedTotalValue] NUMERIC(38,20) NOT NULL
		,[ExchangeRate] NUMERIC(38,20) NOT NULL
		,[ConvertedCurrencyCode] VARCHAR(10) NOT NULL
		,[AverageUnitValue] NUMERIC(38,20) NOT NULL
		,[UserName] VARCHAR(15) NOT NULL
		,[DeletedFlag] VARCHAR(1) NOT NULL
		,[KeepDuringRollback] VARCHAR(1) NOT NULL
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdCNPTR3ReconcilePCAvePrice] ADD CONSTRAINT [PK_txdCNPTR3ReconcilePCAvePrice] PRIMARY KEY NONCLUSTERED 
		(
		 [PartnerID] ASC
		,[DeclarationGUID] ASC
      	,[DeclarationDataGUID] ASC
      	,[DecListGUID] ASC
		)
		
END