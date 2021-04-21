IF EXISTS (select TOP 1 1 from sys.tables where Name = 'tmdspicountry' --Your Table Here
			AND Type = 'U')
BEGIN	
	update tmdspicountry 
	Set endeffdate = '12/31/2019' 
	where countryoforigin in ('CM', 'NE', 'CF', 'GM') and countryofexport in ('CM', 'NE', 'CF', 'GM') and SPI = 'D' and endeffdate = '12/31/9999'
END