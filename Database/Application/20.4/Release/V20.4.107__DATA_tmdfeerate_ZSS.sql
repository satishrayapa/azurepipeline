IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdfeerate]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	insert into tmdfeerate
	select
		partnerid as partnerid,
		getdate() as effdate,
		'044' as classcode,
		'10/1/2020' as starteffdate,
		'12/31/2020' as endeffdate,
		.03 as advaloremrate,
		0 as minamount,
		0 as maxamount,
		'N' as deletedflag,
		'N' as keepduringrollback
	from tmfdefaults
	where not exists (select * from tmdfeerate where classcode = '044' and starteffdate = '10/1/2020')
END