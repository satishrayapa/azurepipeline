IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmgSQL]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmfDefaults]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN
		IF Object_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
			Select * into #tmgSQL from dbo.tmgSQL where 1 = 2

				INSERT INTO #tmgSQL(
					PartnerID, 
					EffDate, 
					SQLGUID,                     
					SQLDescription, 
					SQLCmd, 
					TxnDate,
					SQLLongDescription, 
					DeletedFlag, 
					KeepDuringRollback)  
				(SELECT DISTINCT 
					PartnerID, 
					GETDATE(), 
					'89416F7C-1E18-4E1D-89B8-EB23A9AF88F5', 
					'BondedWarehouse-Delivery First Outbound Report',
					'SELECT	
						'''' AS InvoiceNum
						,sh.WHSheetID AS [WHSheet ID]
						,sh.InternalWHSheetID AS [InternalWHSheet ID]
						,sh.PreAuthorizationID AS [Pre-authorizationID]
						,sh.HandbookNum AS HandbookNum
						,shtr.DeclareDate AS [WHSheetDeclaration Date]
						,CASE WHEN shr.ManageResult=1 THEN shr.ManageDate ELSE '''' END AS [WHSheetApproval Date]
						FROM 
						txdCNStockHeadType sh WITH(NOLOCK)
						JOIN txdCNStockInfoResps shr WITH(NOLOCK)
						ON sh.CNStockHeadTypeGUID=shr.CNStockHeadTypeGUID
						AND sh.PartnerId=shr.PartnerId
						JOIN txdCNStockHeadTypeResps shtr WITH(NOLOCK)
						ON shr.CNStockHeadTypeGUID=shtr.CNStockHeadTypeGUID
						AND shr.CNStockInfoRespsGUID=shtr.CNStockInfoRespsGUID
						AND shr.PartnerId=shtr.PartnerId
						AND sh.PartnerId= (select top 1 PartnerId from tmfdefaults)',
					GETDATE(),
					'BondedWarehouse Look up Report-Delivery First Outbound Report',
					'N', 
					'N'
				FROM dbo.tmfDefaults)
			
			MERGE dbo.tmgSQL dt
				USING #tmgSQL te
					ON  dt.PartnerID	= te.PartnerID 		
					AND dt.SQLGUID		= te.SQLGUID						
			WHEN MATCHED
					THEN UPDATE SET
						dt.EffDate		= te.EffDate
						,dt.SQLDescription		= te.SQLDescription
						,dt.SQLCmd		= te.SQLCmd
						,dt.SQLLongDescription=te.SQLLongDescription
						,dt.TxnDate=te.TxnDate
						,dt.DeletedFlag		= te.DeletedFlag
						,dt.KeepDuringRollback		= te.KeepDuringRollback
			WHEN NOT MATCHED BY TARGET
					THEN INSERT (PartnerID, EffDate, SQLGUID, SQLDescription, SQLCmd, TxnDate, SQLLongDescription, DeletedFlag, KeepDuringRollback) 
					VALUES (te.PartnerID, te.EffDate, te.SQLGUID, te.SQLDescription, te.SQLCmd, te.TxnDate, te.SQLLongDescription, te.DeletedFlag, te.KeepDuringRollback);

			IF OBJECT_ID('tempdb..#tmgSQL') IS NOT NULL DROP TABLE #tmgSQL
	END
END
