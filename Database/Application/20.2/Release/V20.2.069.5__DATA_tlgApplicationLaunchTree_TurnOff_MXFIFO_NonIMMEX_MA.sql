--------------------------------------------------------------------------------------------------------------
--FOR DATA SCRIPT EXAMPLE
--so you can select partnerid instead of hardcoding it
--Make sure records don't already exists or remove them
----------------------------------------------------------------------------------------------------------------

 ----------------------------------------------------------------
 -- USER STORY: MX FIFO Driver Cleanup for non-IMMEX partners  --
 -- US#11376                                                   --
 -- TASK#11613                                                 --
 ----------------------------------------------------------------

DECLARE @COUNT INT, @WFCOUNT INT, @WorkFlow VARCHAR(255), @Reference VARCHAR(50), @IMMEX_FLAG BIT
DECLARE @MYTABLE TABLE(ID INT, SequenceNo INT)		
DECLARE @MYWORKFLOWS TABLE(ID INT IDENTITY, WorkFlow VARCHAR(255))
SET @IMMEX_FLAG = 0

-- Do the cleanup for the reference (ApplicationToLaunch) provided and for the following Workflows:
SET @Reference = 'dxdMXFifoDriver.dll'
INSERT INTO @MYWORKFLOWS (WorkFlow) VALUES ('FIFO'), ('FIFO_Rollback')

	-----------------------------------------------------------------------------------------------
 -- VALIDATE IF THIS IS A IMMEX PARTNER OR NOT BEFORE CONTINUE
	-----------------------------------------------------------------------------------------------
	if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[txdMXInvoiceHeader]')
					and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN 

		-- If the IMMEX Invoicing table exists and contains records, it's IMMEX.
		if (SELECT COUNT(*) FROM txdMXInvoiceHeader) > 0
			SET @IMMEX_FLAG = 1

	END
	-----------------------------------------------------------------------------------------------

IF (@IMMEX_FLAG = 'FALSE')
BEGIN

    if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tlgApplicationLaunchTree]')
					and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	BEGIN 

			-- Do the clean up Workflow by Workflow specified in the table.
			SET @WFCOUNT = 1
			WHILE @WFCOUNT <= (SELECT COUNT(*) FROM @MYWORKFLOWS)
			BEGIN

				SET @COUNT = 1
				DELETE FROM @MYTABLE 

				-- Select the WF Name.
				SELECT @WorkFlow = WorkFlow FROM @MYWORKFLOWS WHERE ID = @WFCOUNT

						Print 'NON-IMMEX Partner / Proceed with the [' + @WorkFlow + '] Workflow changes.'

							-- 1. Obtain the Max SequenceNo from tlgApplicationLaunchTree
								Declare @MaxSequence int

								SELECT	@MaxSequence = MAX(SequenceNo)
								  FROM tlgApplicationLaunchTree
								 WHERE Workflow IN (@WorkFlow)
								   AND PartnerID = (SELECT PartnerID from tmfDefaults)

							-- 2. Obtain the SequenceNo values for all the steps launching the <dxdMXFifoDriver> DLL
								INSERT INTO @MYTABLE (ID, SequenceNo)
								SELECT Row_Number() Over (Order By SequenceNo), SequenceNo	
								  FROM tlgApplicationLaunchTree
								 WHERE Workflow IN (@WorkFlow)
								   AND PartnerID = (SELECT PartnerID from tmfDefaults)
								   AND ApplicationToLaunch = @Reference
								Order By SequenceNo

							-- 3. Set PartnerID equal to zero to disable the step and the EffDate field as change reference
								UPDATE	tlgApplicationLaunchTree
								   SET	PartnerID = 0, EffDate = GETDATE()
								 WHERE Workflow IN (@WorkFlow)
								   AND PartnerID = (SELECT PartnerID from tmfDefaults)
								   AND ApplicationToLaunch = @Reference
	
							-- 4. SequenceNo correction logic in case of being necessary:
							-- This will be made per each sequence deleted, one by one
								WHILE @COUNT <= (SELECT COUNT(*) FROM @MYTABLE)
								BEGIN

									DECLARE @DELETED_SEQ INT

									SELECT @DELETED_SEQ = SequenceNo
									  FROM @MYTABLE
									 WHERE ID = @COUNT

									IF EXISTS (SELECT *
											  FROM tlgApplicationLaunchTree
											 WHERE Workflow IN (@WorkFlow)
											   AND PartnerID = (SELECT PartnerID from tmfDefaults)
											   AND SequenceNo = @DELETED_SEQ)

										PRINT 'Sequence was not affected for WF: [' + @WorkFlow + ']'
									ELSE
									BEGIN

										Declare @LIMIT INT
										SELECT @LIMIT = SequenceNo FROM @MYTABLE WHERE ID = @COUNT + 1
										if (@LIMIT)>0
											 print 'Use Next Sequence'
										 else
											 SET @LIMIT = @MaxSequence+ 1 -- 'Use the Max Sequence + 1								

										-- Update the SequenceNo to avoid gaps between each step
										UPDATE tlgApplicationLaunchTree
										   SET SequenceNo = SequenceNo - @COUNT, EffDate = GETDATE()
										 WHERE Workflow IN (@WorkFlow)
										   AND PartnerID = (SELECT PartnerID from tmfDefaults)
										   AND SequenceNo > @DELETED_SEQ AND SequenceNo < @LIMIT

										Print 'Sequence updated for WF: [' + @WorkFlow + ']'
										SET @LIMIT = 0
									END

									SET @COUNT = @COUNT + 1
								END

				SET @WFCOUNT = @WFCOUNT + 1		
			END
	END
	ELSE
		Print 'The table [tlgApplicationLaunchTree] does not exits / No actions taken'

END
ELSE
	Print 'This is an IMMEX Partner / No actions taken'