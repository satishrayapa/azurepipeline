IF NOT EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdfeerate' 
			AND Type = 'U')
	BEGIN
		PRINT 'Table is missing......'
	END
ELSE
	BEGIN	
		INSERT INTO tmdfeerate
		SELECT
		partnerid as partnerid,
		GETDATE() as effdate,
		'044' as classcode,
		'7/1/2020' as starteffdate,
		'9/30/2020' as endeffdate,
		.03 as advaloremrate,
		0 as minamount,
		0 as maxamount,
		'N' as deletedflag,
		'N' as keepduringrollback 
		FROM tmfdefaults td WITH (NOLOCK) 
		WHERE NOT EXISTS (SELECT Top 1 1 FROM tmdfeerate tf WITH (NOLOCK) WHERE tf.PartnerID = td.PartnerID AND classcode = '044' and starteffdate = '7/1/2020')
	END