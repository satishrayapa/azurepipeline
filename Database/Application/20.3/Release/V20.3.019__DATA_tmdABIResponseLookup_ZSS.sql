IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdABIResponseLookup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN 
	Delete FROM tmdABIResponseLookup WHERE MSGIDCode LIKE '%ESND%'
	Delete FROM tmdABIResponseLookup WHERE MSGIDCode LIKE '%ESNR%'

	IF Object_ID('tempdb..#tmdABIResponseLookup') IS NOT NULL DROP TABLE #tmdABIResponseLookup
	
	Create Table #tmdABIResponseLookup(MSGIDCode Varchar(25), CBPResponse Varchar(3000))

	INSERT INTO #tmdABIResponseLookup(MSGIDCode, CBPResponse)  
	VALUES	
		('ESND1', 'Request for electronic invoice data only'),
		('ESND2', 'Request for the entry summary package'),
		('ESND3', 'Request for specific documents'),
		('ESND4', 'Entry summary rejected'),
		('ESND5', 'ACE entry summary inactivated'),
		('ESND6', 'Entry summary canceled'),
		('ESND7', 'Document receipt acknowledgement'),
		('ESND8', 'A Post Summary Correction (PSC) has been presented by another filer'),
		('ESNDP', 'PGA processing status information'),
		('ESNDQ', 'Quota accepted'),
		('ESNDE', 'TIB extension denied'),
		('ESNDR', 'A Post Summary Correction (PSC) Filed was rejected.'),

		('ESNR001','ES Header Change Required'),
		('ESNR002','Entry Type Change Required'),
		('ESNR003','Classification'),
		('ESNR004','Special Program Indicator'),
		('ESNR005','Value – Line Value'),
		('ESNR006','Value – Currency Conversion'),
		('ESNR007','Line Change – Duty'),
		('ESNR008','Line Change – Country of Origin'),
		('ESNR009','Line Change – Country of Export'),
		('ESNR010','AD/CVD Required'),
		('ESNR011','AD/CVD – Cash Deposit Required'),
		('ESNR012','AD/CVD –Scope Change'),
		('ESNR013','AD/CVD – Non-Reimbursement Statement Missing'),
		('ESNR014','Single Transaction Bond'),
		('ESNR015','Continuous Bond'),
		('ESNR016','Missing Invoice'),
		('ESNR017','Insufficient Invoice Description'),
		('ESNR018','OGA Certificate Required'),
		('ESNR019','Visa Required'),
		('ESNR020','Incorrect Fee'),
		('ESNR021','Incorrect Tax'),
		('ESNR022','Quota Issue'),
		('ESNR023','Recon Reject'),
		('ESNR997','CBP assessed PSC at previous entered version'),
		('ESNR998','Other');

	INSERT INTO tmdABIResponseLookup
		(PartnerID, EffDate, MSGIDCode, CBPResponse, IPResponse, DeletedFlag, KeepDuringRollback)
	SELECT PartnerID, GETDATE(), MSGIDCode, CBPResponse, '', 'N', 'N'
	FROM tmfDefaults, #tmdABIResponseLookup

	IF OBJECT_ID('tempdb..#tmdABIResponseLookup') IS NOT NULL DROP TABLE #tmdABIResponseLookup
END
