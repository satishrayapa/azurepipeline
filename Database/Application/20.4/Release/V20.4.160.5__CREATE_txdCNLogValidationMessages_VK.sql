IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNLogValidationMessages' 
            AND Type = 'U')
BEGIN    
    print('Table Exists')  
end
ELSE
BEGIN  
 

    CREATE TABLE [dbo].[txdCNLogValidationMessages](
            [PartnerID] [int] NOT NULL,
            [EffDate] [datetime] NOT NULL,
            [DeclarationGUID] [varchar](50) NOT NULL,
            [DeclarationDataGUID] [varchar](50) NOT NULL,
            [MessageGUID] [varchar](50) NOT NULL,
            [MessageTable] [varchar](50) NOT NULL,
            [MessageType] [varchar](50) NOT NULL,
            [Message] [nvarchar](max) NOT NULL,
            [Location] [nvarchar](max) NOT NULL,
            [DeletedFlag] [varchar](1) NOT NULL,
            [KeepDuringRollback] [varchar](1) NOT NULL
        ) ON [PRIMARY]
        
        CREATE CLUSTERED INDEX [CIX_txdCNLogValidationMessages] ON [dbo].[txdCNLogValidationMessages] 
        (
            [EffDate] ASC
        )

 

        ALTER TABLE [dbo].[txdCNLogValidationMessages] ADD CONSTRAINT [PK_txdCNLogValidationMessages] PRIMARY KEY NONCLUSTERED
        (
              [PartnerID] ASC,
              [DeclarationGUID] ASC,
              [MessageGUID] ASC
        )
        ALTER TABLE [dbo].[txdCNLogValidationMessages] ADD CONSTRAINT [UN_txdCNLogValidationMessages] UNIQUE NONCLUSTERED
        (
              [MessageGUID]
        )

 

        print('Table Created')

	END	