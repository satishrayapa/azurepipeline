IF EXISTS (select * from dbo.sysobjects where id = object_id(N'dbo.txdCNPTR3HandbookReconcileQueueHist') 
AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	CREATE TABLE [dbo].[txdCNPTR3HandbookReconcileQueueHist] 
	(
		 [PartnerID] INT NOT NULL
		,[Effdate] DATETIME NOT NULL
		,[CNReconciliationHeaderGUID] VARCHAR(50) NOT NULL
		,[eHandbookNum] VARCHAR(20) NOT NULL
		,[ReconciliationTimes] VARCHAR(5) NOT NULL
		,[Status] VARCHAR(15) NOT NULL
		,[UserName] VARCHAR(15) NOT NULL
		,[DeletedFlag] VARCHAR(1) NOT NULL
		,[KeepDuringRollback] VARCHAR(1) NOT NULL	 
	) ON [PRIMARY]
		
		CREATE CLUSTERED INDEX [CIX_txdCNPTR3HandbookReconcileQueueHist] ON [dbo].[txdCNPTR3HandbookReconcileQueueHist] 
		(
			[EffDate] ASC
		)
		
END