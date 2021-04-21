/*
	This script creates SCC store procedures on Database
	RUN AGAINST SCC Partner DB.
*/

/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetAssignmentByRowGuid]    Script Date: 3/6/2020 1:27:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetAssignmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetAssignmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetAssignmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tAssignment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetCodesByCodeId]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetCodesByCodeId]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetCodesByCodeId] AS' 
END
GO

ALTER  PROCEDURE [dbo].[usp_autoGen_deletetCodesByCodeId] 
	@CodeId as int, 
	@PartnerId as int

 as  
	delete from tCodes
	where Codeid = @CodeId and PartnerId = @PartnerId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetCustomerRequestAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetCustomerRequestAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetCustomerRequestAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetCustomerRequestAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tCustomerRequestAttachment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetCustomerRequestByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetCustomerRequestByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetCustomerRequestByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetCustomerRequestByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tCustomerRequest
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetCustomerRequestNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetCustomerRequestNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetCustomerRequestNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetCustomerRequestNoteByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tCustomerRequestNote
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetDocumentRequestByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetDocumentRequestByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetDocumentRequestByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetDocumentRequestByRowGuid] 
@rowGuid as uniqueidentifier

 as  delete from tDocumentRequest
 where rowGuid = @rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetDocumentRequestDetailsByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetDocumentRequestDetailsByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetDocumentRequestDetailsByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetDocumentRequestDetailsByRowGuid] 
@rowGuid as uniqueidentifier

 as  delete from tDocumentRequestDetails
 where rowGuid = @rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetEmailAssociatedQuestionnairesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetEmailAssociatedQuestionnairesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetEmailAssociatedQuestionnairesByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetEmailAssociatedQuestionnairesByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tEmailAssociatedQuestionnaires
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetEmailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetEmailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetEmailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetEmailByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tEmail
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetEmailHistoryByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetEmailHistoryByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetEmailHistoryByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetEmailHistoryByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tEmailHistory
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetEmailTemplatesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetEmailTemplatesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetEmailTemplatesByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetEmailTemplatesByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tEmailTemplates
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetHistoryByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetHistoryByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetHistoryByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetHistoryByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tHistory
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetImportTmpByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetImportTmpByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetImportTmpByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetImportTmpByRowGuid] 
@rowGuid as uniqueidentifier

 as  delete from tImportTmp
 where rowGuid = @rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetImportTmpMappingByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetImportTmpMappingByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetImportTmpMappingByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetImportTmpMappingByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tImportTmpMapping
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetPartnerByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetPartnerByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetPartnerByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetPartnerByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tPartner
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetPartnerProductByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetPartnerProductByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetPartnerProductByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetPartnerProductByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tPartnerProduct
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetPartnerRelationshipByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetPartnerRelationshipByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetPartnerRelationshipByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetPartnerRelationshipByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tPartnerRelationship
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetPartnerRelationshipGroupByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetPartnerRelationshipGroupByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetPartnerRelationshipGroupByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetPartnerRelationshipGroupByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tPartnerRelationshipGroup
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetQuestionAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetQuestionAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetQuestionAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetQuestionAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tQuestionAttachment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetQuestionBodyByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetQuestionBodyByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetQuestionBodyByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetQuestionBodyByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tQuestionBody
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetQuestionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetQuestionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetQuestionByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetQuestionByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tQuestion
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetQuestionnaireStatusByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetQuestionnaireStatusByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetQuestionnaireStatusByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetQuestionnaireStatusByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tQuestionnaireStatus
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetQuestionResponseDefinitionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetQuestionResponseDefinitionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetQuestionResponseDefinitionByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetQuestionResponseDefinitionByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tQuestionResponseDefinition
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetQuestionResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetQuestionResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetQuestionResponseDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetQuestionResponseDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tQuestionResponseDetail
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetReminderByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetReminderByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetReminderByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetReminderByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tReminder
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetResponseAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetResponseAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetResponseAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetResponseAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tResponseAttachment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetResponseByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetResponseByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetResponseByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetResponseByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tResponse
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetResponseDetailAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetResponseDetailAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetResponseDetailAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetResponseDetailAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tResponseDetailAttachment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetResponseDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetResponseDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tResponseDetail
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetResponseDetailNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetResponseDetailNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetResponseDetailNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetResponseDetailNoteByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tResponseDetailNote
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetResponseNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetResponseNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetResponseNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetResponseNoteByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tResponseNote
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetSentQuestionAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetSentQuestionAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tSentQuestionAttachment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetSentQuestionBodyByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetSentQuestionBodyByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionBodyByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionBodyByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tSentQuestionBody
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetSentQuestionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetSentQuestionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tSentQuestion
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetSentQuestionnaireRulesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetSentQuestionnaireRulesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionnaireRulesByRowGuid] AS' 
END
GO
ALTER  PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionnaireRulesByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tSentQuestionnaireRules
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetSentQuestionResponseDefinitionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetSentQuestionResponseDefinitionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionResponseDefinitionByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionResponseDefinitionByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tSentQuestionResponseDefinition
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetSentQuestionResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetSentQuestionResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionResponseDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetSentQuestionResponseDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tSentQuestionResponseDetail
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetTemplateAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetTemplateAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetTemplateAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetTemplateAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tTemplateAttachment
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetTemplateDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetTemplateDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetTemplateDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetTemplateDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tTemplateDetail
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetTemplateHeaderByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetTemplateHeaderByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetTemplateHeaderByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetTemplateHeaderByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tTemplateHeader
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetTemplateRulesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetTemplateRulesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetTemplateRulesByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetTemplateRulesByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tTemplateRules
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetUserByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetUserByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetUserByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetUserByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tUser
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetViewTabAssociationsByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetViewTabAssociationsByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetViewTabAssociationsByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetViewTabAssociationsByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tViewTabAssociations
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetViewTabByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetViewTabByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetViewTabByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetViewTabByRowGuid] 
@RowGuid as uniqueidentifier 
as delete from tViewTab 
where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetViewTabSqlByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetViewTabSqlByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetViewTabSqlByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetViewTabSqlByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tViewTabSql
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_deletetViewTabSqlUsageByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_deletetViewTabSqlUsageByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_deletetViewTabSqlUsageByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_deletetViewTabSqlUsageByRowGuid] 
@RowGuid as uniqueidentifier

 as  delete from tViewTabSqlUsage
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_insertbmw]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_insertbmw]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_insertbmw] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_insertbmw] 
@Description as varchar ( 8000 ) 
 , @Body as varchar ( 8000 ) 
 , @Department as varchar ( 8000 ) 
 , @Category as varchar ( 8000 ) 
 , @Port as varchar ( 8000 ) 
 , @Industry as varchar ( 8000 ) 
 , @Region as varchar ( 8000 ) 
 , @Commodity as varchar ( 8000 ) 
 , @Shared as varchar ( 8000 ) 
 , @Allow_Notes as varchar ( 8000 ) 
 , @Allow_Attachments as varchar ( 8000 ) 
 , @Response_Type as varchar ( 8000 ) 
 , @Responses as varchar ( 8000 ) 

 as 


 insert into bmw
 ( Description , Body , Department , Category , Port , Industry , Region , Commodity , Shared , Allow_Notes , Allow_Attachments , Response_Type , Responses
 ) values ( 
@Description , @Body , @Department , @Category , @Port , @Industry , @Region , @Commodity , @Shared , @Allow_Notes , @Allow_Attachments , @Response_Type , @Responses ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttAssignment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttAssignment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttAssignment] AS' 
END
GO



--////////////////////////////////////////////////////////////////////SECOND PART////////////////////////////////////////////////////////////////////



--TAssignment insert

ALTER PROCEDURE [dbo].[usp_autoGen_inserttAssignment]   
@PartnerId as int  
 , @StatusGuid as uniqueidentifier  
 , @AssignmentTypeCodeId as int  
 , @AssignmentNum as int  
 , @SourceGuid as uniqueidentifier  
 , @SenderUserId as int  
 , @RecipientPartnerId as int  
 , @AssignedUserId as int  
 , @Status as nvarchar ( 50 )   
 , @lastAccessedDate as datetime  
 , @lastAccessedBy as int  
 , @AssignmentLevel as int  
 , @OriginalTemplateDetailRowGuid as uniqueidentifier  
 , @Skip as bit  
 
 as 
  begin  
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tAssignment  
 ( PartnerId , StatusGuid , AssignmentTypeCodeId , AssignmentNum , SourceGuid , SenderUserId , RecipientPartnerId , AssignedUserId , Status , lastAccessedDate , lastAccessedBy , AssignmentLevel , OriginalTemplateDetailRowGuid , Skip , RowGuid  
 ) values (   
@PartnerId , @StatusGuid , @AssignmentTypeCodeId , @AssignmentNum , @SourceGuid , @SenderUserId , @RecipientPartnerId , @AssignedUserId , @Status , @lastAccessedDate , @lastAccessedBy , @AssignmentLevel , @OriginalTemplateDetailRowGuid , @Skip , @RowGuid 
) ;  
select @RowGuid as RowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCodes]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCodes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCodes] AS' 
END
GO
--tcodes insert
ALTER PROCEDURE [dbo].[usp_autoGen_inserttCodes]   
@PartnerId as int  
 , @Encode as varchar ( 15 )   
 , @Decode as nvarchar ( 100 )   
 , @FieldName as varchar ( 50 )   
  
 as   
  begin
  
 insert into tCodes  
 ( PartnerId , Encode , Decode , FieldName  
 ) values (   
@PartnerId , @Encode , @Decode , @FieldName ) ;  
select IDENT_CURRENT('tCodes') as CodeId
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCulture]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCulture]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCulture] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttCulture] 
@PartnerId as int
 , @CultureId as varchar ( 10 ) 
 , @Name as varchar ( 30 ) 

 as 


 insert into tCulture
 ( PartnerId , CultureId , Name
 ) values ( 
@PartnerId , @CultureId , @Name ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCultureDefinitions]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCultureDefinitions]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCultureDefinitions] AS' 
END
GO


ALTER PROCEDURE [dbo].[usp_autoGen_inserttCultureDefinitions]   
@PartnerId as int  
 , @CultureGuid as varchar ( 10 )   
 , @FieldName as nvarchar ( 128 )   
 , @FieldTranslation as nvarchar ( 128 )   
  
 as   
  
  
 insert into tCultureDefinitions  
 ( PartnerId , CultureGuid , FieldName , FieldTranslation  
 ) values (   
@PartnerId , @CultureGuid , @FieldName , @FieldTranslation ) ; 







GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCultureMessages]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCultureMessages]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCultureMessages] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttCultureMessages] 
@PartnerId as int
 , @CultureId as varchar ( 10 ) 
 , @MessageId as varchar ( 50 ) 
 , @Message as text

 as 


 insert into tCultureMessages
 ( PartnerId , CultureId , MessageId , Message
 ) values ( 
@PartnerId , @CultureId , @MessageId , @Message ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCustomerRequest]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCustomerRequest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCustomerRequest] AS' 
END
GO
 -- tCustomerRequest insert
 
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttCustomerRequest]   
@Title as nvarchar ( 50 )   
 , @DateEntered as datetime  
 , @DatePlanned as datetime  
 , @DateReleased as datetime  
 , @State as bit  
 , @StatusCodeId as int  
 , @TypeCodeId as int  
 , @Description as nvarchar ( MAX )   
 , @CustomerStatusCodeId as int  
 , @CreateUserId as int  
 , @CreatePartnerId as int  
 , @FoundInCodeId as int  
 , @FixedInCodeId as int  
 , @AssignedUserId as int  
 , @Estimate as float ( 8 )   
 , @PriorityCodeId as int  
 , @SeverityCodeId as int  
 , @ComponentCodeId as int  
 , @ComponentTypeCodeId as int  
 , @ResolutionCodeId as int  
 , @DisplayToCustomer as bit  
 , @Archive as bit  
  
 as 
 begin  
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tCustomerRequest  
 ( Title , DateEntered , DatePlanned , DateReleased , State , StatusCodeId , TypeCodeId , Description , CustomerStatusCodeId , CreateUserId , CreatePartnerId , FoundInCodeId , FixedInCodeId , AssignedUserId , Estimate , PriorityCodeId , SeverityCodeId , ComponentCodeId , ComponentTypeCodeId , ResolutionCodeId , DisplayToCustomer , Archive , RowGuid  
 ) values (   
@Title , @DateEntered , @DatePlanned , @DateReleased , @State , @StatusCodeId , @TypeCodeId , @Description , @CustomerStatusCodeId , @CreateUserId , @CreatePartnerId , @FoundInCodeId , @FixedInCodeId , @AssignedUserId , @Estimate , @PriorityCodeId , @SeverityCodeId , @ComponentCodeId , @ComponentTypeCodeId , @ResolutionCodeId , @DisplayToCustomer , @Archive , @RowGuid ) ;  
select IDENT_CURRENT('tCustomerRequest') as CRNumber, @RowGuid as RowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCustomerRequestAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCustomerRequestAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCustomerRequestAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttCustomerRequestAttachment] 
@CRGuid as uniqueidentifier
 , @Name as varchar ( 256 ) 
 , @DisplayToCustomer as bit
 , @DateEntered as datetime
 , @CreateUserId as int
 , @CreatePartnerId as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tCustomerRequestAttachment
 ( CRGuid , Name , DisplayToCustomer , DateEntered , CreateUserId , CreatePartnerId , RowGuid
 ) values ( 
@CRGuid , @Name , @DisplayToCustomer , @DateEntered , @CreateUserId , @CreatePartnerId , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttCustomerRequestNote]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttCustomerRequestNote]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttCustomerRequestNote] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttCustomerRequestNote] 
@CRGuid as uniqueidentifier
 , @NoteTypeCodeId as int
 , @Note as varchar ( 8000 ) 
 , @DateEntered as datetime
 , @DisplayToCustomer as bit
 , @CreateUserId as int
 , @CreatePartnerId as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tCustomerRequestNote
 ( CRGuid , NoteTypeCodeId , Note , DateEntered , DisplayToCustomer , CreateUserId , CreatePartnerId , RowGuid
 ) values ( 
@CRGuid , @NoteTypeCodeId , @Note , @DateEntered , @DisplayToCustomer , @CreateUserId , @CreatePartnerId , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttDocumentRequest]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttDocumentRequest]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttDocumentRequest] AS' 
END
GO


 --TDocumentRequest insert
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttDocumentRequest]   
@requestId as uniqueidentifier  
 , @shortName as varchar ( 50 )   
 , @partnerId as int  
 , @partnerEmail as varchar ( 100 )   
 , @supplierShortName as varchar ( 50 )   
 , @supplierPartnerId as int  
 , @supplierMid as varchar ( 50 )   
 , @supplierEmail as varchar ( 1000 )   
 , @supplierUserId as int  
 , @emailBody as ntext  
 , @isReminder as bit  
 , @requestFilename as varchar ( 100 )   
 , @status as varchar ( 200 )   
 , @questionnaireRowGuid as uniqueidentifier  
 , @statusRowGuid as uniqueidentifier  
 , @receivedDate as datetime  
 , @sentDate as datetime  
 , @dueDate as datetime  
 , @reminderDate as datetime  
 , @entStatus as varchar ( 50 )   
  
 as begin  
declare @rowGuid as uniqueidentifier   
 set @rowGuid = NEWID()   
 insert into tDocumentRequest  
 ( requestId , shortName , partnerId , partnerEmail , supplierShortName , supplierPartnerId , supplierMid , supplierEmail , supplierUserId , emailBody , isReminder , requestFilename , status , questionnaireRowGuid , statusRowGuid , receivedDate , sentDate
 , dueDate , reminderDate , entStatus , rowGuid  
 ) values (   
@requestId , @shortName , @partnerId , @partnerEmail , @supplierShortName , @supplierPartnerId , @supplierMid , @supplierEmail , @supplierUserId , @emailBody , @isReminder , @requestFilename , @status , @questionnaireRowGuid , @statusRowGuid , @receivedDate , @sentDate , @dueDate , @reminderDate , @entStatus , @rowGuid ) ;  
select @rowGuid as rowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttDocumentRequestDetails]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttDocumentRequestDetails]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttDocumentRequestDetails] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttDocumentRequestDetails] 
@documentRequestRowGuid as uniqueidentifier
 , @detailId as uniqueidentifier
 , @shortName as varchar ( 50 ) 
 , @partnerId as int
 , @keyName as varchar ( 100 ) 
 , @keyValue as varchar ( 100 ) 
 , @keyDesc as varchar ( 1000 ) 
 , @docType as varchar ( 200 ) 
 , @questionRowGuid as uniqueidentifier
 , @questionniareRowGuid as uniqueidentifier
 , @sentQuestionRowGuid as uniqueidentifier
 , @assignmentRowGuid as uniqueidentifier
 , @statusRowGuid as uniqueidentifier
 , @responseRowGuid as uniqueidentifier
 , @copiedToDrs as bit

 as 
declare @rowGuid as uniqueidentifier 
 set @rowGuid = NEWID() 
 insert into tDocumentRequestDetails
 ( documentRequestRowGuid , detailId , shortName , partnerId , keyName , keyValue , keyDesc , docType , questionRowGuid , questionniareRowGuid , sentQuestionRowGuid , assignmentRowGuid , statusRowGuid , responseRowGuid , copiedToDrs , rowGuid
 ) values ( 
@documentRequestRowGuid , @detailId , @shortName , @partnerId , @keyName , @keyValue , @keyDesc , @docType , @questionRowGuid , @questionniareRowGuid , @sentQuestionRowGuid , @assignmentRowGuid , @statusRowGuid , @responseRowGuid , @copiedToDrs , @rowGuid ) ;
select @rowGuid as rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttEmail]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttEmail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttEmail] AS' 
END
GO
 --TEmail insert
   
  
ALTER  PROCEDURE [dbo].[usp_autoGen_inserttEmail]   
@PartnerId as int  
 , @SenderUserId as int  
 , @RecipientPartnerId as int  
 , @RecipientUserId as int  
 , @ToAddress as varchar ( 128 )   
 , @FromAddress as varchar ( 128 )   
 , @CCAddress as varchar ( 256 )   
 , @SendDate as datetime  
 , @Subject as nvarchar ( 256 )   
 , @Body as ntext  
 , @DueDate as datetime  
 , @ReminderDate as datetime  
 , @IsReminder as bit  
 , @ReminderNum as int  
 , @StatusGuid as uniqueidentifier  
 , @TemplateGuid as uniqueidentifier  
 , @AssignmentGuid as uniqueidentifier  
 , @Status as nvarchar ( 50 )   
 , @StatusDesc as nvarchar ( 2000 )   
 , @RetryNum as int   
 , @RetryDate as datetime  
 , @ForceAnswerOrder as varchar(1) = 0  
  
 as  
 begin 
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tEmail  
 ( PartnerId , SenderUserId , RecipientPartnerId , RecipientUserId , ToAddress , FromAddress , CCAddress , SendDate , Subject , Body , DueDate , ReminderDate , IsReminder , ReminderNum , StatusGuid , TemplateGuid , AssignmentGuid , Status , StatusDesc , RetryNum , RetryDate , ForceAnswerOrder, RowGuid  
 ) values (   
@PartnerId , @SenderUserId , @RecipientPartnerId , @RecipientUserId , @ToAddress , @FromAddress , @CCAddress , @SendDate , @Subject , @Body , @DueDate , @ReminderDate , @IsReminder , @ReminderNum , @StatusGuid , @TemplateGuid , @AssignmentGuid , @Status ,
 @StatusDesc , @RetryNum , @RetryDate , @ForceAnswerOrder, @RowGuid ) ;  
select @RowGuid as RowGuid  
  end

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttEmailAssociatedQuestionnaires]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttEmailAssociatedQuestionnaires]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttEmailAssociatedQuestionnaires] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_inserttEmailAssociatedQuestionnaires]
@PartnerId as int
, @EmailGuid as uniqueidentifier
, @TemplateRowGuid as uniqueidentifier
, @StatusRowGuid as uniqueidentifier
, @ReminderInterval as int = 0
as
declare @RowGuid as uniqueidentifier
set @RowGuid = NEWID()
insert into tEmailAssociatedQuestionnaires
( PartnerId , EmailGuid , TemplateRowGuid , StatusRowGuid , ReminderInterval, RowGuid
) values (
@PartnerId , @EmailGuid , @TemplateRowGuid , @StatusRowGuid , @ReminderInterval , @RowGuid ) ;
select @RowGuid as RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttEmailHistory]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttEmailHistory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttEmailHistory] AS' 
END
GO
 
  
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttEmailHistory]   
@EmailGuid as uniqueidentifier  
 , @PartnerId as int  
 , @SenderUserId as int  
 , @RecipientPartnerId as int  
 , @RecipientUserId as int  
 , @ToAddress as varchar ( 128 )   
 , @FromAddress as varchar ( 128 )   
 , @CCAddress as varchar ( 256 )   
 , @SendDate as datetime  
 , @Subject as nvarchar ( 256 )   
 , @Body as nvarchar(MAX)  
 , @DueDate as datetime  
 , @ReminderDate as datetime  
 , @IsReminder as bit  
 , @ReminderNum as int  
 , @StatusGuid as uniqueidentifier  
 , @TemplateGuid as uniqueidentifier  
 , @AssignmentGuid as uniqueidentifier  
 , @Status as nvarchar ( 50 )   
 , @StatusDesc as nvarchar ( 1000 )   
 , @RetryNum as int  
 , @RetryDate as datetime  
 , @LinkFollowed as bit  
  
 as   
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tEmailHistory  
 ( EmailGuid , PartnerId , SenderUserId , RecipientPartnerId , RecipientUserId , ToAddress , FromAddress , CCAddress , SendDate , Subject , Body , DueDate , ReminderDate , IsReminder , ReminderNum , StatusGuid , TemplateGuid , AssignmentGuid , Status , 
 StatusDesc , RetryNum , RetryDate , LinkFollowed , RowGuid  
 ) values (   
@EmailGuid , @PartnerId , @SenderUserId , @RecipientPartnerId , @RecipientUserId , @ToAddress , @FromAddress , @CCAddress , @SendDate , @Subject , @Body , @DueDate , @ReminderDate , @IsReminder , @ReminderNum , @StatusGuid , @TemplateGuid , @AssignmentGuid , @Status , @StatusDesc , @RetryNum , @RetryDate , @LinkFollowed , @RowGuid ) ;  
select @RowGuid as RowGuid


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttEmailSent]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttEmailSent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttEmailSent] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttEmailSent] 
@emailGuid as uniqueidentifier
 , @dateSent as datetime

 as 


 insert into tEmailSent
 ( emailGuid , dateSent
 ) values ( 
@emailGuid , @dateSent ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttEmailTemplates]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttEmailTemplates]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttEmailTemplates] AS' 
END
GO

  
 --TEmailTemplates insert    
     
       
ALTER PROCEDURE [dbo].[usp_autoGen_inserttEmailTemplates]         
@PartnerId as int        
 , @Description as nvarchar ( 100 )         
 , @Subject as nvarchar ( 256 )         
 , @Body as ntext       
 , @FromAddress as varchar ( 256 )      
 , @CCAddress as varchar ( 256 )        
 , @TemplateGuid as uniqueidentifier
 , @Active bit
      
        
 as     
 begin        
declare @RowGuid as uniqueidentifier         
 set @RowGuid = NEWID()         
 insert into tEmailTemplates        
 ( PartnerId , Description , Subject , Body , FromAddress , CCAddress , TemplateGuid , RowGuid , Active       
 ) values (         
@PartnerId , @Description , @Subject , @Body , @FromAddress , @CCAddress , @TemplateGuid , @RowGuid, @Active ) ;        
select @RowGuid as RowGuid    
end 


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttForm]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttForm]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttForm] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttForm] 
@FormName as varchar ( 128 ) 
 , @FormTitle as varchar ( 50 ) 
 , @FormType as varchar ( 50 ) 

 as 


 insert into tForm
 ( FormName , FormTitle , FormType
 ) values ( 
@FormName , @FormTitle , @FormType ) ;
select IDENT_CURRENT('tForm') as FormId
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttFormAccess]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttFormAccess]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttFormAccess] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttFormAccess] 
@FormId as int
 , @PartnerId as int
 , @GroupId as int
 , @AccessTypeCodeId as int

 as 


 insert into tFormAccess
 ( FormId , PartnerId , GroupId , AccessTypeCodeId
 ) values ( 
@FormId , @PartnerId , @GroupId , @AccessTypeCodeId ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttGroup]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttGroup] AS' 
END
GO
-- TGroup insert
ALTER PROCEDURE [dbo].[usp_autoGen_inserttGroup]   
@PartnerId as int  
 , @Description as nvarchar ( 50 )   
  
 as   
  
  begin
 insert into tGroup  
 ( PartnerId , Description  
 ) values (   
@PartnerId , @Description ) ;  
select IDENT_CURRENT('tGroup') as GroupId
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttGroupMembership]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttGroupMembership]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttGroupMembership] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttGroupMembership] 
@PartnerId as int
 , @GroupId as int
 , @UserId as int

 as 


 insert into tGroupMembership
 ( PartnerId , GroupId , UserId
 ) values ( 
@PartnerId , @GroupId , @UserId ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttHistory]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttHistory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttHistory] AS' 
END
GO
--THistory insert
ALTER PROCEDURE [dbo].[usp_autoGen_inserttHistory]   
@UserId as int  
 , @RowTable as varchar ( 50 )   
 , @ActionType as varchar ( 10 )   
 , @ActionDate as datetime  
 , @ActionDescription as ntext  
  
 as 
 begin  
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tHistory  
 ( UserId , RowGuid , RowTable , ActionType , ActionDate , ActionDescription  
 ) values (   
@UserId , @RowGuid , @RowTable , @ActionType , @ActionDate , @ActionDescription ) ;  
select IDENT_CURRENT('tHistory') as HistoryId, @RowGuid as RowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttImportTmp]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttImportTmp]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttImportTmp] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttImportTmp] 
@partnerid as int
 , @userId as int
 , @originalFilename as varchar ( 50 ) 
 , @importDate as datetime
 , @importType as varchar ( 50 ) 
 , @status as varchar ( 50 ) 

 as 
declare @rowGuid as uniqueidentifier 
 set @rowGuid = NEWID() 
 insert into tImportTmp
 ( partnerid , userId , originalFilename , importDate , importType , status , rowGuid
 ) values ( 
@partnerid , @userId , @originalFilename , @importDate , @importType , @status , @rowGuid ) ;
select @rowGuid as rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttImportTmpMapping]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttImportTmpMapping]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttImportTmpMapping] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttImportTmpMapping] 
@ImportGuid as uniqueidentifier
 , @PartnerId as int
 , @FileFieldName as varchar ( 100 ) 
 , @IPFieldName as varchar ( 100 ) 

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tImportTmpMapping
 ( ImportGuid , PartnerId , FileFieldName , IPFieldName , RowGuid
 ) values ( 
@ImportGuid , @PartnerId , @FileFieldName , @IPFieldName , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttmgSQL]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttmgSQL]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttmgSQL] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttmgSQL] 
@PartnerId as int
 , @EffDate as datetime
 , @SQLGUID as uniqueidentifier
 , @SQLDescription as varchar ( 50 ) 
 , @SQLCmd as varchar ( 50 ) 
 , @TxnDate as datetime
 , @DeletedFlag as varchar ( 1 ) 
 , @KeepDuringRollback as varchar ( 1 ) 

 as 


 insert into tmgSQL
 ( PartnerId , EffDate , SQLGUID , SQLDescription , SQLCmd , TxnDate , DeletedFlag , KeepDuringRollback
 ) values ( 
@PartnerId , @EffDate , @SQLGUID , @SQLDescription , @SQLCmd , @TxnDate , @DeletedFlag , @KeepDuringRollback ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttmgTask]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttmgTask]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttmgTask] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttmgTask] 
@EffDate as datetime
 , @TxnDate as datetime
 , @PartnerName as varchar ( 80 ) 
 , @ActionType as varchar ( 50 ) 
 , @Task as varchar ( 7500 ) 
 , @DaysAhead as int
 , @RemindDate as datetime
 , @UserLoginReminded as varchar ( 50 ) 
 , @UserLoginEntered as varchar ( 50 ) 
 , @Ext as varchar ( 50 ) 
 , @DeletedFlag as varchar ( 1 ) 
 , @KeepDuringRollback as varchar ( 1 ) 

 as 


 insert into tmgTask
 ( EffDate , TxnDate , PartnerName , ActionType , Task , DaysAhead , RemindDate , UserLoginReminded , UserLoginEntered , Ext , DeletedFlag , KeepDuringRollback
 ) values ( 
@EffDate , @TxnDate , @PartnerName , @ActionType , @Task , @DaysAhead , @RemindDate , @UserLoginReminded , @UserLoginEntered , @Ext , @DeletedFlag , @KeepDuringRollback ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttmp_TMUSA1]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttmp_TMUSA1]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttmp_TMUSA1] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttmp_TMUSA1] 
@PartnerId as int
 , @Description as varchar ( 2000 ) 
 , @Body as varchar ( 2000 ) 
 , @Department as varchar ( 2000 ) 
 , @Category as varchar ( 2000 ) 
 , @Port as varchar ( 2000 ) 
 , @Industry as varchar ( 2000 ) 
 , @Region as varchar ( 2000 ) 
 , @Commodity as varchar ( 2000 ) 
 , @Shared as varchar ( 2000 ) 
 , @Allow_Notes as varchar ( 2000 ) 
 , @Allow_Attachments as varchar ( 2000 ) 
 , @Response_Type as varchar ( 2000 ) 
 , @Responses as varchar ( 2000 ) 
 , @ID as varchar ( 2000 ) 

 as 


 insert into tmp_TMUSA1
 ( PartnerId , Description , Body , Department , Category , Port , Industry , Region , Commodity , Shared , Allow_Notes , Allow_Attachments , Response_Type , Responses , ID
 ) values ( 
@PartnerId , @Description , @Body , @Department , @Category , @Port , @Industry , @Region , @Commodity , @Shared , @Allow_Notes , @Allow_Attachments , @Response_Type , @Responses , @ID ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttmpCallaway]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttmpCallaway]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttmpCallaway] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttmpCallaway] 
@PartnerId as int
 , @companyName as varchar ( 2000 ) 
 , @abbreviation as varchar ( 2000 ) 
 , @vendor as varchar ( 2000 ) 
 , @importerNumber as varchar ( 2000 ) 
 , @address1 as varchar ( 2000 ) 
 , @address2 as varchar ( 2000 ) 
 , @city as varchar ( 2000 ) 
 , @state as varchar ( 2000 ) 
 , @country as varchar ( 2000 ) 
 , @postalCode as varchar ( 2000 ) 
 , @phone as varchar ( 2000 ) 
 , @fax as varchar ( 2000 ) 
 , @defaultReminder as varchar ( 2000 ) 
 , @sviCompanyName as varchar ( 2000 ) 
 , @sviNumber as varchar ( 2000 ) 
 , @firstName as varchar ( 2000 ) 
 , @lastName as varchar ( 2000 ) 
 , @username as varchar ( 2000 ) 
 , @title as varchar ( 2000 ) 
 , @department as varchar ( 2000 ) 
 , @contactphone as varchar ( 2000 ) 
 , @contactfax as varchar ( 2000 ) 
 , @email as varchar ( 2000 ) 
 , @inserted as bit

 as 


 insert into tmpCallaway
 ( PartnerId , companyName , abbreviation , vendor , importerNumber , address1 , address2 , city , state , country , postalCode , phone , fax , defaultReminder , sviCompanyName , sviNumber , firstName , lastName , username , title , department , contactphone , contactfax , email , inserted
 ) values ( 
@PartnerId , @companyName , @abbreviation , @vendor , @importerNumber , @address1 , @address2 , @city , @state , @country , @postalCode , @phone , @fax , @defaultReminder , @sviCompanyName , @sviNumber , @firstName , @lastName , @username , @title , @department , @contactphone , @contactfax , @email , @inserted ) ;
select IDENT_CURRENT('tmpCallaway') as rowid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttOpenQuery]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttOpenQuery]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttOpenQuery] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttOpenQuery] 
@PartnerID as int
 , @EffDate as datetime
 , @UserId as int
 , @OpenQuerySQL as text

 as 


 insert into tOpenQuery
 ( PartnerID , EffDate , UserId , OpenQuerySQL
 ) values ( 
@PartnerID , @EffDate , @UserId , @OpenQuerySQL ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartner]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartner]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartner] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartner]          
@Name as nvarchar ( 100 )          
, @ShortName as nvarchar ( 80 )          
, @Address1 as nvarchar ( 100 )          
, @Address2 as nvarchar ( 100 )          
, @Address3 as nvarchar ( 200 )          
, @City as varchar ( 50 )          
, @StateCodeId as int          
, @CountryCodeId as int          
, @PostalCode as varchar ( 15 )          
, @Phone as varchar ( 50 )          
, @Fax as varchar ( 15 )          
, @Active as bit          
, @DefaultReminderInterval as int          
, @DefaultPasswordChangeInterval as int          
, @PrimaryUserId as int          
, @SviUsername as varchar ( 128 )          
, @SviPassword as varchar ( 100 )          
, @SviCompanyName as varchar ( 50 )          
, @SviNumber as varchar ( 100 )          
, @PortOfExport as varchar( 50 ) = ''          
, @PartnerType as varchar ( 30 )          
, @EntPartnerId as varchar ( 50 )          
, @MID as varchar ( 50 )          
, @SendingEmailAsIp as bit          
, @SendingEmailAddress as varchar ( 128 )          
, @UpdateFlag as bit          
, @TabLimit as int          
, @FactoryNum as varchar ( 50 ) = ''          
, @ProductNum as varchar ( 40 ) = ''          
, @Nickname as nvarchar ( 80 ) = ''          
, @AutoSendCA as bit          
, @AnnualImportValue as varchar(50) = ''          
, @AnnualVolume as varchar(50) = ''          
, @DUNSNumber as varchar(50) = ''          
, @RequiresAccess as varchar(10) = ''        
, @Tier as varchar(100) = ''        
, @LastDateValidated as datetime = '01/01/1900'        
, @ParentCompanyName as nvarchar(100) = ''        
, @GPSLatitude as varchar(40) = ''        
, @GPSLongitude as varchar(40) = ''        
, @YearEstablished as varchar(4) = ''        
, @PublicPrivate as varchar(1) = ''        
, @WebsiteURL as varchar(250) = ''   
, @CADueDate as int  
, @ReminderIntervalCA as int
, @CARating as bit  
, @RenewQuestionnaire as bit      
as       
begin         
declare @RowGuid as uniqueidentifier          
set @RowGuid = NEWID()          
insert into tPartner          
( Name , ShortName , Address1 , Address2 , Address3 , City , StateCodeId , CountryCodeId , PostalCode , Phone , Fax , Active , DefaultReminderInterval , DefaultPasswordChangeInterval , PrimaryUserId , SviUsername , SviPassword , SviCompanyName , SviNumber, PortOfExport , PartnerType , EntPartnerId , MID , SendingEmailAsIp , SendingEmailAddress , UpdateFlag , TabLimit , RowGuid, FactoryNum, ProductNum, Nickname, NewRecord, AutoSendCA, AnnualImportValue, AnnualVolume, DUNSNumber, RequiresAccess, Tier,   
LastDateValidated, ParentCompanyName, GPSLatitude, GPSLongitude, YearEstablished, PublicPrivate, WebsiteURL, CADueDate,ReminderIntervalCA, CARating, RenewQuestionnaire) values (@Name , @ShortName , @Address1 , @Address2 , @Address3 , @City , @StateCodeId , @CountryCodeId , 
@PostalCode , @Phone , @Fax , @Active , @DefaultReminderInterval , @DefaultPasswordChangeInterval , @PrimaryUserId , @SviUsername , @SviPassword ,   
@SviCompanyName , @SviNumber , @PortOfExport , @PartnerType , @EntPartnerId , @MID , @SendingEmailAsIp , @SendingEmailAddress , @UpdateFlag , @TabLimit , @RowGuid, @FactoryNum, @ProductNum, @Nickname, 1, @AutoSendCA, @AnnualImportValue, @AnnualVolume,   
@DUNSNumber, @RequiresAccess, @Tier, @LastDateValidated, @ParentCompanyName, @GPSLatitude, @GPSLongitude, @YearEstablished, @PublicPrivate, @WebsiteURL, @CADueDate,@ReminderIntervalCA,@CARating, @RenewQuestionnaire );          
select IDENT_CURRENT('tPartner') as PartnerId, @RowGuid as RowGuid        
end 
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerAttachment] 
@AttachmentGuid as uniqueidentifier
 , @DateEntered as datetime
 , @PartnerId as int
 , @UserId as int
 , @Description as varchar ( 500 ) 
 , @Filename as varchar ( 256 ) 

 as 


 insert into tPartnerAttachment
 ( AttachmentGuid , DateEntered , PartnerId , UserId , Description , Filename
 ) values ( 
@AttachmentGuid , @DateEntered , @PartnerId , @UserId , @Description , @Filename ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerDataConnection]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerDataConnection]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerDataConnection] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerDataConnection] 
@PartnerId as int
 , @ServerName as varchar ( 50 ) 
 , @DatabaseUser as varchar ( 15 ) 
 , @DatabasePassword as varchar ( 50 ) 
 , @DatabaseName as varchar ( 128 ) 

 as 


 insert into tPartnerDataConnection
 ( PartnerId , ServerName , DatabaseUser , DatabasePassword , DatabaseName
 ) values ( 
@PartnerId , @ServerName , @DatabaseUser , @DatabasePassword , @DatabaseName ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerFactoryUpdate]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerFactoryUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerFactoryUpdate] AS' 
END
GO


ALTER  PROCEDURE [dbo].[usp_autoGen_inserttPartnerFactoryUpdate]  
   @PartnerID as int  
 , @ChildID as int  
 , @FactoryNum as varchar ( 50 ) =''  
 , @ChangedFlag as char(1) = 1  
 , @NewRecordFlag as char(1) = 0  
 as   
  
 insert into tPartnerFactoryUpdate  
   ( ParentID , ChildID, FactoryNum , ChangeDate , ChangedFlag, NewRecord)   
values ( @PartnerID , @ChildID , @FactoryNum , GetDate() , @ChangedFlag, @NewRecordFlag ) ; 
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerNote]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerNote]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerNote] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerNote] 
@NoteGuid as uniqueidentifier
 , @PartnerId as int
 , @UserId as int
 , @DateEntered as datetime
 , @Note as text

 as 


 insert into tPartnerNote
 ( NoteGuid , PartnerId , UserId , DateEntered , Note
 ) values ( 
@NoteGuid , @PartnerId , @UserId , @DateEntered , @Note ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerProduct]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerProduct]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerProduct] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerProduct] 
@PartnerID as int
 , @EffDate as datetime
 , @ProductNum as varchar ( 50 ) 
 , @ProductDesc as varchar ( 350 ) 
 , @ProductGuid as uniqueidentifier

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tPartnerProduct
 ( PartnerID , EffDate , RowGuid , ProductNum , ProductDesc , ProductGuid
 ) values ( 
@PartnerID , @EffDate , @RowGuid , @ProductNum , @ProductDesc , @ProductGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerRelationship]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerRelationship]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationship] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationship] 
@ParentId as int
 , @ChildId as int
 , @RelationshipTypeCodeId as int
 , @ReferenceCode as varchar ( 50 ) 
 , @ReferenceNumber as varchar ( 60 ) 
 , @PartnerTypeCodeId as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tPartnerRelationship
 ( ParentId , ChildId , RelationshipTypeCodeId , ReferenceCode , ReferenceNumber , PartnerTypeCodeId , RowGuid
 ) values ( 
@ParentId , @ChildId , @RelationshipTypeCodeId , @ReferenceCode , @ReferenceNumber , @PartnerTypeCodeId , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerRelationshipGroup]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerRelationshipGroup]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationshipGroup] AS' 
END
GO


ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationshipGroup]   
@PartnerRelationshipRowGuid as uniqueidentifier  
 , @ParentId as int  
 , @ChildId as int  
 , @GroupType as varchar ( 100 )   
  
as   
declare @RowGuid as uniqueidentifier   
set @RowGuid = NEWID()   
insert into tPartnerRelationshipGroup  
(PartnerRelationshipRowGuid , ParentId , ChildId , GroupType , RowGuid)
values 
(@PartnerRelationshipRowGuid , @ParentId , @ChildId , @GroupType , @RowGuid);  

select @RowGuid as RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerRelationshipParent]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerRelationshipParent]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationshipParent] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationshipParent]    
@PartnerRelationshipRowGuid as uniqueidentifier    
, @ImporterId as int    
, @ChildId as int    
, @ParentName as varchar ( 50 )    
   
as    
declare @RowGuid as uniqueidentifier    
set @RowGuid = NEWID()    
insert into tPartnerRelationshipParent    
( PartnerRelationshipRowGuid , ImporterId , ChildId , ParentName , RowGuid    
) values (    
@PartnerRelationshipRowGuid , @ImporterId , @ChildId , @ParentName , @RowGuid ) ;    
select @RowGuid as RowGuid   
  
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerRelationshipProcess]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerRelationshipProcess]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationshipProcess] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerRelationshipProcess] 
@PartnerRelationshipRowGuid as uniqueidentifier
 , @ParentId as int
 , @ChildId as int
 , @ProcessId as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tPartnerRelationshipProcess
 ( PartnerRelationshipRowGuid , ParentId , ChildId , PartnerProcessId, RowGuid
 ) values ( 
@PartnerRelationshipRowGuid , @ParentId , @ChildId , @ProcessId, @RowGuid ) ;
select @RowGuid as RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttPartnerScores]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttPartnerScores]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttPartnerScores] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttPartnerScores] 
@PartnerId as int
 , @DetailId as varchar ( 50 ) 
 , @DetailGuid as uniqueidentifier
 , @ScorePartnerId as int
 , @PartnerScore as float ( 8 ) 
 , @PartnerScoreStatus as varchar ( 50 ) 
 , @PartnerScoreDescription as varchar ( 50 ) 

 as 


 insert into tPartnerScores
 ( PartnerId , DetailId , DetailGuid , ScorePartnerId , PartnerScore , PartnerScoreStatus , PartnerScoreDescription
 ) values ( 
@PartnerId , @DetailId , @DetailGuid , @ScorePartnerId , @PartnerScore , @PartnerScoreStatus , @PartnerScoreDescription ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttQuestion]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttQuestion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttQuestion] AS' 
END
GO

--tQuestion Insert

ALTER PROCEDURE [dbo].[usp_autoGen_inserttQuestion]   
	@PartnerId as int   
	, @AllowNotes as bit   
	, @AllowAttachments as bit   
	, @ResponseTypeCodeId as int   
	, @Shared as bit   
	, @DepartmentCodeId as int   
	, @CategoryCodeId as int   
	, @PortCodeId as int   
	, @IndustryCodeId as int  
	, @RegionCodeId as int   
	, @ImportanceCodeId as int   
	, @WeightCodeId as int 
	, @Description as nvarchar ( 500 )   
	, @Active as bit   
	, @TypeCodeId as int
	, @Version as nvarchar (100)   
as  
begin 
	declare @RowGuid as uniqueidentifier   
	set @RowGuid = NEWID()   
	insert into tQuestion   
	( PartnerId , AllowNotes , AllowAttachments , ResponseTypeCodeId , Shared , DepartmentCodeId , CategoryCodeId , PortCodeId , IndustryCodeId , RegionCodeId , ImportanceCodeId , WeightCodeId , Description , Active , TypeCodeId , RowGuid , Version 
	) values (   
	@PartnerId , @AllowNotes , @AllowAttachments , @ResponseTypeCodeId , @Shared , @DepartmentCodeId , @CategoryCodeId , @PortCodeId , @IndustryCodeId , @RegionCodeId , @ImportanceCodeId , @WeightCodeId , @Description , @Active , @TypeCodeId , @RowGuid , @Version) ;  
	select @RowGuid as RowGuid   
end
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttQuestionAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttQuestionAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttQuestionAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttQuestionAttachment] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @UserId as int
 , @AttachmentTypeCodeId as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tQuestionAttachment
 ( QuestionGuid , PartnerId , AttachNum , OriginalFilename , DateEntered , UserId , AttachmentTypeCodeId , RowGuid
 ) values ( 
@QuestionGuid , @PartnerId , @AttachNum , @OriginalFilename , @DateEntered , @UserId , @AttachmentTypeCodeId , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttQuestionBody]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttQuestionBody]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttQuestionBody] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_inserttQuestionBody]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @CultureId as varchar ( 10 )     
 , @Body as nvarchar(MAX)    
    
 as     
declare @RowGuid as uniqueidentifier     
 set @RowGuid = NEWID()     
 insert into tQuestionBody    
 ( QuestionGuid , PartnerId , CultureId , Body , RowGuid    
 ) values (     
@QuestionGuid , @PartnerId , @CultureId , @Body , @RowGuid ) ;    
select @RowGuid as RowGuid




GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttQuestionnaireStatus]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttQuestionnaireStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttQuestionnaireStatus] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttQuestionnaireStatus]  
@PartnerId as int  
, @TemplateGuid as uniqueidentifier  
, @RecipientPartnerId as int  
, @DateSent as datetime  
, @LastAccessDate as datetime  
, @LastAccessUser as int  
, @LastReminderDate as datetime  
, @ReminderScheduled as bit  
, @StatusCodeId as int  
, @StatusDescription as nvarchar(MAX)  
, @DueDate as datetime  
, @Archive as bit  
, @ArchiveDate as datetime = '01/01/1900'  
, @Name as nvarchar ( 50 )  
, @Description as nvarchar ( 200 )  
, @DisplayDescription as nvarchar ( 4000 )  
, @GroupBy as varchar ( 50 )  
, @CategoryOrder as varchar ( 50 )  
, @TypeCodeId as int  
, @deleted as bit  
, @rating as varchar (1)  
, @ReminderInterval as int = 0
, @IsRenewed as bit = 0
as  
declare @RowGuid as uniqueidentifier  
set @RowGuid = NEWID()  
insert into tQuestionnaireStatus  
( PartnerId , TemplateGuid , RecipientPartnerId , DateSent , LastAccessDate , LastAccessUser ,  
LastReminderDate , ReminderScheduled , StatusCodeId , StatusDescription , DueDate , Archive , ArchiveDate , Name ,  
Description , DisplayDescription , GroupBy , CategoryOrder , TypeCodeId , RowGuid , deleted , rating, ReminderInterval, IsRenewed )  
values (  
@PartnerId , @TemplateGuid , @RecipientPartnerId , @DateSent , @LastAccessDate , @LastAccessUser ,  
@LastReminderDate , @ReminderScheduled , @StatusCodeId , @StatusDescription , @DueDate , @Archive , @ArchiveDate ,  
@Name , @Description , @DisplayDescription , @GroupBy , @CategoryOrder , @TypeCodeId , @RowGuid ,  
@deleted , @rating, @ReminderInterval, @IsRenewed) ;  
select @RowGuid as RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttQuestionResponseDefinition]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttQuestionResponseDefinition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttQuestionResponseDefinition] AS' 
END
GO
--tQuestionResponseDefinition insert

  
  
ALTER  PROCEDURE [dbo].[usp_autoGen_inserttQuestionResponseDefinition]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @ResponseNum as int    
 , @DisplayOrder as int    
 , @RiskRatingCodeId as int    
 , @NotesMandatory as bit  
 , @AttachmentsMandatory as bit   
 , @BestPractice as bit    
 , @Alert as bit    
 , @CorrectiveActionFlag as bit    
 , @CorrectiveAction as nvarchar (MAX)     
 , @FollowupRowGuid as uniqueidentifier    
 , @ResponseNote as varchar ( 1000 )     
    
 as  
 begin   
declare @RowGuid as uniqueidentifier     
 set @RowGuid = NEWID()     
 insert into tQuestionResponseDefinition    
 ( QuestionGuid , PartnerId , ResponseNum , DisplayOrder , RiskRatingCodeId , NotesMandatory , AttachmentsMandatory , BestPractice , Alert , CorrectiveActionFlag , CorrectiveAction , FollowupRowGuid , ResponseNote , RowGuid    
 ) values (     
@QuestionGuid , @PartnerId , @ResponseNum, @DisplayOrder , @RiskRatingCodeId , @NotesMandatory , @AttachmentsMandatory , @BestPractice , @Alert , @CorrectiveActionFlag , @CorrectiveAction , @FollowupRowGuid , @ResponseNote , @RowGuid ) ;    
select @RowGuid as RowGuid    
  end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttQuestionResponseDetail]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttQuestionResponseDetail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttQuestionResponseDetail] AS' 
END
GO
 
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttQuestionResponseDetail]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @CultureId as varchar ( 10 )   
 , @ResponseNum as int  
 , @DisplayText as nvarchar(MAX)  
  
 as   
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tQuestionResponseDetail  
 ( QuestionGuid , PartnerId , CultureId , ResponseNum , DisplayText , RowGuid  
 ) values (   
@QuestionGuid , @PartnerId , @CultureId , @ResponseNum , @DisplayText , @RowGuid ) ;  
select @RowGuid as RowGuid


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttReminder]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttReminder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttReminder] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttReminder] 
@TemplateGuid as uniqueidentifier
 , @SenderId as int
 , @RecipientId as int
 , @EmailGuid as uniqueidentifier
 , @ScheduledDate as datetime

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tReminder
 ( TemplateGuid , SenderId , RecipientId , EmailGuid , ScheduledDate , RowGuid
 ) values ( 
@TemplateGuid , @SenderId , @RecipientId , @EmailGuid , @ScheduledDate , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponse]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponse]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponse] AS' 
END
GO
 --tResponse insert
 
   
  
ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponse]     
@AssignmentGuid as uniqueidentifier    
 , @QuestionGuid as uniqueidentifier    
 , @ResponseRatingCodeId as int    
 , @NotesMandatory as bit  
 , @AttachmentsMandatory as bit   
 , @BestPractice as bit    
 , @Alert as bit    
 , @CorrectiveActionFlag as bit    
 , @CorrectiveAction as nvarchar (MAX)     
 , @AuditCodeId as int    
 , @AuditDate as datetime    
    
 as  
 begin   
declare @RowGuid as uniqueidentifier     
 set @RowGuid = NEWID()     
 insert into tResponse    
 ( AssignmentGuid , QuestionGuid , ResponseRatingCodeId , NotesMandatory , AttachmentsMandatory , BestPractice , Alert , CorrectiveActionFlag , CorrectiveAction , AuditCodeId , AuditDate , RowGuid    
 ) values (     
@AssignmentGuid , @QuestionGuid , @ResponseRatingCodeId , @NotesMandatory , @AttachmentsMandatory , @BestPractice , @Alert , @CorrectiveActionFlag , @CorrectiveAction , @AuditCodeId , @AuditDate , @RowGuid ) ;    
select @RowGuid as RowGuid  
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponseAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponseAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponseAttachment] AS' 
END
GO


ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponseAttachment] 
@ResponseGuid as uniqueidentifier
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 )
 , @gtnGuid as varchar ( 250 )  
 , @DateEntered as datetime
 , @PartnerId as int
 , @UserId as int
 , @AttachTypeCodeId as varchar ( 50 ) 

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tResponseAttachment
 ( ResponseGuid , AttachNum , OriginalFilename , DateEntered , PartnerId , UserId , AttachTypeCodeId , RowGuid, gtnGuid
 ) values ( 
@ResponseGuid , @AttachNum , @OriginalFilename , @DateEntered , @PartnerId , @UserId , @AttachTypeCodeId , @RowGuid, @gtnGuid ) ;
select @RowGuid as RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponseDetail]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponseDetail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponseDetail] AS' 
END
GO
--tResponseDetail insert
ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponseDetail]   
@ResponseGuid as uniqueidentifier  
 , @ResponseNum as int  
 , @ResponseRatingCodeId as int  
 , @Response as nvarchar ( 50 )
 , @Override as bit   
 , @OverrideNotes as ntext

 as  begin 
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tResponseDetail  
 ( ResponseGuid , ResponseNum , ResponseRatingCodeId , Response , RowGuid, Override, OverrideNotes  
 ) values (   
@ResponseGuid , @ResponseNum , @ResponseRatingCodeId , @Response , @RowGuid, @Override, @OverrideNotes ) ;  
select @RowGuid as RowGuid
end 


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponseDetail_bak]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponseDetail_bak]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponseDetail_bak] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponseDetail_bak] 
@ResponseGuid as uniqueidentifier
 , @ResponseNum as int
 , @ResponseRatingCodeId as int
 , @Response as text

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tResponseDetail_bak
 ( ResponseGuid , ResponseNum , ResponseRatingCodeId , Response , RowGuid
 ) values ( 
@ResponseGuid , @ResponseNum , @ResponseRatingCodeId , @Response , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponseDetailAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponseDetailAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponseDetailAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponseDetailAttachment] 
@ResponseGuid as uniqueidentifier
 , @ResponseDetailRowGuid as uniqueidentifier
 , @ResponseAttachmentRowGuid as uniqueidentifier

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tResponseDetailAttachment
 ( ResponseGuid , ResponseDetailRowGuid , ResponseAttachmentRowGuid , RowGuid
 ) values ( 
@ResponseGuid , @ResponseDetailRowGuid , @ResponseAttachmentRowGuid , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponseDetailNote]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponseDetailNote]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponseDetailNote] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponseDetailNote] 
@ResponseGuid as uniqueidentifier
 , @ResponseDetailRowGuid as uniqueidentifier
 , @ResponseNoteRowGuid as uniqueidentifier

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tResponseDetailNote
 ( ResponseGuid , ResponseDetailRowGuid , ResponseNoteRowGuid , RowGuid
 ) values ( 
@ResponseGuid , @ResponseDetailRowGuid , @ResponseNoteRowGuid , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttResponseNote]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttResponseNote]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttResponseNote] AS' 
END
GO
  
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttResponseNote]   
@ResponseGuid as uniqueidentifier  
 , @PartnerId as int  
 , @UserId as int  
 , @NoteNum as int  
 , @NoteTypeCodeId as int  
 , @Note as nvarchar(MAX)  
 , @DateEntered as datetime  
  
 as   
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tResponseNote  
 ( ResponseGuid , PartnerId , UserId , NoteNum , NoteTypeCodeId , Note , DateEntered , RowGuid  
 ) values (   
@ResponseGuid , @PartnerId , @UserId , @NoteNum , @NoteTypeCodeId , @Note , @DateEntered , @RowGuid ) ;  
select @RowGuid as RowGuid


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestion]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestion]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestion] AS' 
END
GO

--tSentQuestion Insert  
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestion]     
@OriginalQuestionGuid as uniqueidentifier     
, @PartnerId as int     
, @AllowNotes as bit     
, @AllowAttachments as bit     
, @ResponseTypeCodeId as int     
, @Shared as bit     
, @DepartmentCodeId as int     
, @CategoryCodeId as int     
, @PortCodeId as int     
, @IndustryCodeId as int     
, @RegionCodeId as int     
, @ImportanceCodeId as int     
, @WeightCodeId as int
, @Description as nvarchar ( 500 )     
, @Active as bit     
, @TypeCodeId as int     
, @OriginalRowGuid as uniqueidentifier     
as   begin  
declare @RowGuid as uniqueidentifier     
set @RowGuid = NEWID()     
insert into tSentQuestion     
( OriginalQuestionGuid , PartnerId , AllowNotes , AllowAttachments , ResponseTypeCodeId , Shared , DepartmentCodeId , CategoryCodeId , PortCodeId , IndustryCodeId , RegionCodeId , ImportanceCodeId , WeightCodeId , Description , Active , TypeCodeId , OriginalRowGuid , RowGuid     
) values (     
@OriginalQuestionGuid , @PartnerId , @AllowNotes , @AllowAttachments , @ResponseTypeCodeId , @Shared , @DepartmentCodeId , @CategoryCodeId , @PortCodeId , @IndustryCodeId , @RegionCodeId , @ImportanceCodeId , @WeightCodeId , @Description , @Active , @TypeCodeId , @OriginalRowGuid , @RowGuid ) ;     
select @RowGuid as RowGuid   
end   
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestionAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestionAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionAttachment] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @UserId as int
 , @AttachmentTypeCodeId as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tSentQuestionAttachment
 ( QuestionGuid , PartnerId , AttachNum , OriginalFilename , DateEntered , UserId , AttachmentTypeCodeId , RowGuid
 ) values ( 
@QuestionGuid , @PartnerId , @AttachNum , @OriginalFilename , @DateEntered , @UserId , @AttachmentTypeCodeId , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestionBody]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestionBody]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionBody] AS' 
END
GO
 
  ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionBody]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @CultureId as varchar ( 10 )   
 , @Body as nvarchar(MAX)  
 , @OriginalRowGuid as uniqueidentifier  
  
 as   
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tSentQuestionBody  
 ( QuestionGuid , PartnerId , CultureId , Body , OriginalRowGuid , RowGuid  
 ) values (   
@QuestionGuid , @PartnerId , @CultureId , @Body , @OriginalRowGuid , @RowGuid ) ;  
select @RowGuid as RowGuid


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestionnaireAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestionnaireAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionnaireAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionnaireAttachment] 
@StatusGuid as uniqueidentifier
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @PartnerId as int
 , @UserId as int
 , @AttachmentTypeCodeId as varchar ( 50 ) 
 , @OriginalRowGuid as uniqueidentifier

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tSentQuestionnaireAttachment
 ( StatusGuid , AttachNum , OriginalFilename , DateEntered , PartnerId , UserId , AttachmentTypeCodeId , OriginalRowGuid , RowGuid
 ) values ( 
@StatusGuid , @AttachNum , @OriginalFilename , @DateEntered , @PartnerId , @UserId , @AttachmentTypeCodeId , @OriginalRowGuid , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestionnaireRules]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestionnaireRules]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionnaireRules] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionnaireRules] 
@StatusGuid as uniqueidentifier
 , @AssignmentRowGuid as uniqueidentifier
 , @PartnerId as int
 , @SentQuestionRowGuid as uniqueidentifier
 , @SentQuestionResponseDefinitionRowGuid as uniqueidentifier
 , @ActionCodeId as int
 , @ResultQuestionRowGuid as uniqueidentifier
 , @RuleNote as varchar ( 1000 ) 

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tSentQuestionnaireRules
 ( StatusGuid , AssignmentRowGuid , PartnerId , SentQuestionRowGuid , SentQuestionResponseDefinitionRowGuid , ActionCodeId , ResultQuestionRowGuid , RuleNote , RowGuid
 ) values ( 
@StatusGuid , @AssignmentRowGuid , @PartnerId , @SentQuestionRowGuid , @SentQuestionResponseDefinitionRowGuid , @ActionCodeId , @ResultQuestionRowGuid , @RuleNote , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestionResponseDefinition]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestionResponseDefinition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionResponseDefinition] AS' 
END
GO
 --tSentQuestionResponseDefinition insert
 
   
  
ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionResponseDefinition]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @ResponseNum as int    
 , @DisplayOrder as int    
 , @RiskRatingCodeId as int    
 , @NotesMandatory as int   
 , @AttachmentsMandatory as int  
 , @BestPractice as bit    
 , @Alert as bit    
 , @CorrectiveActionFlag as bit    
 , @CorrectiveAction as nvarchar ( MAX )     
 , @FollowupRowGuid as uniqueidentifier    
 , @ResponseNote as varchar ( 1000 )     
 , @OriginalRowGuid as uniqueidentifier    
    
 as   begin  
declare @RowGuid as uniqueidentifier     
 set @RowGuid = NEWID()     
 insert into tSentQuestionResponseDefinition    
 ( QuestionGuid , PartnerId , ResponseNum , DisplayOrder , RiskRatingCodeId , NotesMandatory , AttachmentsMandatory , BestPractice , Alert , CorrectiveActionFlag , CorrectiveAction , FollowupRowGuid , ResponseNote , OriginalRowGuid , RowGuid    
 ) values (     
@QuestionGuid , @PartnerId , @ResponseNum , @DisplayOrder , @RiskRatingCodeId , @NotesMandatory , @AttachmentsMandatory , @BestPractice , @Alert , @CorrectiveActionFlag , @CorrectiveAction , @FollowupRowGuid , @ResponseNote , @OriginalRowGuid , @RowGuid )
 ;    
select @RowGuid as RowGuid    
  end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSentQuestionResponseDetail]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSentQuestionResponseDetail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionResponseDetail] AS' 
END
GO
 
  ALTER PROCEDURE [dbo].[usp_autoGen_inserttSentQuestionResponseDetail]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @CultureId as varchar ( 10 )     
 , @ResponseNum as int    
 , @DisplayText as nvarchar(MAX)    
 , @OriginalRowGuid as uniqueidentifier    
    
 as begin    
declare @RowGuid as uniqueidentifier     
 set @RowGuid = NEWID()     
 insert into tSentQuestionResponseDetail    
 ( QuestionGuid , PartnerId , CultureId , ResponseNum , DisplayText , OriginalRowGuid , RowGuid    
 ) values (     
@QuestionGuid , @PartnerId , @CultureId , @ResponseNum , @DisplayText , @OriginalRowGuid , @RowGuid ) ;    
select @RowGuid as RowGuid  
end   


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSession]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSession]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSession] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttSession] 
@UserId as int
 , @PartnerId as int
 , @CultureId as varchar ( 10 ) 
 , @LoginTime as datetime
 , @LastRefresh as datetime
 , @PartnerType as varchar ( 30 ) 

 as 


 insert into tSession
 ( UserId , PartnerId , CultureId , LoginTime , LastRefresh , PartnerType
 ) values ( 
@UserId , @PartnerId , @CultureId , @LoginTime , @LastRefresh , @PartnerType ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttSQL]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttSQL]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttSQL] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttSQL] 
@PartnerId as int
 , @EffDate as datetime
 , @SQLGUID as uniqueidentifier
 , @SQLDescription as varchar ( 50 ) 
 , @SQLCmd as text
 , @TxnDate as datetime
 , @SQLDefinition as varchar ( 500 ) 

 as 


 insert into tSQL
 ( PartnerId , EffDate , SQLGUID , SQLDescription , SQLCmd , TxnDate , SQLDefinition
 ) values ( 
@PartnerId , @EffDate , @SQLGUID , @SQLDescription , @SQLCmd , @TxnDate , @SQLDefinition ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttTask]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttTask]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttTask] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttTask] 
@EffDate as datetime
 , @TxnDate as datetime
 , @PartnerName as varchar ( 80 ) 
 , @ActionType as varchar ( 50 ) 
 , @Task as varchar ( 7500 ) 
 , @DaysAhead as int
 , @RemindDate as datetime
 , @UserLoginReminded as varchar ( 50 ) 
 , @UserLoginEntered as varchar ( 50 ) 
 , @Ext as varchar ( 50 ) 

 as 


 insert into tTask
 ( EffDate , TxnDate , PartnerName , ActionType , Task , DaysAhead , RemindDate , UserLoginReminded , UserLoginEntered , Ext
 ) values ( 
@EffDate , @TxnDate , @PartnerName , @ActionType , @Task , @DaysAhead , @RemindDate , @UserLoginReminded , @UserLoginEntered , @Ext ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttTemplateAttachment]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttTemplateAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttTemplateAttachment] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttTemplateAttachment] 
@TemplateGuid as uniqueidentifier
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @PartnerId as int
 , @UserId as int
 , @AttachmentTypeCodeId as varchar ( 50 ) 

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tTemplateAttachment
 ( TemplateGuid , AttachNum , OriginalFilename , DateEntered , PartnerId , UserId , AttachmentTypeCodeId , RowGuid
 ) values ( 
@TemplateGuid , @AttachNum , @OriginalFilename , @DateEntered , @PartnerId , @UserId , @AttachmentTypeCodeId , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttTemplateDetail]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttTemplateDetail]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttTemplateDetail] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttTemplateDetail] 
@TemplateGuid as uniqueidentifier
 , @PartnerId as int
 , @DetailGuid as uniqueidentifier
 , @DetailTypeCodeId as int
 , @DetailNum as int
 , @DetailParentRowGuid as uniqueidentifier
 , @DisplayOrder as int
 , @DetailLevel as int

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tTemplateDetail
 ( TemplateGuid , PartnerId , DetailGuid , DetailTypeCodeId , DetailNum , DetailParentRowGuid , DisplayOrder , DetailLevel , RowGuid
 ) values ( 
@TemplateGuid , @PartnerId , @DetailGuid , @DetailTypeCodeId , @DetailNum , @DetailParentRowGuid , @DisplayOrder , @DetailLevel , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttTemplateHeader]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttTemplateHeader]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttTemplateHeader] AS' 
END
GO
 --tTemplateheader insert
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttTemplateHeader]   
@PartnerId as int  
 , @Name as nvarchar ( 100 )   
 , @Description as nvarchar ( 200 )   
 , @Active as bit  
 , @DisplayDescription as nvarchar ( 4000 )   
 , @GroupBy as varchar ( 50 )   
 , @CategoryOrder as varchar ( 50 )   
 , @TypeCodeId as int  
 ,@IsRenewed as bit
 ,@OriginalTemplateGuid as varchar (50)
 as   
 begin
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tTemplateHeader  
 ( PartnerId , Name , Description , Active , DisplayDescription , GroupBy , CategoryOrder , TypeCodeId , RowGuid , IsRenewed, OriginalTemplateGuid
 ) values (   
@PartnerId , @Name , @Description , @Active , @DisplayDescription , @GroupBy , @CategoryOrder , @TypeCodeId , @RowGuid, @IsRenewed, @OriginalTemplateGuid ) ;  
select @RowGuid as RowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttTemplateRules]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttTemplateRules]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttTemplateRules] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttTemplateRules] 
@TemplateGuid as uniqueidentifier
 , @PartnerId as int
 , @TemplateDetailRowGuid as uniqueidentifier
 , @QuestionRowGuid as uniqueidentifier
 , @QuestionResponseDefinitionRowGuid as uniqueidentifier
 , @ActionCodeId as int
 , @ResultQuestionRowGuid as uniqueidentifier
 , @RuleNote as varchar ( 1000 ) 

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tTemplateRules
 ( TemplateGuid , PartnerId , TemplateDetailRowGuid , QuestionRowGuid , QuestionResponseDefinitionRowGuid , ActionCodeId , ResultQuestionRowGuid , RuleNote , RowGuid
 ) values ( 
@TemplateGuid , @PartnerId , @TemplateDetailRowGuid , @QuestionRowGuid , @QuestionResponseDefinitionRowGuid , @ActionCodeId , @ResultQuestionRowGuid , @RuleNote , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttUser]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttUser] AS' 
END
GO
 

 
 --tUSer insert
   
ALTER      PROCEDURE [dbo].[usp_autoGen_inserttUser]   
@PartnerId as int  
 , @Firstname as nvarchar ( 50 )   
 , @Middlename as nvarchar ( 50 )   
 , @Lastname as nvarchar ( 50 )   
 , @Username as nvarchar ( 128 )   
 , @Password as varchar ( 50 )   
 , @Email as varchar ( 128 )   
 , @Title as nvarchar ( 50 )   
 , @DepartmentCodeId as int  
 , @Phone as varchar ( 25 )   
 , @Fax as varchar ( 15 )   
 , @Address1 as nvarchar ( 50 )   
 , @Address2 as nvarchar ( 50 )   
 , @Address3 as nvarchar ( 50 )   
 , @City as varchar ( 50 )   
 , @StateCodeId as int  
 , @CountryCodeId as int  
 , @PostalCode as varchar ( 15 )   
 , @CultureId as varchar ( 10 )   
 , @Active as bit  
 , @RoleCodeId as int  
 , @AlertQstr as bit  
 , @AlertQstn as bit  
 , @LastLogin as datetime  
 , @LastPasswordChange as datetime  
 , @ForcePasswordChange as bit  
 , @PasswordChangeInterval as int  
 , @CurrentPasswordRetries as int  
 , @PasswordRetriesLockoutInterval as int  
 , @DefaultSessionTimeoutInterval as int  
 , @DefaultTypeCodeId as int  
 , @UpdateFlag as bit  
  
 as   begin 
declare @RowGuid as uniqueidentifier   
declare @uid as int  
  
 set @RowGuid = NEWID()   
 insert into tUser  
 ( PartnerId , Firstname , Middlename , Lastname , Username , Password , Email , Title , DepartmentCodeId , Phone , Fax , Address1 , Address2 , Address3 , City , StateCodeId , CountryCodeId , PostalCode , CultureId , Active , RoleCodeId , AlertQstr , AlertQstn , LastLogin , LastPasswordChange , ForcePasswordChange , PasswordChangeInterval , CurrentPasswordRetries , PasswordRetriesLockoutInterval , DefaultSessionTimeoutInterval, DefaultTypeCodeId , UpdateFlag , RowGuid  
 ) values (   
@PartnerId , @Firstname , @Middlename , @Lastname , @Username , @Password , @Email , @Title , @DepartmentCodeId , @Phone , @Fax , @Address1 , @Address2 , @Address3 , @City , @StateCodeId , @CountryCodeId , @PostalCode , @CultureId , @Active , @RoleCodeId 
, @AlertQstr , @AlertQstn , @LastLogin , @LastPasswordChange , @ForcePasswordChange , @PasswordChangeInterval , @CurrentPasswordRetries , @PasswordRetriesLockoutInterval, @DefaultSessionTimeoutInterval, @DefaultTypeCodeId , @UpdateFlag , @RowGuid ) ;  
  
 set @uid = IDENT_CURRENT('tUser')  
 insert into tUserPasswordResetHistory  
 Select newid(), @uid, @PartnerId, GetDate(), @Password  
  
select @uid as UserId, @RowGuid as RowGuid 
end   

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttUserColumn]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttUserColumn]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttUserColumn] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttUserColumn] 
@UserId as int
 , @QueryId as int
 , @ColumnNum as int
 , @ColumnName as varchar ( 50 ) 
 , @Visibility as bit

 as 


 insert into tUserColumn
 ( UserId , QueryId , ColumnNum , ColumnName , Visibility
 ) values ( 
@UserId , @QueryId , @ColumnNum , @ColumnName , @Visibility ) ;

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttViewTab]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttViewTab]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttViewTab] AS' 
END
GO
 --tViewTab insert
 ALTER PROCEDURE [dbo].[usp_autoGen_inserttViewTab]   
@PartnerId as int  
 , @TabName as nvarchar ( 30 )   
 , @TabTip as nvarchar ( 100 )   
 , @TabDesc as nvarchar ( 1000 )   
 , @DisplayOrder as int  
 , @Active as bit  
 , @CreateUser as int  
 , @CreateDate as datetime  
 , @DefaultFlag as bit  
  
 as  begin 
declare @RowGuid as uniqueidentifier   
 set @RowGuid = NEWID()   
 insert into tViewTab  
 ( PartnerId , TabName , TabTip , TabDesc , DisplayOrder , Active , CreateUser , CreateDate , DefaultFlag , RowGuid  
 ) values (   
@PartnerId , @TabName , @TabTip , @TabDesc , @DisplayOrder , @Active , @CreateUser , @CreateDate , @DefaultFlag , @RowGuid ) ;  
select @RowGuid as RowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttViewTabAssociations]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttViewTabAssociations]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttViewTabAssociations] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_inserttViewTabAssociations]
@PartnerId as int
, @ViewTabRowGuid as uniqueidentifier
, @ViewTabName as varchar ( 30 )
, @TableName as varchar ( 200 )
, @TableRowGuid as uniqueidentifier
, @AccountNumber as varchar(100) = ''
as
declare @RowGuid as uniqueidentifier
set @RowGuid = NEWID()
insert into tViewTabAssociations
( PartnerId , ViewTabRowGuid , ViewTabName , TableName , TableRowGuid , AccountNumber , RowGuid
) values (
@PartnerId , @ViewTabRowGuid , @ViewTabName , @TableName , @TableRowGuid , @AccountNumber , @RowGuid ) ;
select @RowGuid as RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttViewTabSql]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttViewTabSql]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttViewTabSql] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttViewTabSql] 
@TabSqlName as varchar ( 200 ) 
 , @TabSqlDescription as varchar ( 2000 ) 
 , @TypeCodeId as int
 , @DisplayLocation as int
 , @Active as bit

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tViewTabSql
 ( TabSqlName , TabSqlDescription , TypeCodeId , DisplayLocation , Active , RowGuid
 ) values ( 
@TabSqlName , @TabSqlDescription , @TypeCodeId , @DisplayLocation , @Active , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_inserttViewTabSqlUsage]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_inserttViewTabSqlUsage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_inserttViewTabSqlUsage] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_inserttViewTabSqlUsage] 
@TabSqlName as varchar ( 200 ) 
 , @PartnerId as int
 , @UserId as int
 , @DisplayColumn as int
 , @DisplayOrder as int
 , @Title as varchar ( 50 ) 

 as 
declare @RowGuid as uniqueidentifier 
 set @RowGuid = NEWID() 
 insert into tViewTabSqlUsage
 ( TabSqlName , PartnerId , UserId , DisplayColumn , DisplayOrder , Title , RowGuid
 ) values ( 
@TabSqlName , @PartnerId , @UserId , @DisplayColumn , @DisplayOrder , @Title , @RowGuid ) ;
select @RowGuid as RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtAssignmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtAssignmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtAssignmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtAssignmentByRowGuid] 
@RowGuid as uniqueidentifier


/*****
Name: [usp_autoGen_loadtAssignmentByRowGuid]
Author: Unknown
Description: 
Parameters: @RowGUID
Change History:
	- ?				- ? - Created
	- 09/27/2012	- ML - Added NOLOCK hint per Luis Lozano's Request
*****/


 as select Cast(AssignmentGuid as varchar(50)) as AssignmentGuid
 , PartnerId
 , Cast(StatusGuid as varchar(50)) as StatusGuid
 , AssignmentTypeCodeId
 , AssignmentNum
 , Cast(SourceGuid as varchar(50)) as SourceGuid
 , SenderUserId
 , RecipientPartnerId
 , AssignedUserId
 , Status
 , lastAccessedDate
 , lastAccessedBy
 , AssignmentLevel
 , Cast(OriginalTemplateDetailRowGuid as varchar(50)) as OriginalTemplateDetailRowGuid
 , Skip
 from tAssignment WITH (NOLOCK) 

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtAssignmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtAssignmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtAssignmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtAssignmentByTableKey] 
@AssignmentGuid as uniqueidentifier
 , @PartnerId as int

 as select Cast(StatusGuid as varchar(50)) as StatusGuid
 , AssignmentTypeCodeId
 , AssignmentNum
 , Cast(SourceGuid as varchar(50)) as SourceGuid
 , SenderUserId
 , RecipientPartnerId
 , AssignedUserId
 , Status
 , lastAccessedDate
 , lastAccessedBy
 , AssignmentLevel
 , Cast(OriginalTemplateDetailRowGuid as varchar(50)) as OriginalTemplateDetailRowGuid
 , Skip
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tAssignment

 where AssignmentGuid = @AssignmentGuid
 and PartnerId = @PartnerId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtCustomerRequestAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtCustomerRequestAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(AttachmentGuid as varchar(50)) as AttachmentGuid
 , Cast(CRGuid as varchar(50)) as CRGuid
 , Name
 , DisplayToCustomer
 , DateEntered
 , CreateUserId
 , CreatePartnerId
 from tCustomerRequestAttachment

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtCustomerRequestAttachmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtCustomerRequestAttachmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestAttachmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestAttachmentByTableKey] 
@AttachmentGuid as uniqueidentifier

 as select Cast(CRGuid as varchar(50)) as CRGuid
 , Name
 , DisplayToCustomer
 , DateEntered
 , CreateUserId
 , CreatePartnerId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tCustomerRequestAttachment

 where AttachmentGuid = @AttachmentGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtCustomerRequestByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtCustomerRequestByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(CRGuid as varchar(50)) as CRGuid
 , CRNumber
 , Title
 , DateEntered
 , DatePlanned
 , DateReleased
 , State
 , StatusCodeId
 , TypeCodeId
 , Description
 , CustomerStatusCodeId
 , CreateUserId
 , CreatePartnerId
 , FoundInCodeId
 , FixedInCodeId
 , AssignedUserId
 , Estimate
 , PriorityCodeId
 , SeverityCodeId
 , ComponentCodeId
 , ComponentTypeCodeId
 , ResolutionCodeId
 , DisplayToCustomer
 , Archive
 from tCustomerRequest

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtCustomerRequestByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtCustomerRequestByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestByTableKey] 
@CRGuid as uniqueidentifier

 as select CRNumber
 , Title
 , DateEntered
 , DatePlanned
 , DateReleased
 , State
 , StatusCodeId
 , TypeCodeId
 , Description
 , CustomerStatusCodeId
 , CreateUserId
 , CreatePartnerId
 , FoundInCodeId
 , FixedInCodeId
 , AssignedUserId
 , Estimate
 , PriorityCodeId
 , SeverityCodeId
 , ComponentCodeId
 , ComponentTypeCodeId
 , ResolutionCodeId
 , DisplayToCustomer
 , Archive
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tCustomerRequest

 where CRGuid = @CRGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtCustomerRequestNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtCustomerRequestNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestNoteByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(NoteGuid as varchar(50)) as NoteGuid
 , Cast(CRGuid as varchar(50)) as CRGuid
 , NoteTypeCodeId
 , Note
 , DateEntered
 , DisplayToCustomer
 , CreateUserId
 , CreatePartnerId
 from tCustomerRequestNote

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtCustomerRequestNoteByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtCustomerRequestNoteByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestNoteByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtCustomerRequestNoteByTableKey] 
@NoteGuid as uniqueidentifier

 as select Cast(CRGuid as varchar(50)) as CRGuid
 , NoteTypeCodeId
 , Note
 , DateEntered
 , DisplayToCustomer
 , CreateUserId
 , CreatePartnerId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tCustomerRequestNote

 where NoteGuid = @NoteGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtDocumentRequestByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtDocumentRequestByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestByRowGuid] 
@rowGuid as uniqueidentifier

 as select Cast(requestId as varchar(50)) as requestId
 , shortName
 , partnerId
 , partnerEmail
 , supplierShortName
 , supplierPartnerId
 , supplierMid
 , supplierEmail
 , supplierUserId
 , emailBody
 , isReminder
 , requestFilename
 , status
 , Cast(questionnaireRowGuid as varchar(50)) as questionnaireRowGuid
 , Cast(statusRowGuid as varchar(50)) as statusRowGuid
 , receivedDate
 , sentDate
 , dueDate
 , reminderDate
 , entStatus
 from tDocumentRequest

 where rowGuid = @rowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtDocumentRequestByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtDocumentRequestByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestByTableKey] 
@rowGuid as uniqueidentifier

 as select Cast(requestId as varchar(50)) as requestId
 , shortName
 , partnerId
 , partnerEmail
 , supplierShortName
 , supplierPartnerId
 , supplierMid
 , supplierEmail
 , supplierUserId
 , emailBody
 , isReminder
 , requestFilename
 , status
 , Cast(questionnaireRowGuid as varchar(50)) as questionnaireRowGuid
 , Cast(statusRowGuid as varchar(50)) as statusRowGuid
 , receivedDate
 , sentDate
 , dueDate
 , reminderDate
 , entStatus
 from tDocumentRequest

 where rowGuid = @rowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtDocumentRequestDetailsByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtDocumentRequestDetailsByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestDetailsByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestDetailsByRowGuid] 
@rowGuid as uniqueidentifier

 as select Cast(documentRequestRowGuid as varchar(50)) as documentRequestRowGuid
 , Cast(detailId as varchar(50)) as detailId
 , shortName
 , partnerId
 , keyName
 , keyValue
 , keyDesc
 , docType
 , Cast(questionRowGuid as varchar(50)) as questionRowGuid
 , Cast(questionniareRowGuid as varchar(50)) as questionniareRowGuid
 , Cast(sentQuestionRowGuid as varchar(50)) as sentQuestionRowGuid
 , Cast(assignmentRowGuid as varchar(50)) as assignmentRowGuid
 , Cast(statusRowGuid as varchar(50)) as statusRowGuid
 , Cast(responseRowGuid as varchar(50)) as responseRowGuid
 , copiedToDrs
 from tDocumentRequestDetails

 where rowGuid = @rowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtDocumentRequestDetailsByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtDocumentRequestDetailsByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestDetailsByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtDocumentRequestDetailsByTableKey] 
@rowGuid as uniqueidentifier

 as select Cast(documentRequestRowGuid as varchar(50)) as documentRequestRowGuid
 , Cast(detailId as varchar(50)) as detailId
 , shortName
 , partnerId
 , keyName
 , keyValue
 , keyDesc
 , docType
 , Cast(questionRowGuid as varchar(50)) as questionRowGuid
 , Cast(questionniareRowGuid as varchar(50)) as questionniareRowGuid
 , Cast(sentQuestionRowGuid as varchar(50)) as sentQuestionRowGuid
 , Cast(assignmentRowGuid as varchar(50)) as assignmentRowGuid
 , Cast(statusRowGuid as varchar(50)) as statusRowGuid
 , Cast(responseRowGuid as varchar(50)) as responseRowGuid
 , copiedToDrs
 from tDocumentRequestDetails

 where rowGuid = @rowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByRowGuid]
@RowGuid as uniqueidentifier
as select PartnerId
, Cast(EmailGuid as varchar(50)) as EmailGuid
, Cast(TemplateRowGuid as varchar(50)) as TemplateRowGuid
, Cast(StatusRowGuid as varchar(50)) as StatusRowGuid
, ReminderInterval
from tEmailAssociatedQuestionnaires
where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtEmailAssociatedQuestionnairesByTableKey]
@RowGuid as uniqueidentifier
as select PartnerId
, Cast(EmailGuid as varchar(50)) as EmailGuid
, Cast(TemplateRowGuid as varchar(50)) as TemplateRowGuid
, Cast(StatusRowGuid as varchar(50)) as StatusRowGuid
, ReminderInterval
from tEmailAssociatedQuestionnaires
where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailByRowGuid] AS' 
END
GO

ALTER  PROCEDURE [dbo].[usp_autoGen_loadtEmailByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(EmailGuid as varchar(50)) as EmailGuid
 , PartnerId
 , SenderUserId
 , RecipientPartnerId
 , RecipientUserId
 , ToAddress
 , FromAddress
 , CCAddress
 , SendDate
 , Subject
 , Body
 , DueDate
 , ReminderDate
 , IsReminder
 , ReminderNum
 , Cast(StatusGuid as varchar(50)) as StatusGuid
 , Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , Cast(AssignmentGuid as varchar(50)) as AssignmentGuid
 , Status
 , StatusDesc
 , RetryNum
 , RetryDate
 , ForceAnswerOrder
 from tEmail

 where RowGuid = @RowGuid


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailByTableKey] AS' 
END
GO

ALTER  PROCEDURE [dbo].[usp_autoGen_loadtEmailByTableKey] 
@EmailGuid as uniqueidentifier
 , @PartnerId as int

 as select SenderUserId
 , RecipientPartnerId
 , RecipientUserId
 , ToAddress
 , FromAddress
 , CCAddress
 , SendDate
 , Subject
 , Body
 , DueDate
 , ReminderDate
 , IsReminder
 , ReminderNum
 , Cast(StatusGuid as varchar(50)) as StatusGuid
 , Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , Cast(AssignmentGuid as varchar(50)) as AssignmentGuid
 , Status
 , StatusDesc
 , RetryNum
 , RetryDate
 , Cast(RowGuid as varchar(50)) as RowGuid
 , ForceAnswerOrder
 from tEmail

 where EmailGuid = @EmailGuid
 and PartnerId = @PartnerId


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailHistoryByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailHistoryByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailHistoryByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtEmailHistoryByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(EmailGuid as varchar(50)) as EmailGuid
 , PartnerId
 , SenderUserId
 , RecipientPartnerId
 , RecipientUserId
 , ToAddress
 , FromAddress
 , CCAddress
 , SendDate
 , Subject
 , Body
 , DueDate
 , ReminderDate
 , IsReminder
 , ReminderNum
 , Cast(StatusGuid as varchar(50)) as StatusGuid
 , Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , Cast(AssignmentGuid as varchar(50)) as AssignmentGuid
 , Status
 , StatusDesc
 , RetryNum
 , RetryDate
 , LinkFollowed
 from tEmailHistory

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailHistoryByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailHistoryByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailHistoryByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtEmailHistoryByTableKey] 
@EmailGuid as uniqueidentifier
 , @PartnerId as int

 as select SenderUserId
 , RecipientPartnerId
 , RecipientUserId
 , ToAddress
 , FromAddress
 , CCAddress
 , SendDate
 , Subject
 , Body
 , DueDate
 , ReminderDate
 , IsReminder
 , ReminderNum
 , Cast(StatusGuid as varchar(50)) as StatusGuid
 , Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , Cast(AssignmentGuid as varchar(50)) as AssignmentGuid
 , Status
 , StatusDesc
 , RetryNum
 , RetryDate
 , LinkFollowed
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tEmailHistory

 where EmailGuid = @EmailGuid
 and PartnerId = @PartnerId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailTemplatesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailTemplatesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailTemplatesByRowGuid] AS' 
END
GO
     
ALTER PROCEDURE [dbo].[usp_autoGen_loadtEmailTemplatesByRowGuid]     
@RowGuid as uniqueidentifier     
as select Cast(TemplateGuid as varchar(50)) as TemplateGuid     
, Cast(EmailTemplateGuid as varchar(50)) as EmailTemplateGuid    
, PartnerId     
, Description     
, Subject     
, Body     
, FromAddress  
, CCAddress  
, Cast(RowGuid as varchar(50)) as RowGuid 
,Active   
 
from tEmailTemplates     
where RowGuid = @RowGuid 




GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtEmailTemplatesByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtEmailTemplatesByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtEmailTemplatesByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtEmailTemplatesByTableKey]   
@EmailTemplateGuid as uniqueidentifier  
, @PartnerId as int  
as select Description  
, Subject  
, Body  
, Cast(TemplateGuid as varchar(50)) as TemplateGuid  
, Cast(RowGuid as varchar(50)) as RowGuid 
, Active 
from tEmailTemplates  
where TemplateGuid = @EmailTemplateGuid  
and PartnerId = @PartnerId  




 


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtHistoryByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtHistoryByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtHistoryByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtHistoryByRowGuid] 
@RowGuid as uniqueidentifier

 as select HistoryId
 , UserId
 , RowTable
 , ActionType
 , ActionDate
 , ActionDescription
 from tHistory

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtHistoryByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtHistoryByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtHistoryByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtHistoryByTableKey] 
@HistoryId as  int 

 as select UserId
 , Cast(RowGuid as varchar(50)) as RowGuid
 , RowTable
 , ActionType
 , ActionDate
 , ActionDescription
 from tHistory

 where HistoryId = @HistoryId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtImportTmpByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtImportTmpByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtImportTmpByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtImportTmpByRowGuid] 
@rowGuid as uniqueidentifier

 as select Cast(importGuid as varchar(50)) as importGuid
 , partnerid
 , userId
 , originalFilename
 , importDate
 , importType
 , status
 from tImportTmp

 where rowGuid = @rowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtImportTmpByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtImportTmpByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtImportTmpByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtImportTmpByTableKey] 
@importGuid as uniqueidentifier
 , @partnerid as int
 , @userId as int

 as select originalFilename
 , importDate
 , importType
 , status
 , Cast(rowGuid as varchar(50)) as rowGuid
 from tImportTmp

 where importGuid = @importGuid
 and partnerid = @partnerid
 and userId = @userId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtImportTmpMappingByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtImportTmpMappingByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtImportTmpMappingByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtImportTmpMappingByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ImportGuid as varchar(50)) as ImportGuid
 , PartnerId
 , FileFieldName
 , IPFieldName
 from tImportTmpMapping

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtImportTmpMappingByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtImportTmpMappingByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtImportTmpMappingByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtImportTmpMappingByTableKey] 
@ImportGuid as uniqueidentifier
 , @PartnerId as int
 , @FileFieldName as varchar ( 100 ) 
 , @IPFieldName as varchar ( 100 ) 

 as select Cast(RowGuid as varchar(50)) as RowGuid
 from tImportTmpMapping

 where ImportGuid = @ImportGuid
 and PartnerId = @PartnerId
 and FileFieldName = @FileFieldName
 and IPFieldName = @IPFieldName

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerByRowGuid]    
@RowGuid as uniqueidentifier    
as select PartnerId    
, Name    
, ShortName    
, Address1    
, Address2    
, Address3    
, City    
, StateCodeId    
, CountryCodeId    
, PostalCode    
, Phone    
, Fax    
, Active    
, DefaultReminderInterval    
, DefaultPasswordChangeInterval    
, PrimaryUserId    
, SviUsername    
, SviPassword    
, SviCompanyName    
, SviNumber    
, PortOfExport    
, PartnerType    
, EntPartnerId    
, MID    
, SendingEmailAsIp    
, SendingEmailAddress    
, UpdateFlag    
, TabLimit    
, FactoryNum    
, ProductNum    
, NickName    
, NewRecord    
, AutoSendCA    
, AnnualImportValue    
, AnnualVolume    
, DUNSNumber    
, RequiresAccess  
, Tier  
, LastDateValidated  
, ParentCompanyName  
, GPSLatitude  
, GPSLongitude  
, YearEstablished  
, PublicPrivate  
, WebsiteURL  
,CADueDate
,ReminderIntervalCA
,CARating
,RenewQuestionnaire
from tPartner (nolock)    
where RowGuid = @RowGuid  
      
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerByTableKey]    
@PartnerId as int    
as select Name    
, ShortName    
, Address1    
, Address2    
, Address3    
, City    
, StateCodeId    
, CountryCodeId    
, PostalCode    
, Phone    
, Fax    
, Active    
, DefaultReminderInterval    
, DefaultPasswordChangeInterval    
, PrimaryUserId    
, SviUsername    
, SviPassword    
, SviCompanyName    
, SviNumber    
, PortOfExport    
, PartnerType    
, EntPartnerId    
, MID    
, SendingEmailAsIp    
, SendingEmailAddress    
, UpdateFlag    
, TabLimit    
, Cast(RowGuid as varchar(50)) as RowGuid    
, FactoryNum    
, ProductNum    
, NickName    
, NewRecord    
, AutoSendCA    
, AnnualImportValue    
, AnnualVolume    
, DUNSNumber    
, RequiresAccess  
, Tier  
, LastDateValidated  
, ParentCompanyName  
, GPSLatitude  
, GPSLongitude  
, YearEstablished  
, PublicPrivate  
, WebsiteURL  
,CADueDate
,ReminderIntervalCA
,CARating
, RenewQuestionnaire
from tPartner (nolock)    
where PartnerId = @PartnerId  
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerProductByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerProductByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerProductByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerProductByRowGuid] 
@RowGuid as uniqueidentifier

 as select PartnerID
 , EffDate
 , ProductNum
 , ProductDesc
 , Cast(ProductGuid as varchar(50)) as ProductGuid
 from tPartnerProduct

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerProductByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerProductByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerProductByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerProductByTableKey] 
@PartnerID as int
 , @RowGuid as uniqueidentifier
 , @ProductNum as varchar ( 50 ) 

 as select EffDate
 , ProductDesc
 , Cast(ProductGuid as varchar(50)) as ProductGuid
 from tPartnerProduct

 where PartnerID = @PartnerID
 and RowGuid = @RowGuid
 and ProductNum = @ProductNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerRelationshipByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerRelationshipByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(RelationshipGuid as varchar(50)) as RelationshipGuid
 , ParentId
 , ChildId
 , RelationshipTypeCodeId
 , ReferenceCode
 , ReferenceNumber
 , PartnerTypeCodeId
 from tPartnerRelationship

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerRelationshipByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerRelationshipByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipByTableKey] 
@RelationshipGuid as uniqueidentifier
 , @ParentId as int
 , @ChildId as int

 as select RelationshipTypeCodeId
 , ReferenceCode
 , ReferenceNumber
 , PartnerTypeCodeId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tPartnerRelationship

 where RelationshipGuid = @RelationshipGuid
 and ParentId = @ParentId
 and ChildId = @ChildId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerRelationshipGroupByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerRelationshipGroupByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipGroupByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipGroupByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(PartnerRelationshipRowGuid as varchar(50)) as PartnerRelationshipRowGuid
 , ParentId
 , ChildId
 , GroupType
 from tPartnerRelationshipGroup

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtPartnerRelationshipGroupByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtPartnerRelationshipGroupByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipGroupByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtPartnerRelationshipGroupByTableKey] 
@PartnerRelationshipRowGuid as uniqueidentifier
 , @ParentId as int
 , @ChildId as int
 , @GroupType as varchar ( 50 ) 

 as select Cast(RowGuid as varchar(50)) as RowGuid
 from tPartnerRelationshipGroup

 where PartnerRelationshipRowGuid = @PartnerRelationshipRowGuid
 and ParentId = @ParentId
 and ChildId = @ChildId
 and GroupType = @GroupType

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_LoadtPartnerRelationshipParentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_LoadtPartnerRelationshipParentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_LoadtPartnerRelationshipParentByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_LoadtPartnerRelationshipParentByRowGuid]  
@RowGuid as uniqueidentifier  
 
as select Cast(PartnerRelationshipRowGuid as varchar(50)) as PartnerRelationshipRowGuid  
, ImporterId  
, ChildId  
, ParentName  
from tPartnerRelationshipParent  
where RowGuid = @RowGuid  


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_LoadtPartnerRelationshipParentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_LoadtPartnerRelationshipParentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_LoadtPartnerRelationshipParentByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_LoadtPartnerRelationshipParentByTableKey]  
@PartnerRelationshipRowGuid as uniqueidentifier  
, @ImporterId as int  
, @ChildId as int  
, @ParentName as varchar ( 50 )  
 
as select Cast(RowGuid as varchar(50)) as RowGuid  
from tPartnerRelationshipParent  
 
where PartnerRelationshipRowGuid = @PartnerRelationshipRowGuid  
and ImporterId = @ImporterId  
and ChildId = @ChildId  
and ParentName = @ParentName  


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid
 , PartnerId
 , AttachNum
 , OriginalFilename
 , DateEntered
 , UserId
 , AttachmentTypeCodeId
 from tQuestionAttachment

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionAttachmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionAttachmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionAttachmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionAttachmentByTableKey] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @AttachNum as int

 as select OriginalFilename
 , DateEntered
 , UserId
 , AttachmentTypeCodeId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tQuestionAttachment

 where QuestionGuid = @QuestionGuid
 and PartnerId = @PartnerId
 and AttachNum = @AttachNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionBodyByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionBodyByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionBodyByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionBodyByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid
 , PartnerId
 , CultureId
 , Body
 from tQuestionBody

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionBodyByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionBodyByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionBodyByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionBodyByTableKey] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @CultureId as varchar ( 10 ) 

 as select Body
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tQuestionBody

 where QuestionGuid = @QuestionGuid
 and PartnerId = @PartnerId
 and CultureId = @CultureId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionByRowGuid] 
@RowGuid as uniqueidentifier 
as select Cast(QuestionGuid as varchar(50)) as QuestionGuid 
, PartnerId 
, AllowNotes 
, AllowAttachments 
, ResponseTypeCodeId 
, Shared 
, DepartmentCodeId 
, CategoryCodeId 
, PortCodeId 
, IndustryCodeId 
, RegionCodeId 
, ImportanceCodeId 
, WeightCodeId
, Description 
, Active 
, TypeCodeId 
, Version
from tQuestion 
where RowGuid = @RowGuid 
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionByTableKey] 
@QuestionGuid as uniqueidentifier 
, @PartnerId as int 
as select AllowNotes 
, AllowAttachments 
, ResponseTypeCodeId 
, Shared 
, DepartmentCodeId 
, CategoryCodeId 
, PortCodeId 
, IndustryCodeId 
, RegionCodeId 
, ImportanceCodeId 
, WeightCodeId
, Description 
, Active 
, TypeCodeId 
, Cast(RowGuid as varchar(50)) as RowGuid 
, Version
from tQuestion 
where QuestionGuid = @QuestionGuid 
and PartnerId = @PartnerId
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_LoadtQuestionnaireStatusByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_LoadtQuestionnaireStatusByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_LoadtQuestionnaireStatusByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_LoadtQuestionnaireStatusByRowGuid]
@RowGuid as uniqueidentifier
as select Cast(StatusGuid as varchar(50)) as StatusGuid
, PartnerId
, Cast(TemplateGuid as varchar(50)) as TemplateGuid
, RecipientPartnerId
, DateSent
, LastAccessDate
, LastAccessUser
, LastReminderDate
, ReminderScheduled
, StatusCodeId
, StatusDescription
, DueDate
, Archive
, ArchiveDate
, Name
, Description
, DisplayDescription
, GroupBy
, CategoryOrder
, TypeCodeId
, deleted
, Rating
, ReminderInterval
, IsRenewed
from tQuestionnaireStatus
where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_LoadtQuestionnaireStatusByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_LoadtQuestionnaireStatusByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_LoadtQuestionnaireStatusByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_LoadtQuestionnaireStatusByTableKey]
@StatusGuid as uniqueidentifier
, @PartnerId as int
/*****
Name: [usp_autoGen_LoadtQuestionnaireStatusByTableKey]
Author: Unknown
Description:
Parameters: @StatusGUID, @PartnerID
Change History:
- ?	 - ? - Created
- 09/27/2012	- ML - Added NOLOCK hint per Luis Lozano's Request
*****/
as select Cast(TemplateGuid as varchar(50)) as TemplateGuid
, RecipientPartnerId
, DateSent
, LastAccessDate
, LastAccessUser
, LastReminderDate
, ReminderScheduled
, StatusCodeId
, StatusDescription
, DueDate
, Archive
, ArchiveDate
, Name
, Description
, DisplayDescription
, GroupBy
, CategoryOrder
, TypeCodeId
, deleted
, Rating
, ReminderInterval
, Cast(RowGuid as varchar(50)) as RowGuid
, IsRenewed
from tQuestionnaireStatus WITH (NOLOCK)
where StatusGuid = @StatusGuid
and PartnerId = @PartnerId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionResponseDefinitionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionResponseDefinitionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDefinitionByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDefinitionByRowGuid]   
@RowGuid as uniqueidentifier  
  
 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid  
 , PartnerId  
 , ResponseNum  
 , DisplayOrder  
 , RiskRatingCodeId  
 , NotesMandatory
 , AttachmentsMandatory 
 , BestPractice  
 , Alert  
 , CorrectiveActionFlag  
 , CorrectiveAction  
 , Cast(FollowupRowGuid as varchar(50)) as FollowupRowGuid  
 , ResponseNote  
 from tQuestionResponseDefinition with (nolock)  
  
 where RowGuid = @RowGuid  
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionResponseDefinitionByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionResponseDefinitionByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDefinitionByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDefinitionByTableKey]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @ResponseNum as int  
  
 as select DisplayOrder  
 , RiskRatingCodeId  
 , NotesMandatory  
 , AttachmentsMandatory  
 , BestPractice  
 , Alert  
 , CorrectiveActionFlag  
 , CorrectiveAction  
 , Cast(FollowupRowGuid as varchar(50)) as FollowupRowGuid  
 , ResponseNote  
 , Cast(RowGuid as varchar(50)) as RowGuid  
 from tQuestionResponseDefinition  with (nolock)
  
 where QuestionGuid = @QuestionGuid  
 and PartnerId = @PartnerId  
 and ResponseNum = @ResponseNum  
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid
 , PartnerId
 , CultureId
 , ResponseNum
 , DisplayText
 from tQuestionResponseDetail

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtQuestionResponseDetailByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtQuestionResponseDetailByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDetailByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtQuestionResponseDetailByTableKey] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @CultureId as varchar ( 10 ) 
 , @ResponseNum as int

 as select DisplayText
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tQuestionResponseDetail

 where QuestionGuid = @QuestionGuid
 and PartnerId = @PartnerId
 and CultureId = @CultureId
 and ResponseNum = @ResponseNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtReminderByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtReminderByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtReminderByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtReminderByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ReminderGuid as varchar(50)) as ReminderGuid
 , Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , SenderId
 , RecipientId
 , Cast(EmailGuid as varchar(50)) as EmailGuid
 , ScheduledDate
 from tReminder

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtReminderByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtReminderByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtReminderByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtReminderByTableKey] 
@ReminderGuid as uniqueidentifier

 as select Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , SenderId
 , RecipientId
 , Cast(EmailGuid as varchar(50)) as EmailGuid
 , ScheduledDate
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tReminder

 where ReminderGuid = @ReminderGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseAttachmentByRowGuid] AS' 
END
GO

  ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ResponseGuid as varchar(50)) as ResponseGuid
 , AttachNum
 , OriginalFilename
 , DateEntered
 , PartnerId
 , UserId
 , AttachTypeCodeId
 , gtnguid
 from tResponseAttachment

 where RowGuid = @RowGuid   
    
      

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseAttachmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseAttachmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseAttachmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseAttachmentByTableKey] 
@ResponseGuid as uniqueidentifier
 , @AttachNum as int

 as select OriginalFilename
 , DateEntered
 , PartnerId
 , UserId
 , AttachTypeCodeId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tResponseAttachment

 where ResponseGuid = @ResponseGuid
 and AttachNum = @AttachNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseByRowGuid]   
@RowGuid as uniqueidentifier  
  
/*****  
Name: [usp_autoGen_loadtResponseByRowGuid]  
Author: Unknown  
Description:   
Parameters: @RowGUID  
Change History:  
 - ?    - ? - Created  
 - 09/27/2012 - ML - Added NOLOCK hint per Luis Lozano's Request  
*****/  
  
 as select Cast(ResponseGuid as varchar(50)) as ResponseGuid  
 , Cast(AssignmentGuid as varchar(50)) as AssignmentGuid  
 , Cast(QuestionGuid as varchar(50)) as QuestionGuid  
 , ResponseRatingCodeId  
 , NotesMandatory 
 , AttachmentsMandatory  
 , BestPractice  
 , Alert  
 , CorrectiveActionFlag  
 , CorrectiveAction  
 , AuditCodeId  
 , AuditDate  
 from tResponse with (nolock)  
  
 where RowGuid = @RowGuid  
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseByTableKey]   
@ResponseGuid as uniqueidentifier  
 , @AssignmentGuid as uniqueidentifier  
 , @QuestionGuid as uniqueidentifier  
  
 as select ResponseRatingCodeId  
 , NotesMandatory  
 , AttachmentsMandatory
 , BestPractice  
 , Alert  
 , CorrectiveActionFlag  
 , CorrectiveAction  
 , AuditCodeId  
 , AuditDate  
 , Cast(RowGuid as varchar(50)) as RowGuid  
 from tResponse  with (nolock)
  
 where ResponseGuid = @ResponseGuid  
 and AssignmentGuid = @AssignmentGuid  
 and QuestionGuid = @QuestionGuid  
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseDetailAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseDetailAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ResponseGuid as varchar(50)) as ResponseGuid
 , Cast(ResponseDetailRowGuid as varchar(50)) as ResponseDetailRowGuid
 , Cast(ResponseAttachmentRowGuid as varchar(50)) as ResponseAttachmentRowGuid
 from tResponseDetailAttachment

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseDetailAttachmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseDetailAttachmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailAttachmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailAttachmentByTableKey] 
@ResponseGuid as uniqueidentifier
 , @ResponseDetailRowGuid as uniqueidentifier
 , @ResponseAttachmentRowGuid as uniqueidentifier

 as select Cast(RowGuid as varchar(50)) as RowGuid
 from tResponseDetailAttachment

 where ResponseGuid = @ResponseGuid
 and ResponseDetailRowGuid = @ResponseDetailRowGuid
 and ResponseAttachmentRowGuid = @ResponseAttachmentRowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ResponseGuid as varchar(50)) as ResponseGuid
 , ResponseNum
 , ResponseRatingCodeId
 , Response
 , Override  
 , OverrideNotes
 from tResponseDetail

 where RowGuid = @RowGuid


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseDetailByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseDetailByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailByTableKey] 
@ResponseGuid as uniqueidentifier
 , @ResponseNum as int

 as select ResponseRatingCodeId
 , Response
 , Cast(RowGuid as varchar(50)) as RowGuid
 , Override  
 , OverrideNotes
 from tResponseDetail

 where ResponseGuid = @ResponseGuid
 and ResponseNum = @ResponseNum
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseDetailNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseDetailNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailNoteByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ResponseGuid as varchar(50)) as ResponseGuid
 , Cast(ResponseDetailRowGuid as varchar(50)) as ResponseDetailRowGuid
 , Cast(ResponseNoteRowGuid as varchar(50)) as ResponseNoteRowGuid
 from tResponseDetailNote

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseDetailNoteByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseDetailNoteByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailNoteByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseDetailNoteByTableKey] 
@ResponseGuid as uniqueidentifier
 , @ResponseDetailRowGuid as uniqueidentifier
 , @ResponseNoteRowGuid as uniqueidentifier

 as select Cast(RowGuid as varchar(50)) as RowGuid
 from tResponseDetailNote

 where ResponseGuid = @ResponseGuid
 and ResponseDetailRowGuid = @ResponseDetailRowGuid
 and ResponseNoteRowGuid = @ResponseNoteRowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseNoteByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(ResponseGuid as varchar(50)) as ResponseGuid
 , PartnerId
 , UserId
 , NoteNum
 , NoteTypeCodeId
 , Note
 , DateEntered
 from tResponseNote

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtResponseNoteByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtResponseNoteByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtResponseNoteByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtResponseNoteByTableKey] 
@ResponseGuid as uniqueidentifier
 , @NoteNum as int

 as select PartnerId
 , UserId
 , NoteTypeCodeId
 , Note
 , DateEntered
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tResponseNote

 where ResponseGuid = @ResponseGuid
 and NoteNum = @NoteNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid
 , PartnerId
 , AttachNum
 , OriginalFilename
 , DateEntered
 , UserId
 , AttachmentTypeCodeId
 from tSentQuestionAttachment

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionAttachmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionAttachmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionAttachmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionAttachmentByTableKey] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @AttachNum as int

 as select OriginalFilename
 , DateEntered
 , UserId
 , AttachmentTypeCodeId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tSentQuestionAttachment

 where QuestionGuid = @QuestionGuid
 and PartnerId = @PartnerId
 and AttachNum = @AttachNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionBodyByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionBodyByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionBodyByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionBodyByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid
 , PartnerId
 , CultureId
 , Body
 , Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid
 from tSentQuestionBody

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionBodyByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionBodyByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionBodyByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionBodyByTableKey] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @CultureId as varchar ( 10 ) 

 as select Body
 , Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tSentQuestionBody

 where QuestionGuid = @QuestionGuid
 and PartnerId = @PartnerId
 and CultureId = @CultureId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionByRowGuid] AS' 
END
GO


ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionByRowGuid]   
@RowGuid as uniqueidentifier   
  
/*****  
Name: [usp_autoGen_loadtSentQuestionByRowGuid]  
Author: Unknown  
Description:   
Parameters: @RowGuid  
Change History:  
 - ?    - ? - Created  
 - 09/27/2012 - ML - Added NOLOCK hint per Luis Lozano's Request  
*****/  
  
as select Cast(QuestionGuid as varchar(50)) as QuestionGuid   
, Cast(OriginalQuestionGuid as varchar(50)) as OriginalQuestionGuid   
, PartnerId   
, AllowNotes   
, AllowAttachments   
, ResponseTypeCodeId   
, Shared   
, DepartmentCodeId   
, CategoryCodeId   
, PortCodeId   
, IndustryCodeId   
, RegionCodeId   
, ImportanceCodeId  
, WeightCodeId 
, Description   
, Active   
, TypeCodeId   
, Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid   
from tSentQuestion WITH (NOLOCK)  
where RowGuid = @RowGuid   
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionByTableKey]   
@QuestionGuid as uniqueidentifier   
, @PartnerId as int   
  
/*****  
Name: [usp_autoGen_loadtSentQuestionByTableKey]  
Author: Unknown  
Description:   
Parameters: @QuestionGUID, @PartnerID  
Change History:  
 - ?    - ? - Created  
 - 09/27/2012 - ML - Added NOLOCK hint per Luis Lozano's Request  
*****/  
  
as select Cast(OriginalQuestionGuid as varchar(50)) as OriginalQuestionGuid   
, AllowNotes   
, AllowAttachments   
, ResponseTypeCodeId   
, Shared   
, DepartmentCodeId   
, CategoryCodeId   
, PortCodeId   
, IndustryCodeId   
, RegionCodeId   
, ImportanceCodeId 
, WeightCodeId  
, Description   
, Active   
, TypeCodeId   
, Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid   
, Cast(RowGuid as varchar(50)) as RowGuid   
from tSentQuestion WITH (NOLOCK)  
where QuestionGuid = @QuestionGuid   
and PartnerId = @PartnerId   
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionnaireRulesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionnaireRulesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionnaireRulesByRowGuid] AS' 
END
GO
ALTER  PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionnaireRulesByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(StatusGuid as varchar(50)) as StatusGuid
 , Cast(AssignmentRowGuid as varchar(50)) as AssignmentRowGuid
 , PartnerId
 , SentQuestionRowGuid
 , SentQuestionResponseDefinitionRowGuid
 , ActionCodeId
 , ResultQuestionRowGuid
 , RuleNote
 from tSentQuestionnaireRules

 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByRowGuid]   
@RowGuid as uniqueidentifier  
  
 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid  
 , PartnerId  
 , ResponseNum  
 , DisplayOrder  
 , RiskRatingCodeId  
 , NotesMandatory
 , AttachmentsMandatory 
 , BestPractice  
 , Alert  
 , CorrectiveActionFlag  
 , CorrectiveAction  
 , Cast(FollowupRowGuid as varchar(50)) as FollowupRowGuid  
 , ResponseNote  
 , Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid  
 from tSentQuestionResponseDefinition with (nolock)  
  
 where RowGuid = @RowGuid  
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDefinitionByTableKey]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @ResponseNum as int  
  
 as select DisplayOrder  
 , RiskRatingCodeId  
 , NotesMandatory
 , AttachmentsMandatory 
 , BestPractice  
 , Alert  
 , CorrectiveActionFlag  
 , CorrectiveAction  
 , Cast(FollowupRowGuid as varchar(50)) as FollowupRowGuid  
 , ResponseNote  
 , Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid  
 , Cast(RowGuid as varchar(50)) as RowGuid  
 from tSentQuestionResponseDefinition with (nolock) 
  
 where QuestionGuid = @QuestionGuid  
 and PartnerId = @PartnerId  
 and ResponseNum = @ResponseNum 


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(QuestionGuid as varchar(50)) as QuestionGuid
 , PartnerId
 , CultureId
 , ResponseNum
 , DisplayText
 , Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid
 from tSentQuestionResponseDetail

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtSentQuestionResponseDetailByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtSentQuestionResponseDetailByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDetailByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtSentQuestionResponseDetailByTableKey] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @CultureId as varchar ( 10 ) 
 , @ResponseNum as int

 as select DisplayText
 , Cast(OriginalRowGuid as varchar(50)) as OriginalRowGuid
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tSentQuestionResponseDetail

 where QuestionGuid = @QuestionGuid
 and PartnerId = @PartnerId
 and CultureId = @CultureId
 and ResponseNum = @ResponseNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateAttachmentByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , AttachNum
 , OriginalFilename
 , DateEntered
 , PartnerId
 , UserId
 , AttachmentTypeCodeId
 from tTemplateAttachment

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateAttachmentByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateAttachmentByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateAttachmentByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateAttachmentByTableKey] 
@TemplateGuid as uniqueidentifier
 , @AttachNum as int

 as select OriginalFilename
 , DateEntered
 , PartnerId
 , UserId
 , AttachmentTypeCodeId
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tTemplateAttachment

 where TemplateGuid = @TemplateGuid
 and AttachNum = @AttachNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateDetailByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , PartnerId
 , Cast(DetailGuid as varchar(50)) as DetailGuid
 , DetailTypeCodeId
 , DetailNum
 , Cast(DetailParentRowGuid as varchar(50)) as DetailParentRowGuid
 , DisplayOrder
 , DetailLevel
 from tTemplateDetail

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateDetailByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateDetailByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateDetailByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateDetailByTableKey] 
@TemplateGuid as uniqueidentifier
 , @PartnerId as int
 , @DetailGuid as uniqueidentifier
 , @DetailTypeCodeId as int
 , @DetailNum as int

 as select Cast(DetailParentRowGuid as varchar(50)) as DetailParentRowGuid
 , DisplayOrder
 , DetailLevel
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tTemplateDetail

 where TemplateGuid = @TemplateGuid
 and PartnerId = @PartnerId
 and DetailGuid = @DetailGuid
 and DetailTypeCodeId = @DetailTypeCodeId
 and DetailNum = @DetailNum

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateHeaderByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateHeaderByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateHeaderByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateHeaderByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , PartnerId
 , Name
 , Description
 , Active
 , DisplayDescription
 , GroupBy
 , CategoryOrder
 , TypeCodeId
 , Cast(RowGuid as varchar(50)) as RowGuid 
 , IsRenewed
 , OriginalTemplateGuid
 from tTemplateHeader

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateHeaderByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateHeaderByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateHeaderByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateHeaderByTableKey]   
@TemplateGuid as uniqueidentifier  
 , @PartnerId as int  
  
 as select Name  
 , Description  
 , Active  
 , DisplayDescription  
 , GroupBy  
 , CategoryOrder  
 , TypeCodeId  
 , Cast(RowGuid as varchar(50)) as RowGuid  
 , IsRenewed
 , OriginalTemplateGuid
 from tTemplateHeader  
  
 where TemplateGuid = @TemplateGuid  
 and PartnerId = @PartnerId  
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateRulesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateRulesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateRulesByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateRulesByRowGuid] 
@RowGuid as uniqueidentifier

 as select Cast(TemplateGuid as varchar(50)) as TemplateGuid
 , PartnerId
 , Cast(TemplateDetailRowGuid as varchar(50)) as TemplateDetailRowGuid
 , Cast(QuestionRowGuid as varchar(50)) as QuestionRowGuid
 , Cast(QuestionResponseDefinitionRowGuid as varchar(50)) as QuestionResponseDefinitionRowGuid
 , ActionCodeId
 , Cast(ResultQuestionRowGuid as varchar(50)) as ResultQuestionRowGuid
 , RuleNote
 from tTemplateRules

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtTemplateRulesByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtTemplateRulesByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtTemplateRulesByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtTemplateRulesByTableKey] 
@TemplateGuid as uniqueidentifier
 , @PartnerId as int
 , @TemplateDetailRowGuid as uniqueidentifier
 , @QuestionRowGuid as uniqueidentifier
 , @QuestionResponseDefinitionRowGuid as uniqueidentifier

 as select ActionCodeId
 , Cast(ResultQuestionRowGuid as varchar(50)) as ResultQuestionRowGuid
 , RuleNote
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tTemplateRules

 where TemplateGuid = @TemplateGuid
 and PartnerId = @PartnerId
 and TemplateDetailRowGuid = @TemplateDetailRowGuid
 and QuestionRowGuid = @QuestionRowGuid
 and QuestionResponseDefinitionRowGuid = @QuestionResponseDefinitionRowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtUserByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtUserByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtUserByRowGuid] AS' 
END
GO


ALTER   PROCEDURE [dbo].[usp_autoGen_loadtUserByRowGuid] 
@RowGuid as uniqueidentifier

/*****
Name: [usp_autoGen_loadtUserByRowGuid]
Author: Unknown
Description: 
Parameters: @RowGuid
Change History:
	- ?				- ? - Created
	- 09/27/2012	- ML - Added NOLOCK hint per Luis Lozano's Request
*****/


  as select UserId
 , PartnerId
 , Firstname
 , Middlename
 , Lastname
 , Username
 , Password
 , Email
 , Title
 , DepartmentCodeId
 , Phone
 , Fax
 , Address1
 , Address2
 , Address3
 , City
 , StateCodeId
 , CountryCodeId
 , PostalCode
 , CultureId
 , Active
 , RoleCodeId
 , AlertQstr
 , AlertQstn
 , LastLogin
 , LastPasswordChange
 , ForcePasswordChange
 , CurrentPasswordRetries 
 , PasswordChangeInterval
 , DefaultSessionTimeoutInterval
 , DefaultTypeCodeId
 , UpdateFlag
 from tUser WITH (NOLOCK)

 where RowGuid = @RowGuid



GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtUserByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtUserByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtUserByTableKey] AS' 
END
GO



ALTER   PROCEDURE [dbo].[usp_autoGen_loadtUserByTableKey] 
@UserId as  int 
 , @PartnerId as int

 as select Firstname
 , Middlename
 , Lastname
 , Username
 , Password
 , Email
 , Title
 , DepartmentCodeId
 , Phone
 , Fax
 , Address1
 , Address2
 , Address3
 , City
 , StateCodeId
 , CountryCodeId
 , PostalCode
 , CultureId
 , Active
 , RoleCodeId
 , AlertQstr
 , AlertQstn
 , LastLogin
 , LastPasswordChange
 , ForcePasswordChange
 , PasswordChangeInterval
 , CurrentPasswordRetries
 , PasswordRetriesLockoutInterval
 , DefaultSessionTimeoutInterval
 , DefaultTypeCodeId
 , UpdateFlag
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tUser (nolock)

 where UserId = @UserId
 and PartnerId = @PartnerId




GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtViewTabAssociationsByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtViewTabAssociationsByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtViewTabAssociationsByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtViewTabAssociationsByRowGuid]
@RowGuid as uniqueidentifier
as select PartnerId
, Cast(ViewTabRowGuid as varchar(50)) as ViewTabRowGuid
, ViewTabName
, TableName
, Cast(TableRowGuid as varchar(50)) as TableRowGuid
, AccountNumber
from tViewTabAssociations
where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtViewTabAssociationsByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtViewTabAssociationsByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtViewTabAssociationsByTableKey] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_loadtViewTabAssociationsByTableKey]
@PartnerId as int
, @ViewTabRowGuid as uniqueidentifier
, @TableName as varchar ( 200 )
, @TableRowGuid as uniqueidentifier
, @AccountNumber as varchar(100)
as select ViewTabName
, Cast(RowGuid as varchar(50)) as RowGuid
from tViewTabAssociations
where PartnerId = @PartnerId
and ViewTabRowGuid = @ViewTabRowGuid
and TableName = @TableName
and TableRowGuid = @TableRowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_LoadtViewTabByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_LoadtViewTabByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_LoadtViewTabByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_LoadtViewTabByRowGuid]  
@RowGuid as uniqueidentifier  
as select PartnerID  
, TabName  
, TabTip  
, TabDesc  
, DisplayOrder  
, Active  
, CreateUser  
, CreateDate  
, DefaultFlag  
from tViewTab  
where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtViewTabSqlByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtViewTabSqlByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlByRowGuid] 
@RowGuid as uniqueidentifier

 as select TabSqlName
 , TabSqlDescription
 , TypeCodeId
 , DisplayLocation
 , Active
 from tViewTabSql

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtViewTabSqlByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtViewTabSqlByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlByTableKey] 
@TabSqlName as varchar ( 200 ) 
 , @TypeCodeId as int

 as select TabSqlDescription
 , DisplayLocation
 , Active
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tViewTabSql

 where TabSqlName = @TabSqlName
 and TypeCodeId = @TypeCodeId

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtViewTabSqlUsageByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtViewTabSqlUsageByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlUsageByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlUsageByRowGuid] 
@RowGuid as uniqueidentifier

 as select TabSqlName
 , PartnerId
 , UserId
 , DisplayColumn
 , DisplayOrder
 , Title
 from tViewTabSqlUsage

 where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_loadtViewTabSqlUsageByTableKey]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_loadtViewTabSqlUsageByTableKey]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlUsageByTableKey] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_loadtViewTabSqlUsageByTableKey] 
@TabSqlName as varchar ( 200 ) 
 , @PartnerId as int
 , @UserId as int
 , @DisplayColumn as int
 , @DisplayOrder as int

 as select Title
 , Cast(RowGuid as varchar(50)) as RowGuid
 from tViewTabSqlUsage

 where TabSqlName = @TabSqlName
 and PartnerId = @PartnerId
 and UserId = @UserId
 and DisplayColumn = @DisplayColumn
 and DisplayOrder = @DisplayOrder

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetAssignmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetAssignmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetAssignmentByRowGuid] AS' 
END
GO

--TAssignment update
ALTER PROCEDURE [dbo].[usp_autoGen_updatetAssignmentByRowGuid]   
@AssignmentGuid as uniqueidentifier  
 , @PartnerId as int  
 , @StatusGuid as uniqueidentifier  
 , @AssignmentTypeCodeId as int  
 , @AssignmentNum as int  
 , @SourceGuid as uniqueidentifier  
 , @SenderUserId as int  
 , @RecipientPartnerId as int  
 , @AssignedUserId as int  
 , @Status as nvarchar ( 50 )   
 , @lastAccessedDate as datetime  
 , @lastAccessedBy as int  
 , @AssignmentLevel as int  
 , @OriginalTemplateDetailRowGuid as uniqueidentifier  
 , @Skip as bit  
 , @RowGuid as uniqueidentifier  
  
 as 
 begin update tAssignment set   
StatusGuid=@StatusGuid  
 , AssignmentTypeCodeId=@AssignmentTypeCodeId  
 , AssignmentNum=@AssignmentNum  
 , SourceGuid=@SourceGuid  
 , SenderUserId=@SenderUserId  
 , RecipientPartnerId=@RecipientPartnerId  
 , AssignedUserId=@AssignedUserId  
 , Status=@Status  
 , lastAccessedDate=@lastAccessedDate  
 , lastAccessedBy=@lastAccessedBy  
 , AssignmentLevel=@AssignmentLevel  
 , OriginalTemplateDetailRowGuid=@OriginalTemplateDetailRowGuid  
 , Skip=@Skip  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid
 end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetCustomerRequestAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetCustomerRequestAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetCustomerRequestAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetCustomerRequestAttachmentByRowGuid] 
@AttachmentGuid as uniqueidentifier
 , @CRGuid as uniqueidentifier
 , @Name as varchar ( 256 ) 
 , @DisplayToCustomer as bit
 , @DateEntered as datetime
 , @CreateUserId as int
 , @CreatePartnerId as int
 , @RowGuid as uniqueidentifier

 as  update tCustomerRequestAttachment set 
CRGuid=@CRGuid
 , Name=@Name
 , DisplayToCustomer=@DisplayToCustomer
 , DateEntered=@DateEntered
 , CreateUserId=@CreateUserId
 , CreatePartnerId=@CreatePartnerId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetCustomerRequestByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetCustomerRequestByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetCustomerRequestByRowGuid] AS' 
END
GO
--update tCustomerRequest

ALTER PROCEDURE [dbo].[usp_autoGen_updatetCustomerRequestByRowGuid]   
@CRGuid as uniqueidentifier  
 , @CRNumber as  int   
 , @Title as nvarchar ( 50 )   
 , @DateEntered as datetime  
 , @DatePlanned as datetime  
 , @DateReleased as datetime  
 , @State as bit  
 , @StatusCodeId as int  
 , @TypeCodeId as int  
 , @Description as nvarchar ( MAX )   
 , @CustomerStatusCodeId as int  
 , @CreateUserId as int  
 , @CreatePartnerId as int  
 , @FoundInCodeId as int  
 , @FixedInCodeId as int  
 , @AssignedUserId as int  
 , @Estimate as float ( 8 )   
 , @PriorityCodeId as int  
 , @SeverityCodeId as int  
 , @ComponentCodeId as int  
 , @ComponentTypeCodeId as int  
 , @ResolutionCodeId as int  
 , @DisplayToCustomer as bit  
 , @Archive as bit  
 , @RowGuid as uniqueidentifier  
  
 as begin update tCustomerRequest set   
 
 Title=@Title  
 , DateEntered=@DateEntered  
 , DatePlanned=@DatePlanned  
 , DateReleased=@DateReleased  
 , State=@State  
 , StatusCodeId=@StatusCodeId  
 , TypeCodeId=@TypeCodeId  
 , Description=@Description  
 , CustomerStatusCodeId=@CustomerStatusCodeId  
 , CreateUserId=@CreateUserId  
 , CreatePartnerId=@CreatePartnerId  
 , FoundInCodeId=@FoundInCodeId  
 , FixedInCodeId=@FixedInCodeId  
 , AssignedUserId=@AssignedUserId  
 , Estimate=@Estimate  
 , PriorityCodeId=@PriorityCodeId  
 , SeverityCodeId=@SeverityCodeId  
 , ComponentCodeId=@ComponentCodeId  
 , ComponentTypeCodeId=@ComponentTypeCodeId  
 , ResolutionCodeId=@ResolutionCodeId  
 , DisplayToCustomer=@DisplayToCustomer  
 , Archive=@Archive  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid
 
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetCustomerRequestNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetCustomerRequestNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetCustomerRequestNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetCustomerRequestNoteByRowGuid] 
@NoteGuid as uniqueidentifier
 , @CRGuid as uniqueidentifier
 , @NoteTypeCodeId as int
 , @Note as varchar ( 8000 ) 
 , @DateEntered as datetime
 , @DisplayToCustomer as bit
 , @CreateUserId as int
 , @CreatePartnerId as int
 , @RowGuid as uniqueidentifier

 as  update tCustomerRequestNote set 
CRGuid=@CRGuid
 , NoteTypeCodeId=@NoteTypeCodeId
 , Note=@Note
 , DateEntered=@DateEntered
 , DisplayToCustomer=@DisplayToCustomer
 , CreateUserId=@CreateUserId
 , CreatePartnerId=@CreatePartnerId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetDocumentRequestByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetDocumentRequestByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetDocumentRequestByRowGuid] AS' 
END
GO
--TDocumentRequest update
ALTER PROCEDURE [dbo].[usp_autoGen_updatetDocumentRequestByRowGuid]   
@requestId as uniqueidentifier  
 , @shortName as varchar ( 50 )   
 , @partnerId as int  
 , @partnerEmail as varchar ( 100 )   
 , @supplierShortName as varchar ( 50 )   
 , @supplierPartnerId as int  
 , @supplierMid as varchar ( 50 )   
 , @supplierEmail as varchar ( 1000 )   
 , @supplierUserId as int  
 , @emailBody as ntext  
 , @isReminder as bit  
 , @requestFilename as varchar ( 100 )   
 , @status as varchar ( 200 )   
 , @questionnaireRowGuid as uniqueidentifier  
 , @statusRowGuid as uniqueidentifier  
 , @receivedDate as datetime  
 , @sentDate as datetime  
 , @dueDate as datetime  
 , @reminderDate as datetime  
 , @entStatus as varchar ( 50 )   
 , @rowGuid as uniqueidentifier  
  
 as  begin 
 update tDocumentRequest set   
requestId=@requestId  
 , shortName=@shortName  
 , partnerId=@partnerId  
 , partnerEmail=@partnerEmail  
 , supplierShortName=@supplierShortName  
 , supplierPartnerId=@supplierPartnerId  
 , supplierMid=@supplierMid  
 , supplierEmail=@supplierEmail  
 , supplierUserId=@supplierUserId  
 , emailBody=@emailBody  
 , isReminder=@isReminder  
 , requestFilename=@requestFilename  
 , status=@status  
 , questionnaireRowGuid=@questionnaireRowGuid  
 , statusRowGuid=@statusRowGuid  
 , receivedDate=@receivedDate  
 , sentDate=@sentDate  
 , dueDate=@dueDate  
 , reminderDate=@reminderDate  
 , entStatus=@entStatus  
 where rowGuid = @rowGuid
 end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetDocumentRequestDetailsByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetDocumentRequestDetailsByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetDocumentRequestDetailsByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetDocumentRequestDetailsByRowGuid] 
@documentRequestRowGuid as uniqueidentifier
 , @detailId as uniqueidentifier
 , @shortName as varchar ( 50 ) 
 , @partnerId as int
 , @keyName as varchar ( 100 ) 
 , @keyValue as varchar ( 100 ) 
 , @keyDesc as varchar ( 1000 ) 
 , @docType as varchar ( 200 ) 
 , @questionRowGuid as uniqueidentifier
 , @questionniareRowGuid as uniqueidentifier
 , @sentQuestionRowGuid as uniqueidentifier
 , @assignmentRowGuid as uniqueidentifier
 , @statusRowGuid as uniqueidentifier
 , @responseRowGuid as uniqueidentifier
 , @copiedToDrs as bit
 , @rowGuid as uniqueidentifier

 as  update tDocumentRequestDetails set 
documentRequestRowGuid=@documentRequestRowGuid
 , detailId=@detailId
 , shortName=@shortName
 , partnerId=@partnerId
 , keyName=@keyName
 , keyValue=@keyValue
 , keyDesc=@keyDesc
 , docType=@docType
 , questionRowGuid=@questionRowGuid
 , questionniareRowGuid=@questionniareRowGuid
 , sentQuestionRowGuid=@sentQuestionRowGuid
 , assignmentRowGuid=@assignmentRowGuid
 , statusRowGuid=@statusRowGuid
 , responseRowGuid=@responseRowGuid
 , copiedToDrs=@copiedToDrs
 where rowGuid = @rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetEmailAssociatedQuestionnairesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetEmailAssociatedQuestionnairesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetEmailAssociatedQuestionnairesByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_updatetEmailAssociatedQuestionnairesByRowGuid]
@PartnerId as int
, @EmailGuid as uniqueidentifier
, @TemplateRowGuid as uniqueidentifier
, @StatusRowGuid as uniqueidentifier
, @ReminderInterval as int = 0
, @RowGuid as uniqueidentifier
as update tEmailAssociatedQuestionnaires set
PartnerId=@PartnerId
, EmailGuid=@EmailGuid
, TemplateRowGuid=@TemplateRowGuid
, StatusRowGuid=@StatusRowGuid
, ReminderInterval = @ReminderInterval
where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetEmailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetEmailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetEmailByRowGuid] AS' 
END
GO
 
 --TEmail update
 
   
ALTER  PROCEDURE [dbo].[usp_autoGen_updatetEmailByRowGuid]   
@EmailGuid as uniqueidentifier  
 , @PartnerId as int  
 , @SenderUserId as int  
 , @RecipientPartnerId as int  
 , @RecipientUserId as int  
 , @ToAddress as varchar ( 128 )   
 , @FromAddress as varchar ( 128 )   
 , @CCAddress as varchar ( 256 )   
 , @SendDate as datetime  
 , @Subject as nvarchar ( 256 )   
 , @Body as ntext  
 , @DueDate as datetime  
 , @ReminderDate as datetime  
 , @IsReminder as bit  
 , @ReminderNum as int  
 , @StatusGuid as uniqueidentifier  
 , @TemplateGuid as uniqueidentifier  
 , @AssignmentGuid as uniqueidentifier  
 , @Status as nvarchar ( 50 )   
 , @StatusDesc as nvarchar ( 2000 )   
 , @RetryNum as int  
 , @RetryDate as datetime  
 , @ForceAnswerOrder as varchar(1)  
 , @RowGuid as uniqueidentifier  
  
 as  begin update tEmail set   
SenderUserId=@SenderUserId  
 , RecipientPartnerId=@RecipientPartnerId  
 , RecipientUserId=@RecipientUserId  
 , ToAddress=@ToAddress  
 , FromAddress=@FromAddress  
 , CCAddress=@CCAddress  
 , SendDate=@SendDate  
 , Subject=@Subject  
 , Body=@Body  
 , DueDate=@DueDate  
 , ReminderDate=@ReminderDate  
 , IsReminder=@IsReminder  
 , ReminderNum=@ReminderNum  
 , StatusGuid=@StatusGuid  
 , TemplateGuid=@TemplateGuid  
 , AssignmentGuid=@AssignmentGuid  
 , Status=@Status  
 , StatusDesc=@StatusDesc  
 , RetryNum=@RetryNum  
 , RetryDate=@RetryDate  
 , ForceAnswerOrder=@ForceAnswerOrder  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid  
 end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetEmailHistoryByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetEmailHistoryByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetEmailHistoryByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_updatetEmailHistoryByRowGuid]     
@EmailGuid as uniqueidentifier    
 , @PartnerId as int    
 , @SenderUserId as int    
 , @RecipientPartnerId as int    
 , @RecipientUserId as int    
 , @ToAddress as varchar ( 128 )     
 , @FromAddress as varchar ( 128 )     
 , @CCAddress as varchar ( 256 )     
 , @SendDate as datetime    
 , @Subject as nvarchar ( 256 )     
 , @Body as nvarchar(MAX)    
 , @DueDate as datetime    
 , @ReminderDate as datetime    
 , @IsReminder as bit    
 , @ReminderNum as int    
 , @StatusGuid as uniqueidentifier    
 , @TemplateGuid as uniqueidentifier    
 , @AssignmentGuid as uniqueidentifier    
 , @Status as nvarchar ( 50 )     
 , @StatusDesc as nvarchar ( 1000 )     
 , @RetryNum as int    
 , @RetryDate as datetime    
 , @LinkFollowed as bit    
 , @RowGuid as uniqueidentifier    
    
 as begin update tEmailHistory set     
SenderUserId=@SenderUserId    
 , RecipientPartnerId=@RecipientPartnerId    
 , RecipientUserId=@RecipientUserId    
 , ToAddress=@ToAddress    
 , FromAddress=@FromAddress    
 , CCAddress=@CCAddress    
 , SendDate=@SendDate    
 , Subject=@Subject    
 , Body=@Body    
 , DueDate=@DueDate    
 , ReminderDate=@ReminderDate    
 , IsReminder=@IsReminder    
 , ReminderNum=@ReminderNum    
 , StatusGuid=@StatusGuid    
 , TemplateGuid=@TemplateGuid    
 , AssignmentGuid=@AssignmentGuid    
 , Status=@Status    
 , StatusDesc=@StatusDesc    
 , RetryNum=@RetryNum    
 , RetryDate=@RetryDate    
 , LinkFollowed=@LinkFollowed    
 , RowGuid=@RowGuid    
 where RowGuid = @RowGuid  
 end  
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetEmailTemplatesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetEmailTemplatesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetEmailTemplatesByRowGuid] AS' 
END
GO

  
ALTER PROCEDURE [dbo].[usp_autoGen_updatetEmailTemplatesByRowGuid]       
@EmailTemplateGuid as uniqueidentifier      
 , @PartnerId as int      
 , @Description as nvarchar ( 50 )       
 , @Subject as nvarchar ( 256 )       
 , @Body as nvarchar(MAX)      
 , @FromAddress as varchar ( 256 )    
 , @CCAddress as varchar ( 256 )      
 , @TemplateGuid as uniqueidentifier      
 , @RowGuid as uniqueidentifier
  , @Active as bit       
      
 as  update tEmailTemplates set       
Description=@Description      
 , Subject=@Subject      
 , Body=@Body      
 , FromAddress=@FromAddress    
 , CCAddress=@CCAddress    
 , TemplateGuid=@TemplateGuid      
 , RowGuid=@RowGuid 
 , Active=@Active  
   
 where RowGuid = @RowGuid   
   

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetHistoryByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetHistoryByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetHistoryByRowGuid] AS' 
END
GO
--Thistory update
ALTER PROCEDURE [dbo].[usp_autoGen_updatetHistoryByRowGuid]   
@HistoryId as  int   
 , @UserId as int  
 , @RowGuid as uniqueidentifier  
 , @RowTable as varchar ( 50 )   
 , @ActionType as varchar ( 10 )   
 , @ActionDate as datetime  
 , @ActionDescription as ntext  
  
 as begin update tHistory set   
UserId=@UserId  
 , RowGuid=@RowGuid  
 , RowTable=@RowTable  
 , ActionType=@ActionType  
 , ActionDate=@ActionDate  
 , ActionDescription=@ActionDescription  
 where RowGuid = @RowGuid
 end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetImportTmpByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetImportTmpByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetImportTmpByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetImportTmpByRowGuid] 
@importGuid as uniqueidentifier
 , @partnerid as int
 , @userId as int
 , @originalFilename as varchar ( 50 ) 
 , @importDate as datetime
 , @importType as varchar ( 50 ) 
 , @status as varchar ( 50 ) 
 , @rowGuid as uniqueidentifier

 as  update tImportTmp set 
originalFilename=@originalFilename
 , importDate=@importDate
 , importType=@importType
 , status=@status
 , rowGuid=@rowGuid
 where rowGuid = @rowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetImportTmpMappingByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetImportTmpMappingByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetImportTmpMappingByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetImportTmpMappingByRowGuid] 
@ImportGuid as uniqueidentifier
 , @PartnerId as int
 , @FileFieldName as varchar ( 100 ) 
 , @IPFieldName as varchar ( 100 ) 
 , @RowGuid as uniqueidentifier

 as  update tImportTmpMapping set 
RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetPartnerByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetPartnerByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetPartnerByRowGuid] AS' 
END
GO
--tPartner Update 
 ALTER PROCEDURE [dbo].[usp_autoGen_updatetPartnerByRowGuid]        
@PartnerId as int        
      
, @Name as nvarchar ( 100 )        
, @ShortName as nvarchar ( 80 )        
, @Address1 as nvarchar ( 100 )        
, @Address2 as nvarchar ( 100 )        
, @Address3 as nvarchar ( 200 )        
, @City as varchar ( 50 )        
, @StateCodeId as int        
, @CountryCodeId as int        
, @PostalCode as varchar ( 15 )        
, @Phone as varchar ( 50 )        
, @Fax as varchar ( 15 )        
, @Active as bit        
, @DefaultReminderInterval as int        
, @DefaultPasswordChangeInterval as int        
, @PrimaryUserId as int        
, @SviUsername as varchar ( 128 )        
, @SviPassword as varchar ( 100 )        
, @SviCompanyName as varchar ( 50 )        
, @SviNumber as varchar ( 100 )        
, @PortOfExport as varchar ( 50 ) = ''        
, @PartnerType as varchar ( 30 )        
, @EntPartnerId as varchar ( 50 )        
, @MID as varchar ( 50 )        
, @SendingEmailAsIp as bit        
, @SendingEmailAddress as varchar ( 128 )        
, @UpdateFlag as bit        
, @TabLimit as int        
, @RowGuid as uniqueidentifier        
, @FactoryNum as varchar ( 50 ) =''        
, @ProductNum as varchar ( 40 )=''        
, @NickName as nvarchar ( 80 )=''        
, @AutoSendCA as bit        
, @AnnualImportValue as varchar(50) = ''        
, @AnnualVolume as varchar(50) = ''        
, @DUNSNumber as varchar(50) = ''        
, @RequiresAccess as varchar(10) = ''        
, @Tier as varchar(100) = ''        
, @LastDateValidated as datetime = '01/01/1900'        
, @ParentCompanyName as nvarchar(100) = ''        
, @GPSLatitude as varchar(40) = ''        
, @GPSLongitude as varchar(40) = ''        
, @YearEstablished as varchar(4) = ''        
, @PublicPrivate as varchar(1) = ''        
, @WebsiteURL as varchar(250) = ''    
, @CADueDate as int  
, @ReminderIntervalCA as int
, @CARating as bit   
, @RenewQuestionnaire as bit       
as      
begin update tPartner set        
Name=@Name        
, ShortName=@ShortName        
, Address1=@Address1        
, Address2=@Address2        
, Address3=@Address3        
, City=@City        
, StateCodeId=@StateCodeId        
, CountryCodeId=@CountryCodeId        
, PostalCode=@PostalCode        
, Phone=@Phone        
, Fax=@Fax        
, Active=@Active        
, DefaultReminderInterval=@DefaultReminderInterval        
, DefaultPasswordChangeInterval=@DefaultPasswordChangeInterval        
, PrimaryUserId=@PrimaryUserId        
, SviUsername=@SviUsername        
, SviPassword=@SviPassword        
, SviCompanyName=@SviCompanyName        
, SviNumber=@SviNumber        
, PortOfExport=@PortOfExport        
, PartnerType=@PartnerType        
, EntPartnerId=@EntPartnerId        
, MID=@MID        
, SendingEmailAsIp=@SendingEmailAsIp        
, SendingEmailAddress=@SendingEmailAddress        
, UpdateFlag=@UpdateFlag        
, TabLimit=@TabLimit        
, RowGuid=@RowGuid        
, FactoryNum = @FactoryNum        
, ProductNum = @ProductNum        
, NickName = @NickName        
, NewRecord = 0        
, AutoSendCA = @AutoSendCA        
, AnnualImportValue = @AnnualImportValue        
, AnnualVolume = @AnnualVolume        
, DUNSNumber = @DUNSNumber        
, RequiresAccess = @RequiresAccess        
, Tier = @Tier        
, LastDateValidated = @LastDateValidated        
, ParentCompanyName = @ParentCompanyName        
, GPSLatitude = @GPSLatitude        
, GPSLongitude = @GPSLongitude        
, YearEstablished = @YearEstablished        
, WebsiteURL = @WebsiteURL        
, PublicPrivate = @PublicPrivate    
, CADueDate  = @CADueDate   
, ReminderIntervalCA = @ReminderIntervalCA
, CARating = @CARating   
, RenewQuestionnaire = @RenewQuestionnaire
where RowGuid = @RowGuid      
end
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetPartnerFactoryUpdate]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetPartnerFactoryUpdate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetPartnerFactoryUpdate] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_updatetPartnerFactoryUpdate]  
   @PartnerID as int  
 , @ChildID as int  
 , @FactoryNum as varchar ( 50 )  
 , @ChangedFlag as char(1)  
 as   
update tPartnerFactoryUpdate  
 Set   
   FactoryNum=@FactoryNum  
 , ChangeDate=GetDate()  
 , ChangedFlag=@ChangedFlag  
Where ParentID = @PartnerID and ChildID= @ChildID  

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetPartnerProductByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetPartnerProductByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetPartnerProductByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetPartnerProductByRowGuid] 
@PartnerID as int
 , @EffDate as datetime
 , @RowGuid as uniqueidentifier
 , @ProductNum as varchar ( 50 ) 
 , @ProductDesc as varchar ( 350 ) 
 , @ProductGuid as uniqueidentifier

 as  update tPartnerProduct set 
EffDate=@EffDate
 , ProductDesc=@ProductDesc
 , ProductGuid=@ProductGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetPartnerRelationshipByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetPartnerRelationshipByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetPartnerRelationshipByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetPartnerRelationshipByRowGuid] 
@RelationshipGuid as uniqueidentifier
 , @ParentId as int
 , @ChildId as int
 , @RelationshipTypeCodeId as int
 , @ReferenceCode as varchar ( 50 ) 
 , @ReferenceNumber as varchar ( 60 ) 
 , @PartnerTypeCodeId as int
 , @RowGuid as uniqueidentifier

 as  update tPartnerRelationship set 
RelationshipTypeCodeId=@RelationshipTypeCodeId
 , ReferenceCode=@ReferenceCode
 , ReferenceNumber=@ReferenceNumber
 , PartnerTypeCodeId=@PartnerTypeCodeId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetPartnerRelationshipGroupByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetPartnerRelationshipGroupByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetPartnerRelationshipGroupByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetPartnerRelationshipGroupByRowGuid] 
@PartnerRelationshipRowGuid as uniqueidentifier
 , @ParentId as int
 , @ChildId as int
 , @GroupType as varchar ( 50 ) 
 , @RowGuid as uniqueidentifier

 as  update tPartnerRelationshipGroup set 
RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetPartnerRelationshipParentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetPartnerRelationshipParentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetPartnerRelationshipParentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetPartnerRelationshipParentByRowGuid]    
@PartnerRelationshipRowGuid as uniqueidentifier    
, @ImporterId as int    
, @ChildId as int    
, @ParentName as varchar ( 50 )    
, @RowGuid as uniqueidentifier    
   
as update tPartnerRelationshipParent set    
RowGuid=@RowGuid    
where RowGuid = @RowGuid   
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetQuestionAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetQuestionAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetQuestionAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetQuestionAttachmentByRowGuid] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @UserId as int
 , @AttachmentTypeCodeId as int
 , @RowGuid as uniqueidentifier

 as  update tQuestionAttachment set 
OriginalFilename=@OriginalFilename
 , DateEntered=@DateEntered
 , UserId=@UserId
 , AttachmentTypeCodeId=@AttachmentTypeCodeId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetQuestionBodyByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetQuestionBodyByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetQuestionBodyByRowGuid] AS' 
END
GO
--tQuestionBody Update  
  
ALTER PROCEDURE [dbo].[usp_autoGen_updatetQuestionBodyByRowGuid]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @CultureId as varchar ( 10 )     
 , @Body as nvarchar(MAX)    
 , @RowGuid as uniqueidentifier    
    
 as  begin  
 update tQuestionBody set     
Body=@Body    
 , RowGuid=@RowGuid    
 where RowGuid = @RowGuid  
 end   
 
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetQuestionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetQuestionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetQuestionByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_updatetQuestionByRowGuid]   
	@QuestionGuid as uniqueidentifier   
	, @PartnerId as int   
	, @AllowNotes as bit   
	, @AllowAttachments as bit   
	, @ResponseTypeCodeId as int   
	, @Shared as bit   
	, @DepartmentCodeId as int   
	, @CategoryCodeId as int   
	, @PortCodeId as int   
	, @IndustryCodeId as int   
	, @RegionCodeId as int   
	, @ImportanceCodeId as int 
	, @WeightCodeId as int  
	, @Description as nvarchar ( 500 )   
	, @Active as bit   
	, @TypeCodeId as int   
	, @RowGuid as uniqueidentifier  
	, @Version as nvarchar ( 100 ) 
as 
begin 
	update tQuestion set   
	AllowNotes=@AllowNotes   
	, AllowAttachments=@AllowAttachments   
	, ResponseTypeCodeId=@ResponseTypeCodeId   
	, Shared=@Shared   
	, DepartmentCodeId=@DepartmentCodeId   
	, CategoryCodeId=@CategoryCodeId   
	, PortCodeId=@PortCodeId   
	, IndustryCodeId=@IndustryCodeId   
	, RegionCodeId=@RegionCodeId   
	, ImportanceCodeId=@ImportanceCodeId  
	, WeightCodeId=@WeightCodeId
	, Description=@Description   
	, Active=@Active   
	, TypeCodeId=@TypeCodeId
	, Version=@Version
	, RowGuid=@RowGuid   
	where RowGuid = @RowGuid
end  
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetQuestionnaireStatusByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetQuestionnaireStatusByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetQuestionnaireStatusByRowGuid] AS' 
END
GO
  
ALTER PROCEDURE [dbo].[usp_autoGen_updatetQuestionnaireStatusByRowGuid]  
@StatusGuid as uniqueidentifier  
, @PartnerId as int  
, @TemplateGuid as uniqueidentifier  
, @RecipientPartnerId as int  
, @DateSent as datetime  
, @LastAccessDate as datetime  
, @LastAccessUser as int  
, @LastReminderDate as datetime  
, @ReminderScheduled as bit  
, @StatusCodeId as int  
, @StatusDescription as nvarchar(MAX)  
, @DueDate as datetime  
, @Archive as bit  
, @ArchiveDate as datetime = '01/01/1900'  
, @Name as nvarchar ( 50 )  
, @Description as nvarchar ( 200 )  
, @DisplayDescription as nvarchar ( 4000 )  
, @GroupBy as varchar ( 50 )  
, @CategoryOrder as varchar ( 50 )  
, @TypeCodeId as int  
, @RowGuid as uniqueidentifier  
, @deleted as bit  
, @rating as varchar (1) = ''  
, @ReminderInterval as int = 0 
, @IsRenewed as bit = 0
as update tQuestionnaireStatus set  
TemplateGuid=@TemplateGuid  
, RecipientPartnerId=@RecipientPartnerId  
, DateSent=@DateSent  
, LastAccessDate=@LastAccessDate  
, LastAccessUser=@LastAccessUser  
, LastReminderDate=@LastReminderDate  
, ReminderScheduled=@ReminderScheduled  
, StatusCodeId=@StatusCodeId  
, StatusDescription=@StatusDescription  
, DueDate=@DueDate  
, Archive=@Archive  
, ArchiveDate=@ArchiveDate  
, Name=@Name  
, Description=@Description  
, DisplayDescription=@DisplayDescription  
, GroupBy=@GroupBy  
, CategoryOrder=@CategoryOrder  
, TypeCodeId=@TypeCodeId  
, RowGuid=@RowGuid  
, deleted = @deleted  
, rating = @rating  
, ReminderInterval = @ReminderInterval  
, IsRenewed = @IsRenewed
where RowGuid = @RowGuid

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetQuestionResponseDefinitionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetQuestionResponseDefinitionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetQuestionResponseDefinitionByRowGuid] AS' 
END
GO
 --tQuestionResponseDefinition update
 
   
  
ALTER PROCEDURE [dbo].[usp_autoGen_updatetQuestionResponseDefinitionByRowGuid]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @ResponseNum as int    
 , @DisplayOrder as int    
 , @RiskRatingCodeId as int    
 , @NotesMandatory as bit  
 , @AttachmentsMandatory as bit   
 , @BestPractice as bit    
 , @Alert as bit    
 , @CorrectiveActionFlag as bit    
 , @CorrectiveAction as nvarchar (MAX)     
 , @FollowupRowGuid as uniqueidentifier    
 , @ResponseNote as varchar ( 1000 )     
 , @RowGuid as uniqueidentifier    
    
 as begin update tQuestionResponseDefinition set     
DisplayOrder=@DisplayOrder    
 , RiskRatingCodeId=@RiskRatingCodeId    
 , NotesMandatory=@NotesMandatory  
 , AttachmentsMandatory=@AttachmentsMandatory   
 , BestPractice=@BestPractice    
 , Alert=@Alert    
 , CorrectiveActionFlag=@CorrectiveActionFlag    
 , CorrectiveAction=@CorrectiveAction    
 , FollowupRowGuid=@FollowupRowGuid    
 , ResponseNote=@ResponseNote    
 , RowGuid=@RowGuid    
 where RowGuid = @RowGuid 
 end   

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetQuestionResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetQuestionResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetQuestionResponseDetailByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_updatetQuestionResponseDetailByRowGuid]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @CultureId as varchar ( 10 )   
 , @ResponseNum as int  
 , @DisplayText as nvarchar(MAX)  
 , @RowGuid as uniqueidentifier  
  
 as  update tQuestionResponseDetail set   
DisplayText=@DisplayText  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetReminderByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetReminderByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetReminderByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetReminderByRowGuid] 
@ReminderGuid as uniqueidentifier
 , @TemplateGuid as uniqueidentifier
 , @SenderId as int
 , @RecipientId as int
 , @EmailGuid as uniqueidentifier
 , @ScheduledDate as datetime
 , @RowGuid as uniqueidentifier

 as  update tReminder set 
TemplateGuid=@TemplateGuid
 , SenderId=@SenderId
 , RecipientId=@RecipientId
 , EmailGuid=@EmailGuid
 , ScheduledDate=@ScheduledDate
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetResponseAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetResponseAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetResponseAttachmentByRowGuid] AS' 
END
GO
  ALTER PROCEDURE [dbo].[usp_autoGen_updatetResponseAttachmentByRowGuid] 
@ResponseGuid as uniqueidentifier
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @gtnGuid as varchar ( 250 )
 , @PartnerId as int
 , @UserId as int
 , @AttachTypeCodeId as varchar ( 50 ) 
 , @RowGuid as uniqueidentifier

 as  update tResponseAttachment set 
OriginalFilename=@OriginalFilename
 , DateEntered=@DateEntered
 , gtnGuid=@gtnGuid
 , PartnerId=@PartnerId
 , UserId=@UserId
 , AttachTypeCodeId=@AttachTypeCodeId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
 
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetResponseByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetResponseByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetResponseByRowGuid] AS' 
END
GO
--tResponse update

  
  
ALTER PROCEDURE [dbo].[usp_autoGen_updatetResponseByRowGuid]     
@ResponseGuid as uniqueidentifier    
 , @AssignmentGuid as uniqueidentifier    
 , @QuestionGuid as uniqueidentifier    
 , @ResponseRatingCodeId as int    
 , @NotesMandatory as bit   
 , @AttachmentsMandatory as bit    
 , @BestPractice as bit    
 , @Alert as bit    
 , @CorrectiveActionFlag as bit    
 , @CorrectiveAction as nvarchar (MAX)     
 , @AuditCodeId as int    
 , @AuditDate as datetime    
 , @RowGuid as uniqueidentifier    
    
 as begin update tResponse set     
ResponseRatingCodeId=@ResponseRatingCodeId    
 , NotesMandatory=@NotesMandatory   
 , AttachmentsMandatory=@AttachmentsMandatory  
 , BestPractice=@BestPractice    
 , Alert=@Alert    
 , CorrectiveActionFlag=@CorrectiveActionFlag    
 , CorrectiveAction=@CorrectiveAction    
 , AuditCodeId=@AuditCodeId    
 , AuditDate=@AuditDate    
 , RowGuid=@RowGuid    
 where RowGuid = @RowGuid  
 end

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetResponseDetailAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetResponseDetailAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetResponseDetailAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetResponseDetailAttachmentByRowGuid] 
@ResponseGuid as uniqueidentifier
 , @ResponseDetailRowGuid as uniqueidentifier
 , @ResponseAttachmentRowGuid as uniqueidentifier
 , @RowGuid as uniqueidentifier

 as  update tResponseDetailAttachment set 
RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetResponseDetailByRowGuid] AS' 
END
GO
--tResponseDetail update
 ALTER  PROCEDURE [dbo].[usp_autoGen_updatetResponseDetailByRowGuid]   
@ResponseGuid as uniqueidentifier  
 , @ResponseNum as int  
 , @ResponseRatingCodeId as int  
 , @Response as nvarchar ( 50 )   
 , @RowGuid as uniqueidentifier  
 , @Override as bit   
 , @OverrideNotes as ntext
   
 as  begin update tResponseDetail set   
ResponseRatingCodeId=@ResponseRatingCodeId  
 , ResponseNum=@ResponseNum  
 , Response=@Response  
 , RowGuid=@RowGuid  
 , Override =  @Override
 , OverrideNotes = @OverrideNotes
 where RowGuid = @RowGuid   
 end 


GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetResponseDetailNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetResponseDetailNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetResponseDetailNoteByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetResponseDetailNoteByRowGuid] 
@ResponseGuid as uniqueidentifier
 , @ResponseDetailRowGuid as uniqueidentifier
 , @ResponseNoteRowGuid as uniqueidentifier
 , @RowGuid as uniqueidentifier

 as  update tResponseDetailNote set 
RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetResponseNoteByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetResponseNoteByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetResponseNoteByRowGuid] AS' 
END
GO

   
ALTER PROCEDURE [dbo].[usp_autoGen_updatetResponseNoteByRowGuid]     
@ResponseGuid as uniqueidentifier    
 , @PartnerId as int    
 , @UserId as int    
 , @NoteNum as int    
 , @NoteTypeCodeId as int    
 , @Note as nvarchar(MAX)    
 , @DateEntered as datetime    
 , @RowGuid as uniqueidentifier    
    
 as begin update tResponseNote set     
PartnerId=@PartnerId    
 , UserId=@UserId    
 , NoteTypeCodeId=@NoteTypeCodeId    
 , Note=@Note    
 , DateEntered=@DateEntered    
 , RowGuid=@RowGuid    
 where RowGuid = @RowGuid  
 end   
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetSentQuestionAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetSentQuestionAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionAttachmentByRowGuid] 
@QuestionGuid as uniqueidentifier
 , @PartnerId as int
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @UserId as int
 , @AttachmentTypeCodeId as int
 , @RowGuid as uniqueidentifier

 as  update tSentQuestionAttachment set 
OriginalFilename=@OriginalFilename
 , DateEntered=@DateEntered
 , UserId=@UserId
 , AttachmentTypeCodeId=@AttachmentTypeCodeId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetSentQuestionBodyByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetSentQuestionBodyByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionBodyByRowGuid] AS' 
END
GO

 
 ALTER PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionBodyByRowGuid]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @CultureId as varchar ( 10 )   
 , @Body as nvarchar(MAX)  
 , @OriginalRowGuid as uniqueidentifier  
 , @RowGuid as uniqueidentifier  
  
 as  update tSentQuestionBody set   
Body=@Body  
 , OriginalRowGuid=@OriginalRowGuid  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetSentQuestionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetSentQuestionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionByRowGuid] AS' 
END
GO

--TSentQuestion Update  
    
ALTER PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionByRowGuid]     
@QuestionGuid as uniqueidentifier     
, @OriginalQuestionGuid as uniqueidentifier     
, @PartnerId as int     
, @AllowNotes as bit     
, @AllowAttachments as bit     
, @ResponseTypeCodeId as int     
, @Shared as bit     
, @DepartmentCodeId as int     
, @CategoryCodeId as int     
, @PortCodeId as int     
, @IndustryCodeId as int     
, @RegionCodeId as int     
, @ImportanceCodeId as int     
, @WeightCodeId as int  
, @Description as nvarchar ( 100 )     
, @Active as bit     
, @TypeCodeId as int     
, @OriginalRowGuid as uniqueidentifier     
, @RowGuid as uniqueidentifier     
as begin update tSentQuestion set     
OriginalQuestionGuid=@OriginalQuestionGuid     
, AllowNotes=@AllowNotes     
, AllowAttachments=@AllowAttachments     
, ResponseTypeCodeId=@ResponseTypeCodeId     
, Shared=@Shared     
, DepartmentCodeId=@DepartmentCodeId     
, CategoryCodeId=@CategoryCodeId     
, PortCodeId=@PortCodeId     
, IndustryCodeId=@IndustryCodeId     
, RegionCodeId=@RegionCodeId     
, ImportanceCodeId=@ImportanceCodeId
, WeightCodeId=@WeightCodeId     
, Description=@Description     
, Active=@Active     
, TypeCodeId=@TypeCodeId     
, OriginalRowGuid=@OriginalRowGuid     
, RowGuid=@RowGuid     
where RowGuid = @RowGuid   
end  
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetSentQuestionResponseDefinitionByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetSentQuestionResponseDefinitionByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionResponseDefinitionByRowGuid] AS' 
END
GO
  --tSentQuestionResponseDefinition 
  
    
  
ALTER PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionResponseDefinitionByRowGuid]     
@QuestionGuid as uniqueidentifier    
 , @PartnerId as int    
 , @ResponseNum as int    
 , @DisplayOrder as int    
 , @RiskRatingCodeId as int    
 , @NotesMandatory as bit  
 , @AttachmentsMandatory as bit   
 , @BestPractice as bit    
 , @Alert as bit    
 , @CorrectiveActionFlag as bit    
 , @CorrectiveAction as nvarchar ( MAX )     
 , @FollowupRowGuid as uniqueidentifier    
 , @ResponseNote as varchar ( 1000 )     
 , @OriginalRowGuid as uniqueidentifier    
 , @RowGuid as uniqueidentifier    
    
 as begin update tSentQuestionResponseDefinition set     
DisplayOrder=@DisplayOrder    
 , RiskRatingCodeId=@RiskRatingCodeId    
 , NotesMandatory=@NotesMandatory  
 , AttachmentsMandatory=@AttachmentsMandatory   
 , BestPractice=@BestPractice    
 , Alert=@Alert    
 , CorrectiveActionFlag=@CorrectiveActionFlag    
 , CorrectiveAction=@CorrectiveAction    
 , FollowupRowGuid=@FollowupRowGuid    
 , ResponseNote=@ResponseNote    
 , OriginalRowGuid=@OriginalRowGuid    
 , RowGuid=@RowGuid    
 where RowGuid = @RowGuid   
end  

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetSentQuestionResponseDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetSentQuestionResponseDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionResponseDetailByRowGuid] AS' 
END
GO

ALTER PROCEDURE [dbo].[usp_autoGen_updatetSentQuestionResponseDetailByRowGuid]   
@QuestionGuid as uniqueidentifier  
 , @PartnerId as int  
 , @CultureId as varchar ( 10 )   
 , @ResponseNum as int  
 , @DisplayText as nvarchar(MAX)  
 , @OriginalRowGuid as uniqueidentifier  
 , @RowGuid as uniqueidentifier  
  
 as  update tSentQuestionResponseDetail set   
DisplayText=@DisplayText  
 , OriginalRowGuid=@OriginalRowGuid  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid
 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetTemplateAttachmentByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetTemplateAttachmentByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetTemplateAttachmentByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetTemplateAttachmentByRowGuid] 
@TemplateGuid as uniqueidentifier
 , @AttachNum as int
 , @OriginalFilename as varchar ( 256 ) 
 , @DateEntered as datetime
 , @PartnerId as int
 , @UserId as int
 , @AttachmentTypeCodeId as varchar ( 50 ) 
 , @RowGuid as uniqueidentifier

 as  update tTemplateAttachment set 
OriginalFilename=@OriginalFilename
 , DateEntered=@DateEntered
 , PartnerId=@PartnerId
 , UserId=@UserId
 , AttachmentTypeCodeId=@AttachmentTypeCodeId
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetTemplateDetailByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetTemplateDetailByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetTemplateDetailByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetTemplateDetailByRowGuid] 
@TemplateGuid as uniqueidentifier
 , @PartnerId as int
 , @DetailGuid as uniqueidentifier
 , @DetailTypeCodeId as int
 , @DetailNum as int
 , @DetailParentRowGuid as uniqueidentifier
 , @DisplayOrder as int
 , @DetailLevel as int
 , @RowGuid as uniqueidentifier

 as  update tTemplateDetail set 
DetailParentRowGuid=@DetailParentRowGuid
 , DisplayOrder=@DisplayOrder
 , DetailLevel=@DetailLevel
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetTemplateHeaderByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetTemplateHeaderByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetTemplateHeaderByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetTemplateHeaderByRowGuid]   
@TemplateGuid as uniqueidentifier  
 , @PartnerId as int  
 , @Name as nvarchar ( 100 )   
 , @Description as nvarchar ( 200 )   
 , @Active as bit  
 , @DisplayDescription as nvarchar ( 4000 )   
 , @GroupBy as varchar ( 50 )   
 , @CategoryOrder as varchar ( 50 )   
 , @TypeCodeId as int  
 , @RowGuid as uniqueidentifier  
  ,@IsRenewed as bit
 ,@OriginalTemplateGuid as varchar (50)
 as begin update tTemplateHeader set   
Name=@Name  
 , Description=@Description  
 , Active=@Active  
 , DisplayDescription=@DisplayDescription  
 , GroupBy=@GroupBy  
 , CategoryOrder=@CategoryOrder  
 , TypeCodeId=@TypeCodeId  
 , RowGuid=@RowGuid  
 , IsRenewed = @IsRenewed
 , OriginalTemplateGuid = @OriginalTemplateGuid
 where RowGuid = @RowGuid
 end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetTemplateRulesByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetTemplateRulesByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetTemplateRulesByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetTemplateRulesByRowGuid] 
@TemplateGuid as uniqueidentifier
 , @PartnerId as int
 , @TemplateDetailRowGuid as uniqueidentifier
 , @QuestionRowGuid as uniqueidentifier
 , @QuestionResponseDefinitionRowGuid as uniqueidentifier
 , @ActionCodeId as int
 , @ResultQuestionRowGuid as uniqueidentifier
 , @RuleNote as varchar ( 1000 ) 
 , @RowGuid as uniqueidentifier

 as  update tTemplateRules set 
ActionCodeId=@ActionCodeId
 , ResultQuestionRowGuid=@ResultQuestionRowGuid
 , RuleNote=@RuleNote
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetUserByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetUserByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetUserByRowGuid] AS' 
END
GO
  --tUser update
  
    
  
  
  
  
ALTER     PROCEDURE [dbo].[usp_autoGen_updatetUserByRowGuid]   
@UserId as  int   
 , @PartnerId as int  
 , @Firstname as nvarchar ( 50 )   
 , @Middlename as nvarchar ( 50 )   
 , @Lastname as nvarchar ( 50 )   
 , @Username as nvarchar ( 128 )   
 , @Password as varchar ( 50 )   
 , @Email as varchar ( 128 )   
 , @Title as nvarchar ( 50 )   
 , @DepartmentCodeId as int  
 , @Phone as varchar ( 25 )   
 , @Fax as varchar ( 15 )   
 , @Address1 as nvarchar ( 50 )   
 , @Address2 as nvarchar ( 50 )   
 , @Address3 as nvarchar ( 50 )   
 , @City as varchar ( 50 )   
 , @StateCodeId as int  
 , @CountryCodeId as int  
 , @PostalCode as varchar ( 15 )   
 , @CultureId as varchar ( 10 )   
 , @Active as bit  
 , @RoleCodeId as int  
 , @AlertQstr as bit  
 , @AlertQstn as bit  
 , @LastLogin as datetime  
 , @LastPasswordChange as datetime  
 , @ForcePasswordChange as bit  
 , @PasswordChangeInterval as int  
 , @CurrentPasswordRetries as int  
 , @PasswordRetriesLockoutInterval as int  
 , @DefaultSessionTimeoutInterval as int  
 , @DefaultTypeCodeId as int  
 , @UpdateFlag as bit  
 , @RowGuid as uniqueidentifier  
  
 as begin  update tUser set   
Firstname=@Firstname  
 , Middlename=@Middlename  
 , Lastname=@Lastname  
 , Username=@Username  
 , Password=@Password  
 , Email=@Email  
 , Title=@Title  
 , DepartmentCodeId=@DepartmentCodeId  
 , Phone=@Phone  
 , Fax=@Fax  
 , Address1=@Address1  
 , Address2=@Address2  
 , Address3=@Address3  
 , City=@City  
 , StateCodeId=@StateCodeId  
 , CountryCodeId=@CountryCodeId  
 , PostalCode=@PostalCode  
 , CultureId=@CultureId  
 , Active=@Active  
 , RoleCodeId=@RoleCodeId  
 , AlertQstr=@AlertQstr  
 , AlertQstn=@AlertQstn  
 , LastLogin=@LastLogin  
 , LastPasswordChange=@LastPasswordChange  
 , ForcePasswordChange=@ForcePasswordChange  
 , PasswordChangeInterval=@PasswordChangeInterval  
 , CurrentPasswordRetries=@CurrentPasswordRetries  
 , PasswordRetriesLockoutInterval = @PasswordRetriesLockoutInterval   
 , DefaultSessionTimeoutInterval = @DefaultSessionTimeoutInterval  
 , DefaultTypeCodeId=@DefaultTypeCodeId  
 , UpdateFlag=@UpdateFlag  
 , RowGuid=@RowGuid  
 where RowGuid = @RowGuid  
  
  end
 
  
  
 
   
  


 


  
  
  
  

   
  

  
  
   
    
  
  
   
  




























GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetViewTabAssociationsByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetViewTabAssociationsByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetViewTabAssociationsByRowGuid] AS' 
END
GO
   
    
ALTER PROCEDURE [dbo].[usp_autoGen_updatetViewTabAssociationsByRowGuid]    
@PartnerId as int    
, @ViewTabRowGuid as uniqueidentifier    
, @ViewTabName as varchar ( 30 )    
, @TableName as varchar ( 200 )    
, @TableRowGuid as uniqueidentifier    
, @AccountNumber as varchar(100) = ''    
, @RowGuid as uniqueidentifier    
as update tViewTabAssociations set    
ViewTabName=@ViewTabName   
,ViewTabRowGuid =  @ViewTabRowGuid  
, TableRowGuid=@TableRowGuid    
where TableRowGuid = @TableRowGuid 



GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetViewTabByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetViewTabByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetViewTabByRowGuid] AS' 
END
GO
 --tViewTab update
 
 ALTER PROCEDURE [dbo].[usp_autoGen_updatetViewTabByRowGuid]    
@PartnerId as int    
, @TabName as nvarchar ( 30 )    
, @TabTip as nvarchar ( 100 )    
, @TabDesc as nvarchar ( 1000 )    
, @DisplayOrder as int    
, @Active as bit    
, @CreateUser as int    
, @CreateDate as datetime    
, @DefaultFlag as bit    
, @RowGuid as uniqueidentifier      
as begin update tViewTab set    
TabName=@TabName    
, TabTip=@TabTip    
, TabDesc=@TabDesc    
, DisplayOrder=@DisplayOrder    
, Active=@Active    
, CreateUser=@CreateUser    
, CreateDate=@CreateDate    
, DefaultFlag=@DefaultFlag    
, RowGuid=@RowGuid    
where RowGuid = @RowGuid
end 

GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetViewTabSqlByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetViewTabSqlByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetViewTabSqlByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetViewTabSqlByRowGuid] 
@TabSqlName as varchar ( 200 ) 
 , @TabSqlDescription as varchar ( 2000 ) 
 , @TypeCodeId as int
 , @DisplayLocation as int
 , @Active as bit
 , @RowGuid as uniqueidentifier

 as  update tViewTabSql set 
TabSqlDescription=@TabSqlDescription
 , DisplayLocation=@DisplayLocation
 , Active=@Active
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_autoGen_updatetViewTabSqlUsageByRowGuid]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_autoGen_updatetViewTabSqlUsageByRowGuid]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_autoGen_updatetViewTabSqlUsageByRowGuid] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_autoGen_updatetViewTabSqlUsageByRowGuid] 
@TabSqlName as varchar ( 200 ) 
 , @PartnerId as int
 , @UserId as int
 , @DisplayColumn as int
 , @DisplayOrder as int
 , @Title as varchar ( 50 ) 
 , @RowGuid as uniqueidentifier

 as  update tViewTabSqlUsage set 
Title=@Title
 , RowGuid=@RowGuid
 where RowGuid = @RowGuid
GO
/****** Object:  StoredProcedure [dbo].[usp_getAvailableLanguages]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_getAvailableLanguages]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_getAvailableLanguages] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_getAvailableLanguages] AS
select cultureId as codeId
	,name as decode
from tCulture
where partnerId = 0
GO
/****** Object:  StoredProcedure [dbo].[usp_getCodesByFieldName]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_getCodesByFieldName]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_getCodesByFieldName] AS' 
END
GO

ALTER   PROCEDURE [dbo].[usp_getCodesByFieldName] @fieldName  varChar(30), @partnerId int  AS
select codeId, encode, decode from tCodes
where fieldName = @fieldName
and (partnerId = 0 or partnerId = @partnerId)

GO
/****** Object:  StoredProcedure [dbo].[usp_insertQuestionnaire]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_insertQuestionnaire]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_insertQuestionnaire] AS' 
END
GO
ALTER PROCEDURE [dbo].[usp_insertQuestionnaire]
 @partnerId as int
, @name as VarChar(48)
, @description as VarChar(200)

AS

insert into tTemplateHeader
( partnerId
, name
, description )
values
( @partnerId
, @name
, @description );

select IDENT_CURRENT('tQuestionnaire')
as questionnaireTemplateId;
GO
/****** Object:  StoredProcedure [dbo].[usp_insertUser]    Script Date: 3/6/2020 1:27:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_insertUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[usp_insertUser] AS' 
END
GO
ALTER procedure [dbo].[usp_insertUser]
   @PartnerId as int
 , @Firstname as varchar(50)
 , @Middlename as varchar(50)
 , @Lastname as varchar(50)
 , @Username as varchar(15)
 , @Password as varchar(50)
 , @Email as varchar(128)
 , @Title as varchar(50)
 , @DepartmentCodeId as int
 , @Phone as varchar(15)
 , @Fax as varchar(15)
 , @Address1 as varchar(50)
 , @Address2 as varchar(50)
 , @Address3 as varchar(50)
 , @City as varchar(50)
 , @StateCodeId as int
 , @CountryCodeId as int
 , @PostalCode as varchar(15)
 , @CultureId as varchar(10)
 , @Active as bit
 , @LastLogin as datetime
 , @LastPasswordChange as datetime
 , @ForcePasswordChange as bit
 , @PasswordChangeInterval as int

as

INSERT INTO tUser 
(
   PartnerId
 , Firstname
 , Middlename
 , Lastname
 , Username
 , Password
 , Email
 , Title
 , DepartmentCodeId
 , Phone
 , Fax
 , Address1
 , Address2
 , Address3
 , City
 , StateCodeId
 , CountryCodeId
 , PostalCode
 , CultureId
 , Active
 , LastLogin
 , LastPasswordChange
 , ForcePasswordChange
 , PasswordChangeInterval
)
VALUES(
   @PartnerId
 , @Firstname
 , @Middlename
 , @Lastname
 , @Username
 , @Password
 , @Email
 , @Title
 , @DepartmentCodeId
 , @Phone
 , @Fax
 , @Address1
 , @Address2
 , @Address3
 , @City
 , @StateCodeId
 , @CountryCodeId
 , @PostalCode
 , @CultureId
 , @Active
 , @LastLogin
 , @LastPasswordChange
 , @ForcePasswordChange
 , @PasswordChangeInterval
)

GO
