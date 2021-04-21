IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNPTR4InfoResps'
            AND Type = 'U')
BEGIN    
    PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN
   CREATE TABLE [dbo].[txdCNPTR4InfoResps] 
		(
		[PartnerId] INT NOT NULL,
		[EffDate] DATETIME NOT NULL,
		[CNPTR4InfoRespsGUID] VARCHAR(50) NOT NULL,
		[eHandbookNum] NVARCHAR(64) NOT NULL,
		[Send_time] DATETIME NOT NULL,
		[Receiver_id] NVARCHAR(16) NOT NULL,
		[Sender_id] NVARCHAR(16) NOT NULL,
		[Message_type] NVARCHAR(16) NOT NULL,
		[File_name] NVARCHAR(128) NOT NULL,
		[Message_id] NVARCHAR(128) NOT NULL,
		[Business_id] NVARCHAR(128) NOT NULL,
		[Version] NVARCHAR(11) NOT NULL,
		[Pocket_id] NVARCHAR(128) NOT NULL,
		[Total_pocket_qty] INT NOT NULL,
		[Cur_pocket_no] INT NOT NULL,
		[Is_unstructured] NVARCHAR(1) NOT NULL,
		[EtpsPreentNo] NVARCHAR(64) NOT NULL,
		[BusinessId] NVARCHAR(64) NOT NULL,
		[TmsCnt] NUMERIC(19, 0) NOT NULL,
		[Typecd] NVARCHAR(1) NOT NULL,
		[ManageResult] NVARCHAR(4) NOT NULL,
		[ManageDate] DATETIME NOT NULL,
		[Rmk] NVARCHAR(255) NOT NULL,
		[Note] NVARCHAR(255) NOT NULL,
		[DeletedFlag] VARCHAR(1) NOT NULL,
		[KeepDuringRollback] VARCHAR(1) NOT NULL
		) ON [PRIMARY]
        

        ALTER TABLE [dbo].[txdCNPTR4InfoResps] ADD CONSTRAINT [PK_txdCNPTR4InfoResps] PRIMARY KEY NONCLUSTERED 
        (
        [PartnerId] ASC,
		[CNPTR4InfoRespsGUID] ASC
        )

		PRINT 'Table Created.....'
END



