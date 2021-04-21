if not exists (SELECT * FROM sysobjects WHERE name = 'bck_tlgapplicationlaunchtree_20_3_PCShipments')
			BEGIN
				select * into bck_tlgapplicationlaunchtree_20_3_PCShipments
				from tlgApplicationLaunchTree with (nolock) where workflow = 'FIFO'
			END
			


if (select count(*) from tlgApplicationLaunchTree where workflow = 'FIFO' and command like 'PC Shipments Thread %'
and partnerID <> 0) = 4
BEGIN 
PRINT 'UPDATE Workflow'

DELETE tlgApplicationLaunchTree 
where workflow = 'FIFO'
and command like 'PC Shipments Thread %' and command != 'PC Shipments Thread 1'


update tlgApplicationLaunchTree set command = 'PC Parallel Threads 4' 
where workflow = 'FIFO' and command = 'PC Shipments Thread 1'

END
ELSE 
BEGIN 
PRINT 'No Changes Needed'
END 


