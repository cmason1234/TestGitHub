USE [RheemNews]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_BlogEntryCategories_BlogEntryID' AND object_id = OBJECT_ID ('BlogEntryCategories'))
DROP index [IDX_BlogEntryCategories_BlogEntryID] on BlogEntryCategories
go

CREATE NONCLUSTERED INDEX [IDX_BlogEntryCategories_BlogEntryID] ON [dbo].[BlogEntryCategories] 
(
	[BlogEntryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

