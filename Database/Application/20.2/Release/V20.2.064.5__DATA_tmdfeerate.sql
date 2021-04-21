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
'4/1/2020' as starteffdate,
'6/30/2020' as endeffdate,
.05 as advaloremrate,
0 as minamount,
0 as maxamount,
'N' as deletedflag,
'N' as keepduringrollback 
FROM tmfdefaults  
WHERE
    NOT EXISTS (SELECT * FROM tmdfeerate WHERE classcode = '044' and starteffdate = '4/1/2020')
END