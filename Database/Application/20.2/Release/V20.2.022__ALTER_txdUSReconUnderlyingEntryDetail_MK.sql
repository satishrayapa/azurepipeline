-------------------------------------------------------------------------------------------------------------
--SCHEMA CHANGES TO ALL TABLES (except adding columns to the middle of table)
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, DO NOT USE THIS SCRIPT **
--Rule of thumb - do NOT drop a table unless you are adding a column to the middle of the table.
--If you are simply adding columns to the end of the table, drop [DeletedFlag] and [KeepDuringRollback]
--Add your columns, then re-add the two columns. 
--***Be Sure to Set Defaults
--------------------------------------------------------------------------------------------------------------
DECLARE @sql NVARCHAR(4000)
DECLARE @NumRows INT
SET @NumRows = 0
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdUSReconUnderlyingEntryDetail' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'EntrySummaryDate' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID('txdUSReconUnderlyingEntryDetail')) --Your Table Here
	BEGIN
			PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DeletedFlag' --Leave DeletedFlag here
				AND Object_ID = Object_ID('txdUSReconUnderlyingEntryDetail')) --Your Table Here
		BEGIN
			SELECT @NumRows = COUNT(*) FROM dbo.txdUSReconUnderlyingEntryDetail WITH (NOLOCK) --Your Table Here
			WHERE DeletedFlag <> 'N' or KeepDuringRollback <> 'N' 
		END
		
		IF @NumRows > 0
		BEGIN
			RAISERROR ('DeletedFlag and/or KeepDuringRollback contains non-default data and cannot be dropped.', 16, 1)
		END
		ELSE
		BEGIN
			WHILE 1 = 1
			BEGIN
				SELECT TOP 1 @sql = N'alter table [txdUSReconUnderlyingEntryDetail] ' --Your Table Here
						+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('txdUSReconUnderlyingEntryDetail') --Your Table Here
					AND [name] IN ( 'DeletedFlag', 'KeepDuringRollback' )
					AND default_object_id <> 0
					
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
				
				EXEC (@sql)
			END
			
			
			ALTER TABLE dbo.txdUSReconUnderlyingEntryDetail --Your Table Here
			DROP COLUMN DeletedFlag, KeepDuringRollback
										
			ALTER TABLE dbo.txdUSReconUnderlyingEntryDetail --Your Table Here
			ADD  
			EntrySummaryDate DATETIME NOT NULL DEFAULT '1/1/1900' --your NEW columns here
			,ImportDate DATETIME NOT NULL DEFAULT '1/1/1900' --your NEW columns here
			,DeletedFlag VARCHAR(1) NOT NULL DEFAULT 'N'
			,KeepDuringRollback VARCHAR(1) NOT NULL  DEFAULT 'N'
			
			WHILE 1 = 1 
			BEGIN
				SELECT TOP 1
				@sql = N'alter table [txdUSReconUnderlyingEntryDetail] ' --Your Table Here
					+ 'drop constraint [' + object_name(sc.default_object_id) + N']'
				FROM    sys.columns sc
				WHERE   OBJECT_ID = OBJECT_ID('txdUSReconUnderlyingEntryDetail') --Your Table Here
					AND [name] IN ( 'EntrySummaryDate','ImportDate' ) --your NEW columns here
					AND default_object_id <> 0
						
				IF @@ROWCOUNT = 0
				BEGIN
					BREAK
				END
						
				EXEC (@sql)
			END
			
			--Do not change 1st paramter.  
			--EXEC usp_DBACreateTableIndexes '','txdUSReconUnderlyingEntryDetail' --Your Table Here
		END
	END
END
SET @sql='IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = ''EntrySummaryDate'' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID(''txdUSReconUnderlyingEntryDetail'')) --Your Table Here
	BEGIN
			PRINT ''Update EntrySummary Date for entries that are paid using our system''
			update ed SET ed.EntrySummaryDate=s.paidDate
			FROM txdUSReconUnderlyingEntryDetail ed WITH (nolock) JOIN
			txdUSDailyStatementDetail sd WITH (NOLOCK) on sd.EntryNumber=ed.EntryNumber and sd.PartnerID=ed.PartnerID JOIN
			txdUSDailyStatementSummary s WITH ( NOLOCK) on s.StatementGUID=sd.StatementGUID AND sd.PartnerID=s.PartnerID
			WHERE ed.EntrySummaryDate=''1/1/1900''
					PRINT ''Update EntrySummary Date for entries that came through EV''
			update ed SET ed.EntrySummaryDate=ev.SummaryDate
			FROM txdUSReconUnderlyingEntryDetail ed WITH (nolock) JOIN
			txdUSEntryVisibility ev WITH (nolock) on ed.ReferenceGUID=ev.LineGUID AND ed.PartnerID=ev.PartnerID
			AND ed.ReferenceTable=''txdUSEntryVisibility''
			WHERE ed.EntrySummaryDate=''1/1/1900''
	END
		IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = ''ImportDate'' --Any 1 of your NEW columns here
				AND Object_ID = Object_ID(''txdUSReconUnderlyingEntryDetail'')) --Your Table Here
	BEGIN
			PRINT ''Update Import Date ''
			update ed SET ed.ImportDate=CASE WHEN ed.EntryType=''06'' THEN  eh.EstimatedEntryDate ELSE b.ImportDate END
			FROM txdUSReconUnderlyingEntryDetail ed WITH (nolock) JOIN
			txdUSEntryMap em WITH (NOLOCK) on em.ENtryMapGUID=ed.EntryMapGUID and 
			em.PartnerID=ed.PartnerID JOIN
			txdUSBillOfLading b WITH ( NOLOCK) on b.BillOfLadingGUID=em.BillOfLadingGUID AND
			 b.PartnerID=em.PartnerID JOIN txdUSEntryHeader eh WITH (NOLOCK) ON
			 eh.EntryGUID=em.ENtryGUID AND eh.PartnerID=em.PartnerID
			WHERE ed.ImportDate=''1/1/1900''
END'

EXEC (@sql)