--------------------------------------------------------------------------------------------------------------
--ADD COLUMN TO MIDDLE OF TABLE ***NOT FOR REPORT TABLES***
--**IF THE DATA IN DELETEDFLAG and KEEPDURINGROLLBACK MUST BE MAINTAINED, USE THIS SCRIPT**
--If you are adding a column to the middle of the table and must drop and recreate.
----------------------------------------------------------------------------------------------------------------

PRINT '.........Add DashboardGUID column to txdElasticDashboardConfiguration if table exists or else Add txdElasticDashboardConfiguration table if not exists.............' --Your Table Here
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdElasticDashboardConfiguration' --Your Table Here
			AND Type = 'U')
BEGIN
	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name = 'DashboardGUID' --NEW column here
				AND Object_ID = Object_ID('txdElasticDashboardConfiguration')) --Your Table Here
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... Skipping.'
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdElasticDashboardConfiguration' --"tmp" + Your Table Here
					AND Type = 'U')
		begin
			DROP TABLE tmp_txdElasticDashboardConfiguration --"tmp" + Your Table Here
		end
		
		CREATE TABLE [dbo].[tmp_txdElasticDashboardConfiguration] --"tmp" + Your Table Here
		(
			[PartnerID] [int] NOT NULL,
			[EffDate] [datetime] NOT NULL,
			[ElasticDashboardGUID] [uniqueidentifier] NOT NULL,
			[ObjectGUID] [uniqueidentifier] NOT NULL,
			[OwnerDashboard] [nvarchar](50) NOT NULL,
			[Link] [nvarchar](200) NOT NULL,
			[Priority] [nvarchar](50) NOT NULL,
			[DashboardGUID] [uniqueidentifier] NOT NULL,
			[DeletedFlag] [varchar](1) NOT NULL,
			[KeepDuringRollback] [varchar](1) NOT NULL
		)  ON [PRIMARY]
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdElasticDashboardConfiguration]) = 1 --Your Table Here
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO Tmp_txdElasticDashboardConfiguration (PartnerID,EffDate,ElasticDashboardGUID,ObjectGUID,OwnerDashboard,Link,Priority,DashboardGUID,DeletedFlag,KeepDuringRollback)
			SELECT PartnerID,EffDate,ElasticDashboardGUID,ObjectGUID,OwnerDashboard,Link,Priority,cast(''00000000-0000-0000-0000-000000000000'' as uniqueidentifier),DeletedFlag,KeepDuringRollback FROM txdElasticDashboardConfiguration TABLOCKX') --Your Table Here

		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdElasticDashboardConfiguration]) = 1 --"tmp" + Your Table Here
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes ''
				,'txdElasticDashboardConfiguration' --Your Table Here
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdElasticDashboardConfiguration] --Your Table Here
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdElasticDashboardConfiguration', N'txdElasticDashboardConfiguration', 'OBJECT' --Your Table Here
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes ''
			,'txdElasticDashboardConfiguration' --Your Table Here
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'tmp_txdElasticDashboardConfiguration' --"tmp" + Your Table Here
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [tmp_txdElasticDashboardConfiguration] --"tmp" + Your Table Here
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END

ELSE
BEGIN
--Creating the table if not exists already so that it will not break the elastic dashboard page
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[txdElasticDashboardConfiguration](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[ElasticDashboardGUID] [uniqueidentifier] NOT NULL,
	[ObjectGUID] [uniqueidentifier] NOT NULL,
	[OwnerDashboard] [nvarchar](50) NOT NULL,
	[Link] [nvarchar](200) NOT NULL,
	[Priority] [nvarchar](50) NOT NULL,
	[DashboardGUID] [uniqueidentifier] NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL,
 CONSTRAINT [PK_txdElasticDashboardConfiguration] PRIMARY KEY NONCLUSTERED 
(
	[PartnerID] ASC,
	[ElasticDashboardGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

PRINT 'Table txdElasticDashboardConfiguration is created'
END
