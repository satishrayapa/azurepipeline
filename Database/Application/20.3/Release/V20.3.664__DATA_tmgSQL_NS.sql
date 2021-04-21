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
					'EF03A1EF-0E2D-4F30-9691-F3D7FBE18E24', 
					'PTR3ExcelDownload',
					N'--sheetnames::Component Balance Report
					SELECT
					ROW_NUMBER() OVER(ORDER BY PartNum ASC) AS LineNum
					,HandbookProductSeqNum AS CustomsItemID
					,PartNum AS PartNum
					,HSCode AS HSCode
					,ProductName AS CNName
					,TheoreticalRemainingQty AS TheoreticalRemainingQty
					,TheoreticalRemainingAmount AS TheoreticalRemainingAmount
					,ActualRemainingQty AS ActualRemainingQty
					,ImportOrExportTotalQty AS ImportOrExportTotalQty
					,TradePlusQty AS TradePlusQty
					,TradeMinusQty AS TradeMinusQty
					,TotalConsumptionQty AS TotalConsumptionQty
					,DomesticsSalesQty AS DomesticsSalesQty
					,FGReturnOrExportQty AS FGReturnReexport
					,FGReturnOrImportQty AS "Sending back FG produced for Import PM"
					,NetConsumptionQty AS NetConsumptionQty
					,VarianceQty AS VarianceQty
					,BegainingBalance AS BegainingBalance
					,PeriodRemainingQty AS RemainingQty
					,VarianceConfirmFlag AS "Variance Flag"
					,ModifyFlag AS ModifyFlag
					FROM txdCNReconciliationPCDetail WHERE CNReconciliationHeaderGUID = ''CNReconciliationHeaderGUIDVariable'' AND PartnerID = (select top 1 PartnerId from tmfDefaults) ORDER BY LineNum ASC', 
					GETDATE(),
					'', 
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
	End
END