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
					'521384C4-729D-4F95-92E3-A6F6C4976C63', 
					'L-HandbookDetailExcelDownload',
					N'--sheetnames::L-Handbook Detail
					SELECT					
					 LineNum AS CustomsApprovedPartID
					,ProductNum AS ProductNum
					,HSNum AS HSNum
					,ProductName AS ProductName
					,ProductSDE AS ProductSDE
					,OriginDestinationCountry AS "Origin/Destination Country"
					,DeclareUOM AS DeclareUOM
					,CustomsUOM AS CustomsUOM
					,SecondCustomsUOM AS "2ndCustomsUOM"
					,DeclareUnitPrice AS DeclareUnitPrice
					,Currency AS Currency
					,StorageEndDate AS StorageEndDate
					,ModifyMark AS ModifyMark
					,AppendSheetID AS AppendSheetID
					,AppendSheetSeqID AS AppendSheetSeqID
					,Remark AS Remark
					FROM txdCNLogisticsHBDetails WHERE CNLogisticsHBHeaderGUID = ''CNLogisticsHBHeaderGUIDVariable'' AND PartnerID = (select top 1 PartnerId from tmfDefaults) ORDER BY EffDate ASC', 
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