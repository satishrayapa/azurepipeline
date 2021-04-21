IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tlgEventFlowMetadata]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN	
		PRINT 'Table Already Exists... Skipping'
	END
ELSE
	BEGIN
		CREATE TABLE [dbo].[tlgEventFlowMetadata] (
					[MetadataGUID] [uniqueidentifier] NOT NULL,
					[EventFlowGUID] [uniqueidentifier] NOT NULL,
					[EntityGUID] [uniqueidentifier] NOT NULL,
					[EntityType] [varchar] (20) NOT NULL,
					[MetadataKey] [varchar] (20) NOT NULL,
					[MetadataValue] [nvarchar] (4000) NOT NULL,
			CONSTRAINT [PK_tlgEventFlowMetadata] PRIMARY KEY CLUSTERED
			(
				  [MetadataGUID] ASC
			) ON [PRIMARY]
		) ON [PRIMARY]
		
		ALTER TABLE [dbo].[tlgEventFlowMetadata] WITH CHECK ADD CONSTRAINT [FK_tlgEventFlowMetadata_tlgEventFlow] FOREIGN KEY([EventFlowGUID])
		REFERENCES [dbo].[tlgEventFlow] ([EventFlowGUID])
		ON DELETE CASCADE
		
		ALTER TABLE [dbo].[tlgEventFlowMetadata] CHECK CONSTRAINT [FK_tlgEventFlowMetadata_tlgEventFlow]
	END