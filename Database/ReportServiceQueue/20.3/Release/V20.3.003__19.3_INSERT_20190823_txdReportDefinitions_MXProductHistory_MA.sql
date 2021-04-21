
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[txdReportDefinitions]') AND type in (N'U'))
BEGIN
	DECLARE @ReportName varchar(30) = 'MXProductHistory'
	DECLARE @ReportApplication varchar(100) = 'Integrationpoint.Reports.MXReports.dll'

	IF NOT EXISTS (SELECT ReportName FROM txdReportDefinitions WITH (NOLOCK) WHERE ReportName = @ReportName)
	BEGIN
		INSERT INTO txdReportDefinitions
		SELECT GETDATE(), @ReportName, @ReportApplication, 'N', 'N'
	END
END
ELSE
   PRINT 'The table [txdReportDefinitions] does not exists on this database.'