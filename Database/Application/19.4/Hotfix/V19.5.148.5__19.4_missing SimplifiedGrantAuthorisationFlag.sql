

IF (	
		SELECT COUNT(*) FROM dbo.syscolumns
		WHERE name IN ('SimplifiedGrantAuthorisationFlag')
			AND ID = OBJECT_ID('txdDEImpResponse')	
		) = 1
begin
	print 'column already exists'
end
else
begin
	begin try alter TABLE [dbo].[txdDEImpResponse] add [SimplifiedGrantAuthorisationFlag] [varchar](1)  end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationCriteriaTypeAVUV] [varchar](1) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationDischargeBillFlagAVUV] [varchar](1) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationSimplifiedMovementFlagAVUV] [varchar](1) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationAdditionalInformationAVUV] [varchar](1) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationGuaranteeWaiverAVUV] [varchar](1) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationGuaranteeDescriptionAVUV] [nvarchar](512) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationTotalGuaranteeAmountAVUV] [numeric](11, 2) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [MonitoringCustomsOfficeAVUV] [varchar](8) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationIntendedActivityDetailDescriptionAVUV] [nvarchar](512) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationMainAccountingLineAVUV] [nvarchar](70) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationMainAccountingCountryAVUV] [varchar](2) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationMainAccountingPostcodeAVUV] [varchar](9) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationMainAccountingCityAVUV] [nvarchar](35) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationMainAccountingDistrictAVUV] [nvarchar](35) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationFirstPlaceLineAVUV] [nvarchar](70) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationFirstPlaceCountryAVUV] [varchar](2) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationFirstPlacePostcodeAVUV] [varchar](9) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationFirstPlaceCityAVUV] [nvarchar](35) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AuthorisationFirstPlaceDistrictAVUV] [nvarchar](35) end try begin catch end catch
	begin try alter TABLE [dbo].[txdDEImpResponse] add [AppealCustomsOfficeDEEmail] [nvarchar](256) end try begin catch end catch


end
