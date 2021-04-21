--------------------------------------------------------------------------------------------------------------
-- ADO # 26691
--------------------------------------------------------------------------------------------------------------

IF EXISTS (select TOP 1 1 from sys.tables where Name = 'ttdStagingMXInternalTracking' AND Type = 'U')
BEGIN	


	IF EXISTS (SELECT TOP 1 1 FROM sys.columns WHERE name in('ExpTempReImpGUID') --your columns here
			AND Object_ID = OBJECT_ID('txdFixedAssetHistory')) --Your Table Here

	BEGIN
		-- Insert new trackingtype SELASSETI for Fixed Asset (Field RPO11)
		INSERT INTO ttdStagingMXInternalTracking
		select sfp.PartnerID, GETDATE() AS EffDate, TxnNumGUID as TrackingGUID, 'SELASSETI' as TrackingType
				, ISNULL(ih.InvoiceNum, OrderNumShip) as InvoiceNum, 'FIXEDASSET' as Category, sfp.ProductNum, 0 as TxnQty, RPO11, 'Y' as KeepDuringPrevProcess, 'N' as DeletedFlag, 'N' as KeepDuringRollback
		from ttdStagingFIFOProcessing sfp WITH (NOLOCK)
				LEFT JOIN txdMXInvoiceHeader ih WITH (NOLOCK) ON (ih.PartnerID = sfp.PartnerID AND ih.InvoiceNum = sfp.OrderNumReceipt and sfp.OrderNumReceipt <> '')
		where RPO11 <> ''
		  AND RPO11 IN (SELECT DISTINCT ImportGUID from txdFixedAssetHistory WITH (NOLOCK) WHERE ImportGUID <> '')
		  AND AssignmentFlag = 'Y'
		  AND NOT EXISTS (SELECT 1 FROM ttdStagingMXInternalTracking it 
								  WHERE it.PartnerID = sfp.PartnerID AND TxnNumGUID = it.TrackingGUID AND it.TrackingType = 'SELASSETI')


		-- Insert new trackingtype SELASSETR for Fixed Asset (Field RPO13)
		INSERT INTO ttdStagingMXInternalTracking
		select sfp.PartnerID, GETDATE() AS EffDate, TxnNumGUID as TrackingGUID, 'SELASSETR' as TrackingType
				, ISNULL(ih.InvoiceNum, OrderNumShip) as InvoiceNum, 'FIXEDASSET' as Category, sfp.ProductNum, 0 as TxnQty, RPO13, 'Y' as KeepDuringPrevProcess, 'N' as DeletedFlag, 'N' as KeepDuringRollback
		from ttdStagingFIFOProcessing sfp WITH (NOLOCK)
				LEFT JOIN txdMXInvoiceHeader ih WITH (NOLOCK) ON (ih.PartnerID = sfp.PartnerID AND ih.InvoiceNum = sfp.OrderNumReceipt and sfp.OrderNumReceipt <> '')
		where RPO13 <> ''
		  AND RPO13 IN (SELECT DISTINCT ExpTempReImpGUID from txdFixedAssetHistory WITH (NOLOCK) WHERE ExpTempReImpGUID <> '')
		  AND AssignmentFlag = 'Y'
		  AND NOT EXISTS (SELECT 1 FROM ttdStagingMXInternalTracking it 
								  WHERE it.PartnerID = sfp.PartnerID AND TxnNumGUID = it.TrackingGUID AND it.TrackingType = 'SELASSETR')

	END
END 

