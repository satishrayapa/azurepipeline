IF EXISTS(SELECT * FROM [txdReportDefinitions]
              WHERE [ReportName] = 'InventoryAuditReport'
                AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll')
BEGIN
	UPDATE [txdReportDefinitions]
	SET [ReportName] = 'MXINVENTORYAUDIT'
	WHERE [ReportName] = 'InventoryAuditReport'
	  AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll'
END

IF EXISTS(SELECT * FROM [txdReportDefinitions]
              WHERE [ReportName] = 'TxnAuditReport'
                AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll')
BEGIN
	UPDATE [txdReportDefinitions]
	SET [ReportName] = 'MXTRANSACTIONAUDIT'
	WHERE [ReportName] = 'TxnAuditReport'
	  AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll'
END

IF EXISTS(SELECT * FROM [txdReportDefinitions]
              WHERE [ReportName] = 'ShipmentTransactionAudit'
                AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll')
BEGIN
	UPDATE [txdReportDefinitions]
	SET [ReportName] = 'MXSHIPMENTTRANSACTIONAUDIT'
	WHERE [ReportName] = 'ShipmentTransactionAudit'
	  AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll'
END

IF EXISTS(SELECT * FROM [txdReportDefinitions]
              WHERE [ReportName] = 'MXMultilevelBOMS'
                AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll')
BEGIN
	UPDATE [txdReportDefinitions]
	SET [ReportName] = 'MXMULTILEVELBOMS'
	WHERE [ReportName] = 'MXMultilevelBOMS'
	  AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll'
END

IF EXISTS(SELECT * FROM [txdReportDefinitions]
              WHERE [ReportName] = 'MXProductHistory'
                AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll')
BEGIN
	UPDATE [txdReportDefinitions]
	SET [ReportName] = 'MXPRODUCTHISTORY'
	WHERE [ReportName] = 'MXProductHistory'
	  AND [ReportApplication] = 'Integrationpoint.Reports.MXReports.dll'
END
