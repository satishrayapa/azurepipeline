IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tWorkflowDataTransformationProcessQuery' --Your Table Here
			AND Type = 'U')
BEGIN	
	PRINT 'Table Already Exists... Skipping'
END
ELSE
BEGIN

CREATE TABLE [dbo].[tWorkflowDataTransformationProcessQuery](
	[PartnerID] [int] NOT NULL,
	[EffDate] [datetime] NOT NULL,
	[WorkflowGUID] [varchar](50) NOT NULL,
	[DataTransformationQueryGUID] [varchar](50) NOT NULL,
	[TransformationProcessGUID] [varchar](50) NOT NULL,
	[TransformationProcessQueryGUID] [varchar](50) NOT NULL,
	[TransformationProcessQuery] [varchar](max) NOT NULL,
	[DeletedFlag] [varchar](1) NOT NULL,
	[KeepDuringRollback] [varchar](1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

END