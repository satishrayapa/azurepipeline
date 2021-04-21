IF EXISTS (SELECT TOP 1 1 FROM sys.tables WHERE Name = 'txdAdjStatusHist' AND Type = 'U')
BEGIN
	UPDATE sc
	SET Transmitted = 'N'
	FROM txdAdjStatusHist sc
	LEFT JOIN txdabiTransactionStatus a WITH (NOLOCK) ON sc.PartnerID=a.PartnerID AND sc.NewReceiptDocID=a.ReferenceID
	WHERE a.PartnerID IS NULL

	UPDATE sc
	SET Transmitted = CASE  WHEN a.Status IN ('REJECTED','UNTRANSMITTED','READY TO TRANSMIT') THEN 'N' ELSE 'W' END
	FROM txdAdjStatusHist sc
	INNER JOIN txdabiTransactionStatus a WITH (NOLOCK) ON sc.PartnerID=a.PartnerID AND sc.NewReceiptDocID=a.ReferenceID
	WHERE a.Status IN ('TRANSMITTED','TRANSMITTING','REJECTED','UNTRANSMITTED','PLEASE RE-GENERATE','READY TO TRANSMIT')
END