PRINT '.........CREATE/MODIFY txdCNDeclarationMessage.............' 
IF EXISTS (SELECT TOP 1 1 FROM sys.tables
			WHERE Name = 'txdCNDeclarationMessage' 
			AND Type = 'U')
BEGIN
	
	IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('SysId' , 'OperCusRegCode','DelcareFlag')
			AND ID = OBJECT_ID('txdCNDeclarationMessage')	
		) = 3
	BEGIN
		PRINT ''
		PRINT 'Column Already Exists... '
		
	END
	ELSE
	BEGIN
		if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNDeclarationMessage' 
					AND Type = 'U')
		begin
			DROP TABLE Tmp_txdCNDeclarationMessage 
		end
		
		
		CREATE TABLE [dbo].[Tmp_txdCNDeclarationMessage](
	[PartnerId] [int] NOT NULL,
[EffDate] [datetime] NOT NULL,
[DeclarationGUID] [varchar](50) NOT NULL,
[DeclarationDataGUID] [varchar](50) NOT NULL,
[ResponseGUID] [varchar](50) NOT NULL,
[MessageGUID] [varchar](50) NOT NULL,
[SequenceNum] [int] NOT NULL,
[Origin] [nvarchar](10) NOT NULL,
[Status] [nvarchar](20) NOT NULL,
[UserGUID] [varchar](50) NOT NULL,
[UserName] [nvarchar](100) NOT NULL,
[Id] [varchar](50) NOT NULL,
[MsgType] [int] NOT NULL,
[FileName] [nvarchar](10) NOT NULL,
[Version] [nvarchar](20) NOT NULL,
[Description] [varchar](50) NOT NULL,
[CreateTime] [nvarchar](100) NOT NULL,
[From] [nvarchar](100) NOT NULL,
[To] [nvarchar](100) NOT NULL,
[CommonType] [nvarchar](100) NOT NULL,
[MsgStatus] [nvarchar](100) NOT NULL,
[SysId] [nvarchar](3) NOT NULL, --Added
[OperCusRegCode] [nvarchar](10) NOT NULL,--Added
[DelcareFlag] [nvarchar](1) NOT NULL,--Added
[KeepDuringRollback] [varchar](1) NOT NULL,
[DeletedFlag] [varchar](1) NOT NULL

) ON [PRIMARY]
		
		
		
		
		
		DECLARE @Before_HasData BIT;
		
		SET @Before_HasData=0

		IF (SELECT TOP 1 1 FROM [txdCNDeclarationMessage]) = 1 
		BEGIN
			SET @Before_HasData=1
		END
		
		PRINT ''
		PRINT 'INSERT INTO TEMP TABLE......'
		EXEC('INSERT INTO dbo.Tmp_txdCNDeclarationMessage (				
PartnerId,
EffDate,
DeclarationGUID,
DeclarationDataGUID,
ResponseGUID,
MessageGUID,
SequenceNum,
Origin,
Status,
UserGUID,
UserName,
Id,
MsgType,
FileName,
Version,
Description,
CreateTime,
From,
To,
CommonType,
MsgStatus,
SysId,
OperCusRegCode,
DelcareFlag,
KeepDuringRollback,
DeletedFlag
	            )
		SELECT 	
PartnerId,
EffDate,
DeclarationGUID,
DeclarationDataGUID,
ResponseGUID,
MessageGUID,
SequenceNum,
Origin,
Status,
UserGUID,
UserName,
Id,
MsgType,
FileName,
Version,
Description,
CreateTime,
From,
To,
CommonType,
MsgStatus,
'''',
'''',
'''',
KeepDuringRollback,
DeletedFlag
			FROM txdCNDeclarationMessage TABLOCKX' ) 


			 
				
				
		DECLARE @After_HasData BIT;

		SET @After_HasData=0

		IF (SELECT TOP 1 1 FROM [dbo].[Tmp_txdCNDeclarationMessage]) = 1 
		BEGIN
			SET @After_HasData=1
		END
		
		IF @Before_HasData = @After_HasData
		BEGIN
			PRINT ''
			PRINT 'APPLYING CHANGES......'
			
			EXEC usp_DBACopyTableIndexes '','txdCNDeclarationMessage' 
		
			PRINT ''
			PRINT 'DROP TABLE..........'
			DROP TABLE [txdCNDeclarationMessage] 
		
			PRINT ''
			PRINT 'RENAME TABLE....'
			
			EXECUTE sp_rename N'Tmp_txdCNDeclarationMessage', N'txdCNDeclarationMessage', 'OBJECT' 
			
			PRINT ''
			PRINT 'CREATE INDEXES...........'
			
			EXEC usp_DBACreateTableIndexes '','txdCNDeclarationMessage' 
		END
		ELSE
		BEGIN
			if exists (select TOP 1 1 from sys.tables where Name = 'Tmp_txdCNDeclarationMessage' 
					AND Type = 'U')
			BEGIN
				PRINT ''
				PRINT 'CHANGES CANNOT BE APPLIED......'
			
				PRINT ''
				PRINT 'DROP TMP TABLE..........'
				DROP TABLE [Tmp_txdCNDeclarationMessage] 
			END

			PRINT ''
			RAISERROR ('Error:  Changes rolled back to avoid data loss.', 16, 1)
		END
	END
END

