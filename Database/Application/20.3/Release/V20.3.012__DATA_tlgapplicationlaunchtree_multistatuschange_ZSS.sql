IF EXISTS (select TOP 1 1 from dbo.sysobjects where id = object_id(N'[dbo].[tlgApplicationLaunchTree]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN  
			INSERT INTO tlgApplicationLaunchTree ( PartnerID, EffDate, WorkFlow, SequenceNo, ApplicationToLaunch, Command, DeletedFlag, KeepDuringRollback )
			SELECT PartnerID, GetDate(), 'Multiple Status Change', 1, 'GTMLibrary.dll', 'Multiple Status Change Transmit', 'N', 'N'
			FROM tmfDefaults td WITH (NOLOCK)
			WHERE	EXISTS (SELECT TOP 1 1 FROM txdweeklyestheader WITH (NOLOCK) where effdate > '2015-01-01')	--FTZ		
					AND NOT EXISTS (
								SELECT TOP 1 1 FROM tlgApplicationLaunchTree WITH (NOLOCK)
								WHERE PartnerID = td.PartnerID AND WorkFlow = 'Multiple Status Change' AND Command='Multiple Status Change Transmit'
							)
	END