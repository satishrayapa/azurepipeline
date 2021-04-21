
declare @qry nvarchar(max);
select @qry = 
(SELECT 'DROP INDEX [' + ix.name + '] ON ' + OBJECT_NAME(ID) + '; '
FROM  sysindexes ix
WHERE   ix.Name IS NOT null and ix.Name like '%IX_txdUSReconUnderlyingEntryDetail%'
for xml path(''));
exec sp_executesql @qry


IF  EXISTS (SELECT TOP 1 1 FROM sys.indexes WHERE object_id = OBJECT_ID('dbo.txdUSReconUnderlyingEntryDetail')) BEGIN
	CREATE CLUSTERED INDEX [CIX_txdUSReconUnderlyingEntryDetail] ON [dbo].[txdUSReconUnderlyingEntryDetail]
	(
		[EffDate] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END
 BEGIN
	CREATE NONCLUSTERED INDEX [IX_txdUSReconUnderlyingEntryDetail_1] ON [dbo].[txdUSReconUnderlyingEntryDetail]
	(
		[PartnerID] ASC,
		[EntryNumber] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

BEGIN
	CREATE NONCLUSTERED INDEX [IX_txdUSReconUnderlyingEntryDetail_2] ON [dbo].[txdUSReconUnderlyingEntryDetail]
	(
		[PartnerID] ASC,
		[ReconciliationIssueCode] ASC,
		[ReleaseDate] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

BEGIN
	CREATE NONCLUSTERED INDEX [IX_txdUSReconUnderlyingEntryDetail_3] ON [dbo].[txdUSReconUnderlyingEntryDetail]
	(
		[PartnerID] ASC,
		[ReconciliationIssueCode] ASC,
		[EntryDate] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
END

