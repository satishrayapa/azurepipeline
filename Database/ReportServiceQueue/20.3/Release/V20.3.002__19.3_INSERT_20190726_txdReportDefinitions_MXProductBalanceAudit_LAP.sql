DECLARE @ReportName varchar(30) = 'MXProductBalanceAudit'
DECLARE @ReportApplication varchar(100) = 'Integrationpoint.Reports.MXReports.dll'

IF NOT EXISTS (SELECT ReportName FROM txdReportDefinitions WITH (NOLOCK) WHERE ReportName = @ReportName)
BEGIN
	INSERT INTO txdReportDefinitions
	SELECT GETDATE(), @ReportName, @ReportApplication, 'N', 'N'
END
