IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdCNStockValidationMessages' 
            AND Type = 'U')
BEGIN    
    PRINT('Table Exists')  
end
ELSE
BEGIN  
    CREATE TABLE [dbo].[txdCNStockValidationMessages](
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
        
        CREATE CLUSTERED INDEX [CIX_txdCNStockValidationMessages] ON [dbo].[txdCNStockValidationMessages] 
        (
            [EffDate] ASC
        )
        ALTER TABLE [dbo].[txdCNStockValidationMessages] ADD CONSTRAINT [PK_txdCNStockValidationMessages] PRIMARY KEY NONCLUSTERED
        (
              [PartnerID] ASC,
              [DeclarationGUID] ASC,
              [MessageGUID] ASC
        )
        ALTER TABLE [dbo].[txdCNStockValidationMessages] ADD CONSTRAINT [UN_txdCNStockValidationMessages] UNIQUE NONCLUSTERED
        (
              [MessageGUID]
        )

	END	