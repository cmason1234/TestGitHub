USE [RheemNews]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_BlogEntry_EntryType' AND object_id = OBJECT_ID ('blogEntry'))
DROP index [IDX_BlogEntry_EntryType] on blogEntry
go

CREATE NONCLUSTERED INDEX [IDX_BlogEntry_EntryType] ON [dbo].[blogEntry] 
(
	[EntryType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

