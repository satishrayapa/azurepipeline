
IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR1Message' 
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
	
	CREATE TABLE [dbo].[txdCNPTR1Message] 
	(
		  PartnerId				INT NOT NULL
		, EffDate				DATETIME NOT NULL
		, DeclarationGUID		VARCHAR(50) NOT NULL
		, DeclarationDataGUID   VARCHAR(50) NOT NULL
		, ResponseGUID			VARCHAR(50) NOT NULL
		, MessageGUID			VARCHAR(50) NOT NULL
		, SequenceNum			INT NOT NULL
		, Origin				NVARCHAR(10) NOT NULL
		, Status				NVARCHAR(20) NOT NULL
		, UserGUID				VARCHAR(50) NOT NULL
		, UserName				NVARCHAR(100) NOT NULL
		, Version				NVARCHAR(11) NOT NULL
		, Business_id			NVARCHAR(128) NOT NULL
		, Message_id			NVARCHAR(128) NOT NULL
		, File_name				NVARCHAR(128) NOT NULL
		, Message_type			NVARCHAR(16) NOT NULL
		, Sender_id				NVARCHAR(16) NOT NULL
		, Receiver_id			NVARCHAR(16) NOT NULL
		, Send_time				DATETIME NOT NULL
		, OperCusRegCode		NVARCHAR(10) NOT NULL
		, DelcareFlag			NVARCHAR(1) NOT NULL
		, KeepDuringRollback	VARCHAR(1) NOT NULL
		, DeletedFlag			VARCHAR(1) NOT NULL
	) ON [PRIMARY]
		
		ALTER TABLE [dbo].[txdCNPTR1Message] ADD CONSTRAINT [PK_txdCNPTR1Message] PRIMARY KEY NONCLUSTERED 
		(
			PartnerId ASC,
			DeclarationGUID ASC,
			DeclarationDataGUID ASC,
			ResponseGUID ASC	
		)
END

