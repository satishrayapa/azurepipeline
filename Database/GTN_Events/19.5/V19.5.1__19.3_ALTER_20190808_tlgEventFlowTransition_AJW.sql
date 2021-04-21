--Update the ParameterSQL field from length 2000 to 4000 and from varchar to nvarchar

IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tlgEventFlowTransition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN	
		ALTER TABLE tlgEventFlowTransition
		ALTER COLUMN ParameterSQL [nvarchar] (4000) NULL
	END