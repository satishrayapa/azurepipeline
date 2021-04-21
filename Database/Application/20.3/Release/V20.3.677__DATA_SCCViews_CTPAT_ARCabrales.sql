/*
	This script creates SCC Default Views on Database
	RUN AGAINST SCC Partner DB.
*/

/****** Object:  View [dbo].[vAllResponseDetails]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vAllResponseDetails]'))
EXEC dbo.sp_executesql @statement = N'    
  
   
CREATE VIEW [dbo].[vAllResponseDetails]
AS
SELECT CAST(r.ResponseGuid AS varchar(50)) AS responseguid, CAST(r.AssignmentGuid AS varchar(50)) AS assignmentguid, CAST(r.QuestionGuid AS varchar(50))
AS questionguid, r.ResponseRatingCodeId, r.BestPractice, r.NotesMandatory, r.AttachmentsMandatory, r.Alert, r.CorrectiveAction, r.CorrectiveActionFlag, r.AuditCodeId,
r.AuditDate, CAST(r.RowGuid AS varchar(50)) AS responseRowGuid, d.ResponseNum, d.ResponseRatingCodeId AS detailResponseRatingCodeid,
CAST(d.Response AS varchar(50)) AS response, CAST(d.RowGuid AS varchar(50)) AS responseDetailRowGuid, a.AttachNum, a.OriginalFilename, a.gtnguid,
a.DateEntered AS attachdateentered, a.PartnerId AS attachpartnerid, a.UserId AS attachuserid, a.AttachTypeCodeId, CAST(a.RowGuid AS varchar(50)) AS attachRowGuid,
n.PartnerId AS notePartnerId, n.UserId AS noteUserId, n.NoteNum, n.NoteTypeCodeId, n.Note, n.DateEntered AS noteDateEntered, CAST(n.RowGuid AS varchar(50))
AS noteRowGuid
FROM dbo.tResponse AS r WITH (nolock) INNER JOIN
dbo.tResponseDetail AS d WITH (nolock) ON r.ResponseGuid = d.ResponseGuid LEFT OUTER JOIN
dbo.tResponseAttachment AS a WITH (nolock) ON r.ResponseGuid = a.ResponseGuid LEFT OUTER JOIN
dbo.tResponseNote AS n WITH (nolock) ON r.ResponseGuid = n.ResponseGuid
  
' 
GO
/****** Object:  View [dbo].[vGrouMembership]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vGrouMembership]'))
EXEC dbo.sp_executesql @statement = N'
Create      view [dbo].[vGrouMembership]
as
select partnerid, groupid, userid from tgroupmembership


' 
GO
/****** Object:  View [dbo].[vLoadAssignments]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vLoadAssignments]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vLoadAssignments] AS
SELECT     CAST(s.StatusGuid AS varchar(50)) AS statusguid, s.isrenewed, s.PartnerId, CAST(s.TemplateGuid AS varchar(50)) AS templateguid, s.RecipientPartnerId, s.DateSent, 
                      s.LastAccessDate, s.LastAccessUser, s.LastReminderDate, s.ReminderScheduled, s.StatusCodeId, s.StatusDescription, s.DueDate, s.Archive, s.Name, 
                      s.Description, s.DisplayDescription, s.GroupBy, s.CategoryOrder, s.TypeCodeId, CAST(s.RowGuid AS varchar(50)) AS srowguid, 
                      CAST(a.AssignmentGuid AS varchar(50)) AS assignmentguid, a.AssignmentTypeCodeId, a.AssignmentNum, CAST(a.SourceGuid AS varchar(50)) 
                      AS sourceguid, a.SenderUserId, a.RecipientPartnerId AS assignmentRecipientPartnerId, a.AssignedUserId, a.Status, a.lastAccessedDate, 
                      a.lastAccessedBy, a.AssignmentLevel, CAST(a.OriginalTemplateDetailRowGuid AS varchar(50)) AS originaltemplatedetailrowguid, a.Skip, 
                      CAST(a.RowGuid AS varchar(50)) AS arowguid, CAST(q.QuestionGuid AS varchar(50)) AS questionguid, CAST(q.OriginalQuestionGuid AS varchar(50)) 
                      AS originalquestionguid, q.PartnerId AS questionpartnerid, q.AllowNotes, q.AllowAttachments, q.ResponseTypeCodeId, q.Shared, q.DepartmentCodeId, 
                      q.CategoryCodeId, q.PortCodeId, q.IndustryCodeId, q.RegionCodeId, q.ImportanceCodeId, q.Description AS questionDescription, 
                      q.Active AS questionActive, q.TypeCodeId AS questiontypecodeid, CAST(q.OriginalRowGuid AS varchar(50)) AS originalquestionrowguid, 
                      CAST(q.RowGuid AS varchar(50)) AS questionRowGuid, qb.CultureId AS bodyculture, qb.Body, CAST(qb.OriginalRowGuid AS varchar(50)) 
                      AS originalquestionbodyrowguid, CAST(qb.RowGuid AS varchar(50)) AS questionBodyRowGuid, qr.ResponseNum, qr.DisplayOrder, 
                      qr.RiskRatingCodeId, qr.BestPractice, qr.Alert, qr.CorrectiveAction, qr.CorrectiveActionFlag, CAST(qr.FollowupRowGuid AS varchar(50)) 
                      AS followuprowguid, qr.ResponseNote, CAST(qr.OriginalRowGuid AS varchar(50)) AS originalquestionresponsedefinitionrowguid, 
                      CAST(qr.RowGuid AS varchar(50)) AS questionResponseRowGuid, qrd.CultureId AS responseculture, qrd.ResponseNum AS detailresponsenum, 
                      qrd.DisplayText, CAST(qrd.OriginalRowGuid AS varchar(50)) AS originalquestionresponsedetailrowguid, CAST(qrd.RowGuid AS varchar(50)) 
                      AS responseDetailRowGuid, qr.NotesMandatory, qr.AttachmentsMandatory, s.deleted, s.rating
FROM         dbo.tQuestionnaireStatus AS s WITH (nolock) INNER JOIN
                      dbo.tAssignment AS a WITH (nolock) ON s.StatusGuid = a.StatusGuid INNER JOIN
                      dbo.tSentQuestion AS q WITH (nolock) ON a.SourceGuid = q.RowGuid INNER JOIN
                      dbo.tSentQuestionBody AS qb WITH (nolock) ON q.QuestionGuid = qb.QuestionGuid INNER JOIN
                      dbo.tSentQuestionResponseDefinition AS qr WITH (nolock) ON q.QuestionGuid = qr.QuestionGuid INNER JOIN
                      dbo.tSentQuestionResponseDetail AS qrd WITH (nolock) ON q.QuestionGuid = qrd.QuestionGuid AND qr.ResponseNum = qrd.ResponseNum
' 
GO
/****** Object:  View [dbo].[vPartners]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vPartners]'))
EXEC dbo.sp_executesql @statement = N'
CREATE view [dbo].[vPartners]
as
SELECT	pr.parentid as Partnerid
		,pr.ChildID
		,pr.ReferenceNumber as PartnerNum
		,p.FactoryNum AS FactoryNum
		,p.Name
		,pr.ReferenceCode AS PartnerStatus
		,P.Shortname AS[Abbreviation]
		,p.Nickname
		,p.Address1
		,p.Address2
		,p.Address3
		,p.City
		,PostalCode
		,Phone
		,Fax
		,SVIUserName
		,SVIPassword
		,SVICompanyName
		,SVINumber
		,PortOfExport
		,MID
		,SendingEmailAddress
		,(
            SELECT decode
            FROM tcodes
            WHERE codeid = statecodeid
            ) AS State
		,(
            SELECT decode
            FROM tcodes
            WHERE codeid = countrycodeid
            ) AS Country
		,(
            SELECT email
            FROM tuser
            WHERE userid = p.primaryuserid
            ) AS ContactEmail
		,(
            SELECT firstname
            FROM tuser
            WHERE userid = p.primaryuserid
            ) AS FirstName
		,(
            SELECT Lastname
            FROM tuser
            WHERE userid = p.primaryuserid
            ) AS LastName
		,isnull(STUFF((
                        SELECT '', '' + p1.ParentName
                        FROM tpartnerrelationshipparent p1 WITH (NOLOCK)
                        WHERE p1.ChildID = pr.ChildID
                              AND p1.importerid = pr.ParentID
                        FOR XML path('''')
                        ), 1, 2, ''''), '''') AS ParentCompany
		,isnull(STUFF((
                        SELECT '', '' + pt.GroupType
                        FROM tpartnerrelationshipgroup pT WITH (NOLOCK)
                        WHERE pT.ChildID = pr.ChildID
                              AND pT.ParentID = pr.ParentID
                        FOR XML path('''')
                        ), 1, 2, ''''), '''') AS PartnerType
FROM	tpartner p WITH (NOLOCK)
JOIN	tpartnerrelationship pr WITH (NOLOCK)
ON		p.partnerid = pr.childid
AND		p.Active = 1
AND		pr.ReferenceCode = ''Active''
' 
GO
/****** Object:  View [dbo].[vPartnerView]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vPartnerView]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vPartnerView]
AS
SELECT     p.partnerid as partnerid
,pp.Name AS partnername, pr.ReferenceNumber AS referenceNumber, pp.Address1 AS address1, pp.Address2 AS address2, pp.City AS city,
                          (SELECT     encode
                            FROM          tcodes
                            WHERE      codeid = pp.statecodeid) AS state,
                          (SELECT     encode
                            FROM          tcodes
                            WHERE      codeid = pp.countrycodeid) AS country, pp.PostalCode AS postalcode,
                          (SELECT     firstname + '' '' + lastname
                            FROM          tuser
                            WHERE      userid = pp.primaryuserid) AS primaryUser, u.Username AS username, u.Email AS email, u.Firstname AS firstname, 
                      u.Lastname AS lastname, u.Phone AS phone,
                          (SELECT     encode
                            FROM          tcodes
                            WHERE      codeid = u.rolecodeid) AS role
FROM         dbo.tPartner p INNER JOIN
                      dbo.tPartnerRelationship pr ON p.PartnerId = pr.ParentId INNER JOIN
                      dbo.tPartner pp ON pr.ChildId = pp.PartnerId INNER JOIN
                      dbo.tUser u ON pp.PartnerId = u.PartnerId
WHERE     (pr.ReferenceCode = ''Active'') AND (pp.Active = 1) AND (u.RoleCodeId =
                          (SELECT     codeid
                            FROM          tcodes
                            WHERE      encode = ''PRIMARY'' AND fieldname = ''USER_ROLE_SUPPLIER''))



' 
GO
/****** Object:  View [dbo].[vQuestionAndQuestionnaireList]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vQuestionAndQuestionnaireList]'))
EXEC dbo.sp_executesql @statement = N'
/* Rename CommodityCodeID to ImportanceCodeID in vQuestionAndQuestionnaireList */
CREATE VIEW [dbo].[vQuestionAndQuestionnaireList]
AS
SELECT ''QSTR'' AS [type] 
, Cast(rowGuid as varchar(50)) AS id 
,partnerId 
, name 
,0 as departmentCodeId 
,0 as categoryCodeId 
,0 as portCodeId 
,0 as industryCodeId 
,0 as regionCodeId 
,0 as importanceCodeId 
,0 as shared 
,(select shortname from tPartner where partnerId = th.partnerid) as owner 
FROM tTemplateHeader th 
where active = 1 
UNION 
SELECT ''QSTN'' AS [type] 
, Cast(rowGuid as varchar(50)) AS id 
,partnerId 
, description AS name 
, departmentCodeId 
, categoryCodeId 
, portCodeId 
, industryCodeId 
, regionCodeId 
, importanceCodeId 
, shared 
,(select shortname from tPartner where partnerId = q.partnerid) as owner 
FROM tQuestion q 
where active = 1 ' 
GO
/****** Object:  View [dbo].[vQuestionnaireStatus]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vQuestionnaireStatus]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vQuestionnaireStatus]
AS
SELECT	 Status.PartnerID AS ID,
CAST(Status.RowGUID AS VARCHAR(36)) AS DetailID,
(SELECT	Name
FROM	TTemplateHeader WITH (NOLOCK)
WHERE	TemplateGUID = Status.TemplateGUID) AS Name,
Status.RecipientPartnerID,
(SELECT	Name
FROM	TPartner WITH (NOLOCK)
WHERE	PartnerID = Status.RecipientPartnerID) AS RecipientName,
(SELECT	ShortName
FROM	TPartner WITH (NOLOCK)
WHERE	PartnerID = Status.RecipientPartnerID) AS RecipientShortName,
Status.DateSent,
Status.LastAccessDate,
(SELECT	UserName
FROM	TUser WITH (NOLOCK)
WHERE	UserID = Status.LastAccessUser) AS LastUser,
Status.LastReminderDate,
CASE
WHEN Status.ReminderScheduled = 0
THEN ''No''
ELSE ''Yes''
END AS Scheduled,
(SELECT	Decode
FROM	TCodes WITH (NOLOCK)
WHERE	CodeID = Status.StatusCodeID) AS StatusCode,
Status.StatusDescription,
Status.DueDate,
CASE
WHEN LEN(Status.Rating) > 0
THEN
(SELECT	Decode
FROM	TCodes WITH (NOLOCK)
WHERE	Encode = Status.Rating
AND	FieldName = ''QUESTIONNAIRE_RATING'')
ELSE ''''
END AS Rating,
Status.Archive,
Status.Deleted,
(SELECT	Decode
FROM	TCodes WITH (NOLOCK)
WHERE	CodeID = Grp.GroupCodeID) AS QstnrGroup,
Status.ShowCorrectiveAction,
Status.ReminderInterval
FROM	 TQuestionnaireStatus Status WITH (NOLOCK)
LEFT JOIN	TSentQuestionnaireGroup Grp WITH (NOLOCK)
ON	 Status.RowGUID = Grp.StatusGUID' 
GO
/****** Object:  View [dbo].[vQuestionRisk]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vQuestionRisk]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vQuestionRisk]
AS

select question.description as qname
	, status.statusguid as statusGuid
	, cast(status.rowguid as varchar(50)) as statusRowGuid
	, cast(status.templateGuid as varchar(50)) as statusTemplateGuid
	, status.name as questionnairename
	, status.recipientPartnerid
	, status.archive
	, status.partnerid
	, cast(ass.assignmentguid as varchar(50)) as assignmentGuid
	, cast(ass.rowguid as varchar(50)) as assignmentRowGuid
	, cast(resp.responseguid as varchar(50)) as responseGuid
	, cast(resp.rowguid as varchar(50)) as responseRowGuid
	, cast(AVG(cast(codes.decode as decimal(5,2))) as decimal (5,2)) as risk
	, cast(weight.decode as decimal(5,2)) as Weight
	, SUM(CASE WHEN Resp.bestpractice = 0 THEN 0 WHEN Resp.bestpractice = 1 THEN 1 END) as bpcount
	, status.StatusCodeId as StatusCodeId
	,ISNULL((
									CASE 
										WHEN resp.correctiveactionflag = 0
											THEN 0
										WHEN resp.correctiveactionflag = 1 AND respDef.CorrectiveActionFlag = 1 AND respDet.Override = 0
											THEN 1
										END
									),0) AS ca
	, ass.Skip as Skip
	from tquestionnairestatus status (nolock)
	join tassignment ass (nolock) on (status.statusguid = ass.statusguid)
	join tresponse resp (nolock) on (ass.assignmentguid = resp.assignmentguid)
	left join tresponsedetail respdet (nolock) on (resp.ResponseGuid = respdet.ResponseGuid)
	LEFT JOIN 	tSentQuestionResponseDefinition respDef(NOLOCK) ON (CAST(respDef.RowGuid AS VARCHAR(50)) = respdet.response)
	join tsentquestion question (nolock) on (resp.questionguid = question.questionguid)
	left join tcodes codes with (nolock) on (status.partnerid = codes.partnerid and codes.encode = cast(respdet.responseratingcodeid as varchar(5))and codes.fieldname = ''QUESTION_CUSTOM_RISK_RATING'')
	left join tcodes weight with (nolock) on (status.partnerid = weight.partnerid and weight.encode = cast(question.weightcodeid as varchar(5))and weight.fieldname = ''QUESTION_CUSTOM_WEIGHT_RATING'')
	where question.description <> ''''
	group by 
	question.description,
	status.statusguid,
	status.rowguid,
	status.templateGuid,
	status.name,
	status.recipientPartnerid,
	status.archive,
	status.partnerid,
	status.StatusCodeId,
	ass.assignmentguid,
	ass.rowguid,
	ass.Skip,
	resp.responseguid,
	resp.rowguid,
	resp.correctiveactionflag,
	respDef.CorrectiveActionFlag,
	respDef.CorrectiveAction,
	respDet.Override,
	weight.decode


' 
GO
/****** Object:  View [dbo].[vQuestionRiskbyProgram]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vQuestionRiskbyProgram]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[vQuestionRiskbyProgram]
AS
select question.description as qname
, status.statusguid as statusGuid
, cast(status.rowguid as varchar(50)) as statusRowGuid
, cast(status.templateGuid as varchar(50)) as statusTemplateGuid
, status.name as questionnairename
, status.recipientPartnerid
, status.archive
, status.partnerid
, cast(ass.assignmentguid as varchar(50)) as assignmentGuid
, cast(ass.rowguid as varchar(50)) as assignmentRowGuid
, cast(resp.responseguid as varchar(50)) as responseGuid
, cast(resp.rowguid as varchar(50)) as responseRowGuid
, cast(AVG(case when respdet.responseratingcodeid = ''486''
	then cast(vul.novulnerability   as decimal(5,2) )
	when respdet.responseratingcodeid = ''487''
	then cast (vul.lowvulnerability   as decimal(5,2) )
	when respdet.responseratingcodeid = ''488''
	then cast (vul.modvulnerability  as decimal(5,2) ) 
	when respdet.responseratingcodeid = ''489''
	then cast (vul.highvulnerability   as decimal(5,2) )
	when respdet.responseratingcodeid = ''490''
	then cast (vul.severevulnerability   as decimal(5,2) )
	end) as decimal (5,2)) as risk
, cast(weight.decode as decimal(5,2)) as Weight
,SUM(CASE WHEN Resp.bestpractice = 0 THEN 0 WHEN Resp.bestpractice = 1 THEN 1 END) as bpcount
from tquestionnairestatus status (nolock)
join tassignment ass (nolock) on (status.statusguid = ass.statusguid)
join tresponse resp (nolock) on (ass.assignmentguid = resp.assignmentguid)
left join tresponsedetail respdet (nolock) on (resp.ResponseGuid = respdet.ResponseGuid)
join tsentquestion question (nolock) on (resp.questionguid = question.questionguid)
join tTemplateHeader template on status.templateguid = template.templateguid
join tViewTabAssociations vtass on template.RowGuid = vtass.tablerowguid
join tViewTab tvt on  vtass.viewtabrowguid = tvt.rowguid
join tProgramVulnerabilityScore vul on tvt.rowguid = vul.viewtabrowguid and status.PartnerId=vul.partnerid
left join tcodes weight (nolock) on (status.partnerid = weight.partnerid and weight.encode = cast(question.weightcodeid as varchar(5))and weight.fieldname = ''QUESTION_CUSTOM_WEIGHT_RATING'')
group by 
question.description,
status.statusguid,
status.rowguid,
status.templateGuid,
status.name,
status.recipientPartnerid,
status.archive,
status.partnerid,
ass.assignmentguid,
ass.rowguid,
resp.responseguid,
resp.rowguid,
weight.decode' 
GO
/****** Object:  View [dbo].[vQuestions]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vQuestions]'))
EXEC dbo.sp_executesql @statement = N'
CREATE view [dbo].[vQuestions]
as
  SELECT DISTINCT
	  q.PartnerId,
	  ''<'' + ''a href="/SCC/Questions/EditQuestion.aspx?selectedId='' + CAST(q.RowGUID AS VARCHAR(36)) + ''">Go To Question'' + ''<'' + ''/a'' + ''>'' AS Question
      ,q.Description
      ,(
            SELECT decode
            FROM tcodes
            WHERE fieldname = ''RESPONSE_TYPE''
                  AND q.ResponseTypeCodeID = codeid
            ) AS AnswerType
      ,cast(Englishbody.body AS NVARCHAR(4000)) AS EnglishQSTNBody
      ,qrdef.ResponseNum
      ,cast(qrd.DisplayText AS VARCHAR(8000)) AS ENGLISHAnswerText
      ,CASE WHEN qrdef.NotesMandatory = 1 THEN ''True'' ElSE ''False'' END AS NotesMandatory
      ,CASE WHEN qrdef.AttachmentsMandatory = 1 THEN ''True'' ElSE ''False'' END AS AttachmentsMandatory
      ,CASE WHEN qrdef.CorrectiveActionFlag = 1 THEN ''True'' ElSE ''False'' END CorrectiveActionFlag 
      ,qrdef.CorrectiveAction
      ,CASE WHEN qrdef.BestPractice = 1 THEN ''True'' ElSE ''False'' END AS BestPractice
      ,CASE WHEN qrdef.Alert = 1 THEN ''True'' ElSE ''False'' END AS Alert
      ,(
            SELECT Decode
            FROM TCodes WITH (NOLOCK)
            WHERE CodeID = qrdef.RiskRatingCodeID
            ) AS Vulnerability
      ,(
            SELECT Decode
            FROM TCodes WITH (NOLOCK)
            WHERE CodeID = q.DepartmentCodeID
            ) AS Department
      ,(
            SELECT Decode
            FROM TCodes WITH (NOLOCK)
            WHERE CodeID = q.CategoryCodeID
            ) AS Category
      ,(
            SELECT Decode
            FROM TCodes WITH (NOLOCK)
            WHERE CodeID = q.ImportanceCodeID
            ) AS Importance
      ,CASE WHEN q.Shared = 1 THEN ''True'' ElSE ''False'' END AS Shared
      ,STUFF((
			  SELECT '', '' + pt.ViewTabName
			  FROM tViewTabAssociations pT WITH (NOLOCK)
			  WHERE pT.TableName = ''tQuestion''
					AND pT.PartnerID = q.PartnerID
					AND pt.TableRowGUID = q.RowGUID
			  FOR XML path('''')
			  ), 1, 2, '''') AS ProgramType
FROM		TQuestion q WITH (NOLOCK)
JOIN		tquestionresponsedefinition qrdef WITH (NOLOCK)
ON			q.questionguid = qrdef.questionguid
JOIN		tquestionresponsedetail qrd WITH (NOLOCK)
ON			qrdef.questionguid = qrd.questionguid
AND			qrdef.responsenum = qrd.responsenum
AND			qrd.cultureid = ''en-US''
LEFT JOIN	tquestionresponsedetail qrdSPANISH WITH (NOLOCK)
ON			qrdef.QuestionGUID = qrdSpanish.QuestionGUID
AND			qrdef.ResponseNum = qrdSpanish.ResponseNum
AND			qrdSpanish.cultureid = ''es-MX''
LEFT JOIN	tquestionresponsedetail qrdFRENCH WITH (NOLOCK)
ON			qrdef.QuestionGUID = qrdFRENCH.QuestionGUID
AND			qrdef.ResponseNum = qrdFRENCH.ResponseNum
AND			qrdFRENCH.cultureid = ''fr-FR''
LEFT JOIN	tquestionresponsedetail qrdChinese WITH (NOLOCK)
ON			qrdef.QuestionGUID = qrdChinese.QuestionGUID
AND			qrdef.ResponseNum = qrdChinese.ResponseNum
AND			qrdChinese.cultureid = ''zh-CN''
LEFT JOIN	tquestionbody Englishbody WITH (NOLOCK)
ON			q.questionguid = Englishbody.questionguid
AND			Englishbody.cultureid = ''en-US''
LEFT JOIN	tquestionbody Spanishbody WITH (NOLOCK)
ON			q.questionguid = Spanishbody.questionguid
AND			Spanishbody.cultureid = ''es-MX''
LEFT JOIN	tquestionbody Chinese WITH (NOLOCK)
ON			q.questionguid = Chinese.questionguid
AND			Chinese.cultureid = ''zh-CN''
LEFT JOIN	tquestionbody French WITH (NOLOCK)
ON			q.questionguid = French.questionguid
AND			French.cultureid = ''fr-FR''
WHERE		q.Active = 1



' 
GO
/****** Object:  View [dbo].[vRiskByQuestionForQuestionnaire]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vRiskByQuestionForQuestionnaire]'))
EXEC dbo.sp_executesql @statement = N'






CREATE        VIEW [dbo].[vRiskByQuestionForQuestionnaire]
AS
select 
s.name as "QSTR Name"
, a.assignmentNum as "Num"
, q.description as Question
, rdd.displayText as Answer
, (select decode from tcodes where codeid = rd.riskRatingcodeid) as "Answer Risk"
, (case when rd.bestpractice = 0 then ''False'' else ''True'' end)  as "Answer BP"
, (select decode from tcodes where codeid = r.responseratingcodeid) as "Question Risk"
, (case when r.bestpractice = 0 then ''False'' else ''True'' end) "Question BP"
, a.lastAccessedDate as "Last Modified"
, cast(s.rowguid as varchar(50)) as srowguid
, s.partnerid as partnerid
, (select name from tpartner where partnerid = s.recipientPartnerId) as recipient
from tquestionnaireStatus s 
, tassignment a
, tsentQuestion q
, tresponse r
, tresponseDetail d
, tsentQuestionResponseDefinition rd
, tsentQuestionResponseDetail rdd
where s.statusguid = a.statusguid
and a.sourceguid = q.rowguid
and q.questionguid = r.questionguid
and r.responseguid = d.responseguid
and cast(rd.rowguid as varchar(50)) = cast(d.response as varchar(50))
and rd.questionguid = rdd.questionguid
and rd.responsenum = rdd.responsenum
and rdd.cultureid = ''en-US''




' 
GO
/****** Object:  View [dbo].[vSentQuestionnaire]    Script Date: 3/6/2020 1:59:32 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vSentQuestionnaire]'))
EXEC dbo.sp_executesql @statement = N'
Create view [dbo].[vSentQuestionnaire]
as
SELECT		''<'' + ''a href="/SCC/Questions/ViewQuestionnaire.aspx?selectedId='' + CAST(status.RowGUID AS VARCHAR(36)) + 
			''">Go To Questionnaire'' + ''<'' + ''/a'' + ''>'' AS Questionnaire,  
			Status.PartnerId
			,RecipientPartnerId
			,DateSent
			,LastAccessDate
			,LastAccessUser
			,LastReminderDate
			,StatusDescription
			,DueDate
			,CASE WHEN Archive = 1 THEN ''True'' ELSE ''False'' END AS Archive
			,ArchiveDate
			,Name
			,Description
			,DisplayDescription
			,approval.decode as Rating
			,ForceAnswerOrder
			,ShowCorrectiveAction
			,ReminderInterval
from		tQuestionnaireStatus status with (nolock)
left join	tCodes approval with (nolock)
on			approval.Fieldname = ''QUESTIONNAIRE_RATING'' and approval.Encode = Status.Rating and approval.PartnerID = 0 
where		status.Deleted = 0

' 
GO
