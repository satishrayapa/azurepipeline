
Declare @ServerName as Varchar(50);
IF (SELECT TOP 1 ServerName FROM tlgServerApplicationsAllowedToRun WITH (NOLOCK))=''
BEGIN SET @ServerName='server1' END
ELSE
BEGIN SET @ServerName=(SELECT TOP 1 ServerName FROM tlgServerApplicationsAllowedToRun WITH (NOLOCK)) 
END


--Update with correct partnerID
Declare @PartnerID as integer = 0;

IF EXISTS (SELECT * FROM tlgserverapplicationsallowedtorun WHERE ApplicationAllowedToRun = 'dxgSCCMail.dll')
BEGIN
	PRINT 'dxgSCCMail.dll record already exists on tlgserverapplicationsallowedtorun... skipping'
END
ELSE
BEGIN
	INSERT INTO tlgserverapplicationsallowedtorun
	SELECT getdate(), @ServerName, 'dxgSCCMail.dll', 'N','N'
END


IF EXISTS (SELECT * FROM tlgApplicationLaunchTree WHERE ApplicationToLaunch = 'dxgSCCMail.dll')
BEGIN
	PRINT 'dxgSCCMail.dll record already exists on tlgApplicationLaunchTree... skipping'
END
ELSE
BEGIN
	INSERT INTO tlgApplicationLaunchTree
	SELECT @PartnerID, getdate(), 'SCC Mail', 5, 'dxgSCCMail.dll', '','N','N'
END

IF EXISTS (SELECT * FROM tlgWorkflowSchedule WHERE Workflow = 'SCC Mail')
BEGIN
	PRINT 'Workflow SCC Mail record already exists on tlgWorkflowSchedule... skipping'
END
ELSE
BEGIN
	INSERT INTO tlgWorkflowSchedule
	SELECT @PartnerID, getdate(), newid(), 'SCC Mail', 'Y', '01:00', '','SCC Mail','',5,'N','N'
END

