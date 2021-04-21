IF NOT EXISTS (SELECT 1 FROM [dbo].[txdReportDefinitions] WHERE ReportName = 'OpenSQLQuery')
	INSERT INTO 
		[dbo].[txdReportDefinitions]
		(EffDate
		,ReportName
		,ReportApplication
		,DeletedFlag
		,KeepDuringRollback) 
	VALUES 
		(GETDATE()
		,'OpenSQLQuery'
		,'IntegrationPoint.Reports.OpenSqlQuery.dll'
		,'N'
		,'N') 
