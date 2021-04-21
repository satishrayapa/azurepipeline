--Insert all necessary forms in the tmgForm
IF NOT EXISTS(SELECT TOP 1 1 FROM tmgForm where FormGUID = 'fmgGlobalCodesMaintenance_aspx' and Description = 'fmgGlobalCodesMaintenance_aspx' and SystemTypeID = 2)
BEGIN
	INSERT INTO tmgForm
	SELECT 'fmgGlobalCodesMaintenance_aspx', 'fmgGlobalCodesMaintenance_aspx', 2, getdate(), 'N', 'N'
END


IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Client Full Access Group' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Client Full Access Group'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'IP DTS Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'IP DTS Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'IP Full Access Group' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'IP Full Access Group'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client ABI Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client ABI Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client Content Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client Content Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client DPS Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client DPS Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client EV Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client EV Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client Export Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client Export Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client FTA Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client FTA Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client GC Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client GC Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client QPWP Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client QPWP Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client Drawback Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client Drawback Full Access'
END

IF NOT EXISTS(SELECT TOP 1 1 FROM tmgGroupAccess acc
				join tmgGroup grp ON grp.GroupGUID = acc.GroupGUID
				where acc.FormGUID = 'fmgGlobalCodesMaintenance_aspx' and grp.Description = 'Standard Client IMMEX Full Access' and acc.AccessType = 1)
BEGIN
	INSERT INTO tmgGroupAccess (GroupGUID, FormGUID, AccessType, EffDate, DeletedFlag, KeepDuringRollback)
	SELECT TOP 1 GroupGUID, 'fmgGlobalCodesMaintenance_aspx', '1', GETDATE(), 'N', 'N' from tmgGroup WHERE Description = 'Standard Client IMMEX Full Access'
END