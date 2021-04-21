IF EXISTS (select TOP 1 1 from sys.tables where Name = 'txdabiCBPReferenceIdentifiers' 
            AND Type = 'U')
BEGIN    
    print('Table Exists')  
end
ELSE
BEGIN  
 

    CREATE TABLE [dbo].[txdabiCBPReferenceIdentifiers](
            [PartnerID] [int] NOT NULL,
            [EffDate] [datetime] NOT NULL,
            [ReferenceQualifier_NF91] [varchar](1) NOT NULL,
            [ReferenceID_NF91] [varchar](56) NOT NULL,
            [ReferenceQualifier_NF92] [varchar](3) NOT NULL,
            [ReferenceID_NF92] [varchar](50) NOT NULL,
            [AdmissionNum] [varchar](20) NOT NULL,
            [ContainerNum] [varchar](15) NOT NULL,
            [CarrierCode] [varchar](4) NOT NULL,
			[FlightNum] [varchar](15) NOT NULL,
			[ArrivalDate] datetime NOT NULL,
			[ActiveFlag] [varchar](1) NOT NULL,
            [DeletedFlag] [varchar](1) NOT NULL,
            [KeepDuringRollback] [varchar](1) NOT NULL
        ) ON [PRIMARY]
        
        CREATE CLUSTERED INDEX [CIX_txdabiCBPReferenceIdentifiers] ON [dbo].[txdabiCBPReferenceIdentifiers] 
        (
            [EffDate] ASC
        )		

        ALTER TABLE [dbo].[txdabiCBPReferenceIdentifiers] ADD CONSTRAINT [PK_txdabiCBPReferenceIdentifiers] PRIMARY KEY NONCLUSTERED
        (
              [PartnerID] ASC,
              [ReferenceID_NF91] ASC,
              [ReferenceID_NF92] ASC,
              [AdmissionNum] ASC,
			  [ContainerNum] ASC

        )
   print('Table Created')

	END	