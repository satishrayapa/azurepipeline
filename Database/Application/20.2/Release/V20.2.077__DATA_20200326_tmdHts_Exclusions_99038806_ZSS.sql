-- tmdhts_Exclusions inserts/updates
IF EXISTS (select * from dbo.sysobjects where id = object_id(N'[dbo].[tmdhts_Exclusions]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN  
	update tmdhts_exclusions
	set endeffdate = '2021-03-25 00:00:00.000'
	where	htsnum in ('8412210045','8413810040','8421210000','8421220000','8421990040','8431499095','8471706000','8501104020','8607211000','9027905650')
			and exclusion = '99038806'
			and countryoforigin = 'CN'
			and Starteffdate = '7/6/2018'


	update tmdhts_exclusions
	set EndEffDate = cast(EndEffDate as date)
	where cast(EndEffDate as time) > '00:00:00:000'
END