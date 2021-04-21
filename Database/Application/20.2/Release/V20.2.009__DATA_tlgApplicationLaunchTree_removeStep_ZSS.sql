IF 1=(	SELECT Count(t.partnerid) 
		FROM tlgApplicationLaunchTree t WITH (NOLOCK)
		INNER JOIN tlgApplicationLaunchTree s WITH (NOLOCK) 
			ON	s.PartnerID=t.PartnerID AND s.WorkFlow=t.WorkFlow 
				AND s.SequenceNo=t.SequenceNo AND s.Command = 'Validate PreReceipt / InvoiceLineGuid / Already Processed'
		)
	BEGIN
		update t
		set SequenceNo = SequenceNo - 1
		FROM tlgApplicationLaunchTree t 
		where  SequenceNo > (	select Max(SequenceNo) 
								from tlgApplicationLaunchTree s WITH (NOLOCK)
								where Command = 'Validate PreReceipt / InvoiceLineGuid / Already Processed' and s.WorkFlow = t.Workflow and s.PartnerID=t.PartnerID)
	END

DELETE FROM tlgApplicationLaunchTree WHERE Command = 'Validate PreReceipt / InvoiceLineGuid / Already Processed'