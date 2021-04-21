BEGIN 
			INSERT INTO txdMainQueueABIHolds 
				SELECT DISTINCT 
					(SELECT PartnerID FROM tmfDefaults with (NOLOCK)) AS PartnerID,
					GETDATE() AS EffDate,
					NEWID() AS QueueGUID,
					h.PGAMapGUID AS PGAMapGUID,
					'' AS MessageSender,
					'' AS MessageRecipient,
					'' AS MessageID,
					'' AS Created,
					'' AS MessageOriginator,
					'' AS PurposeCode,											
					'GELLERT' AS MilestoneMessageRecipient,
					NEWID() AS MilestoneMessageID,
					ISNULL(h.ReceiptDocID, '') AS MilestoneTypeCode, 
					GETDATE() AS MilestoneTimeDateTime,
					'LT' AS MilestoneTimeTimeZone, 
					'EventTime' AS MilestoneTimeWhichTime, 
					ISNULL(h.SourceApplication, '') AS UserDefinedChar1,
					ISNULL(clas.HTSNum, '') AS UserDefinedChar2,
					ISNULL(h.EntryNumber, '') AS UserDefinedChar3,
					ISNULL(head.ImporterNumber, '') AS UserDefinedChar4,
					'Ready' AS Status,
					'ABI_Hold_XML_Extract' AS ExtractType,
					'N' AS DeletedFlag,
					'Y' AS KeepDuringRollback		
	        	FROM txdUSPGAMap h WITH (NOLOCK)
				LEFT JOIN txdUSInvoiceLineClassification clas WITH (NOLOCK)
				ON h.InvoiceLineGUID = clas.InvoiceLineGUID
				AND h.HTSNum = clas.HTSNum
				LEFT JOIN txdUSEntryHeader head WITH (NOLOCK)
				ON h.EntryGUID = head.EntryGUID

					WHERE NOT EXISTS (SELECT mast.PGAMapGUID
					FROM txdMainQueueABIHolds mast WITH (NOLOCK)                  
					INNER JOIN txdABIHoldAttributes attr WITH (NOLOCK)
					ON attr.QueueGUID = mast.QueueGUID)

			
			IF @@ROWCOUNT>0
			BEGIN
		
 INSERT INTO txdABIHoldAttributes
 SELECT DISTINCT 
					mast.PartnerID AS PartnerID,
					GETDATE() AS EffDate,
					mast.QueueGUID AS QueueGUID,	  
					NEWID() AS QueueAttributeGUID,
					'ProductCode' AS ReferenceIdType,
					ISNULL(line.PartNumber,'') AS ReferenceIdReference,	
					'N' AS DeletedFlag,
					'Y' AS KeepDuringRollback
				FROM txdMainQueueABIHolds mast WITH (NOLOCK)
				
				left JOIN txdUSPGAMap h WITH (NOLOCK)	
				
				ON mast.PGAMapGUID = h.PGAMapGUID and mast.[Status] = 'Ready'
				left JOIN  txdUSInvoiceLine line WITH (NOLOCK)
				ON line.InvoiceLineGUID = h.InvoiceLineGUID
									WHERE NOT EXISTS (SELECT attr.QueueGUID 
					FROM txdABIHoldAttributes attr WITH (NOLOCK)
						WHERE attr.QueueGUID = mast.QueueGUID 
						AND attr.ReferenceIdType = 'ProductCode' 
						AND attr.ReferenceIdReference = line.PartNumber)

	 INSERT INTO txdABIHoldAttributes			
				SELECT DISTINCT 
					mast.PartnerID AS PartnerID,
					GETDATE() AS EffDate,
					mast.QueueGUID AS QueueGUID,	  
					NEWID() AS QueueAttributeGUID,
					'ShipmentID' AS ReferenceIdType,
					ISNULL(invo.InvoiceNumber,'') AS ReferenceIdReference,
					'N' AS DeletedFlag,
					'Y' AS KeepDuringRollback
				FROM  txdMainQueueABIHolds mast WITH (NOLOCK) 
				LEFT JOIN txdUSPGAMap h WITH (NOLOCK)	
                ON mast.PGAMapGUID = h.PGAMapGUID 
				and mast.[Status] = 'Ready'
				LEFT JOIN txdUSInvoiceLine line WITH (NOLOCK)
				ON line.InvoiceLineGUID = h.InvoiceLineGUID
				LEFT JOIN txdUSInvoice invo WITH (NOLOCK)
				ON invo.InvoiceGUID = line.InvoiceGUID

					WHERE NOT EXISTS (SELECT attr.QueueGUID 
					FROM txdABIHoldAttributes attr WITH (NOLOCK)
						WHERE attr.QueueGUID = mast.QueueGUID 
						AND attr.ReferenceIdType = 'ShipmentID' 
						AND attr.ReferenceIdReference = invo.InvoiceNumber)

     INSERT INTO txdABIHoldAttributes        
			SELECT DISTINCT 
					h.PartnerID AS PartnerID,
					GETDATE() AS EffDate,
					mast.QueueGUID AS QueueGUID,	  
					NEWID() AS QueueAttributeGUID,
					'BLNumber' AS ReferenceIdType,
					ISNULL(ladi.MasterBill,'') AS ReferenceIdReference,
					'N' AS DeletedFlag,
					'Y' AS KeepDuringRollback
					
			from txdMainQueueABIHolds mast WITH (NOLOCK) 
             LEFT JOIN txdUSPGAMap h WITH (NOLOCK)	
			 ON
			 mast.PGAMapGUID = h.PGAMapGUID and mast.[Status] = 'Ready'
             LEFT JOIN txdUSBillOfLading ladi WITH (NOLOCK)
			 ON ladi.Consignee = h.Consignee
			 AND h.consignee<>''
			 					WHERE NOT EXISTS (SELECT attr.QueueGUID 
					FROM txdABIHoldAttributes attr WITH (NOLOCK)
						WHERE attr.QueueGUID = mast.QueueGUID 
						AND attr.ReferenceIdType = 'BLNumber' 
						AND attr.ReferenceIdReference = ladi.MasterBill)

		 INSERT INTO txdABIHoldAttributes			
					SELECT DISTINCT 
					h.PartnerID AS PartnerID,
					GETDATE() AS EffDate,
					mast.QueueGUID AS QueueGUID,	  
					NEWID() AS QueueAttributeGUID,
					'LineItemNumber' AS ReferenceIdType,
					ISNULL(line.InvoiceLineNumber,'') AS ReferenceIdReference,
					'N' AS DeletedFlag,
					'Y' AS KeepDuringRollback
					from txdMainQueueABIHolds mast WITH (NOLOCK) 
					LEFT JOIN txdUSPGAMap h WITH (NOLOCK)
					ON mast.PGAMapGUID = h.PGAMapGUID and mast.[Status] = 'Ready'
					LEFT JOIN txdUSInvoiceLine line WITH (NOLOCK)
					ON line.InvoiceLineGUID = h.InvoiceLineGUID
										WHERE NOT EXISTS (SELECT attr.QueueGUID 
					FROM txdABIHoldAttributes attr WITH (NOLOCK)
						WHERE attr.QueueGUID = mast.QueueGUID 
						AND attr.ReferenceIdType = 'LineItemNumber' 
						AND attr.ReferenceIdReference = line.InvoiceLineNumber)


			END
			END
