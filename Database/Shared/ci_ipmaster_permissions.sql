use ContentIntegration;
go
if (select top 1 1 from ContentIntegration.sys.sysusers where name='IP_App_GTM') = 1
	begin
	DROP USER [IP_App_GTM]
	CREATE USER [IP_App_GTM] FOR LOGIN [IP_App_GTM]
	ALTER ROLE [db_datareader] ADD MEMBER [IP_App_GTM]
	end
else
	begin
	CREATE USER [IP_App_GTM] FOR LOGIN [IP_App_GTM]
	ALTER ROLE [db_datareader] ADD MEMBER [IP_App_GTM]
	end
	;

use IPMaster;
go
if (select top 1 1 from IPMaster.sys.sysusers where name='IP_App_GTM') = 1
	begin
	DROP USER [IP_App_GTM]
	CREATE USER [IP_App_GTM] FOR LOGIN [IP_App_GTM]
	ALTER ROLE [db_owner] ADD MEMBER [IP_App_GTM]
	end
else
	begin
	CREATE USER [IP_App_GTM] FOR LOGIN [IP_App_GTM]
	ALTER ROLE [db_owner] ADD MEMBER [IP_App_GTM]
	end
	;
go
