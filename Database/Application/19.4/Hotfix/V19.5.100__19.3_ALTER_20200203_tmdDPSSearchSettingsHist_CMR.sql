--------------------------------------------------------------------------------------------------------------
--tmdDPSSearchSettingsHist
--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------
PRINT '.........CREATE/MODIFY tmdDPSSearchSettingsHist.............'
IF EXISTS (SELECT * FROM dbo.syscolumns WHERE name = 'PreFilterValue' AND ID = OBJECT_ID('tmdDPSSearchSettingsHist'))
	BEGIN
		PRINT 'Column Already Exists... Skipping'
	END
ELSE
	BEGIN
		if exists (select * from dbo.sysobjects where name = 'PK_tmdDPSSearchSettingsHist') 
			begin
				ALTER TABLE [dbo].[tmdDPSSearchSettingsHist] DROP CONSTRAINT [PK_tmdDPSSearchSettingsHist]
			end

		if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmp_tmdDPSSearchSettingsHist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
			begin
				DROP TABLE tmp_tmdDPSSearchSettingsHist
			end
		
		CREATE TABLE [dbo].[tmp_tmdDPSSearchSettingsHist](
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[SettingsID] [int] NOT NULL,
			[SettingsDescription] [varchar](100) NOT NULL,
			[SearchNameAddressOption] [varchar](3) NOT NULL,
			[ExcludedWordFlag] [varchar](1) NOT NULL,
			[EmbargoOnly] [varchar](1) NOT NULL,
			[ActivateNewLists] [varchar](1) NOT NULL,
			[RegListIds] [xml] NOT NULL,
			[Sanctions] [xml] NOT NULL,
			[NameSearchPercentage] [numeric](6, 2) NOT NULL,
			[AddressSearchPercentage] [numeric](6, 2) NOT NULL,
			[CitySearchPercentage] [numeric](6, 2) NOT NULL,
			[IncludeAddressLine1] [varchar](1) NOT NULL,
			[IncludeAddressLine2] [varchar](1) NOT NULL,
			[IncludeAddressLine3] [varchar](1) NOT NULL,
			[IncludeAddressLine4] [varchar](1) NOT NULL,
			[IncludeCity] [varchar](1) NOT NULL,
			[IncludeState] [varchar](1) NOT NULL,
			[IncludePostalCode] [varchar](1) NOT NULL,
			[SccActive] [varchar](1) NOT NULL,
			[IsfActive] [varchar](1) NOT NULL,
			[LastBatchDate] [datetime] NOT NULL,
			[LastListChangeDate] [datetime] NOT NULL,
			[DefaultEmailAddress] [varchar](150) NOT NULL,
			[ModifiedBy] [varchar](50) NOT NULL,
			[PreFilterValue] NUMERIC(6,2) NOT NULL DEFAULT 0.75, --your NEW columns here
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL,
		) ON [PRIMARY]
		
		if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdDPSSearchSettingsHist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
			begin
				PRINT 'INSERT INTO TEMP TABLE......'
				 EXEC(
				 'INSERT INTO [dbo].[tmp_tmdDPSSearchSettingsHist]
           ([PartnerID]
           ,[EffDate]
           ,[SettingsID]
           ,[SettingsDescription]
           ,[SearchNameAddressOption]
           ,[ExcludedWordFlag]
           ,[EmbargoOnly]
           ,[ActivateNewLists]
           ,[RegListIds]
           ,[Sanctions]
           ,[NameSearchPercentage]
           ,[AddressSearchPercentage]
           ,[CitySearchPercentage]
           ,[IncludeAddressLine1]
           ,[IncludeAddressLine2]
           ,[IncludeAddressLine3]
           ,[IncludeAddressLine4]
           ,[IncludeCity]
           ,[IncludeState]
           ,[IncludePostalCode]
           ,[SccActive]
           ,[IsfActive]
		   ,[LastBatchDate] 
		   ,[LastListChangeDate] 
		   ,[DefaultEmailAddress]
           ,[ModifiedBy]
           ,[DeletedFlag]
           ,[KeepDuringRollback])
           SELECT
           [PartnerID]
           ,[EffDate]
           ,[SettingsID]
           ,[SettingsDescription]
           ,[SearchNameAddressOption]
           ,[ExcludedWordFlag]
           ,[EmbargoOnly]
           ,[ActivateNewLists]
           ,[RegListIds]
		   ,''<sanctions/>''
		   ,[NameSearchPercentage]
		   ,[AddressSearchPercentage] 
			,[CitySearchPercentage]
			,[IncludeAddressLine1] 
			,[IncludeAddressLine2] 
			,[IncludeAddressLine3]
			,[IncludeAddressLine4] 
			,[IncludeCity] 
			,[IncludeState] 
			,[IncludePostalCode]
			,[SccActive] 
			,[IsfActive] 
			,[LastBatchDate] 
			,[LastListChangeDate] 
			,[DefaultEmailAddress]
		   , [ModifiedBy]
          ,[DeletedFlag]
           ,[KeepDuringRollback]
           from tmdDPSSearchSettingsHist
			')
			end

		if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdDPSSearchSettingsHist]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
			BEGIN
				PRINT ''
				PRINT 'DROP TABLE..........'
				DROP TABLE [dbo].[tmdDPSSearchSettingsHist]
			END
					
		PRINT ''
		PRINT 'RENAME TABLE....'
		PRINT ''
		EXECUTE sp_rename N'dbo.Tmp_tmdDPSSearchSettingsHist', N'tmdDPSSearchSettingsHist', 'OBJECT'
				
				
		PRINT ''
		PRINT 'CREATE PRIMARY KEY......'
		ALTER TABLE [dbo].[tmdDPSSearchSettingsHist] ADD CONSTRAINT
			PK_tmdDPSSearchSettingsHist PRIMARY KEY NONCLUSTERED 
			(
				[PartnerId] ASC,
				[EffDate] ASC,
				[SettingsID] ASC
			) WITH FILLFACTOR = 90 ON [PRIMARY]

		CREATE INDEX CIX_tmdDPSSearchSettingsHist on tmdDPSSearchSettingsHist (EffDate asc)

END
