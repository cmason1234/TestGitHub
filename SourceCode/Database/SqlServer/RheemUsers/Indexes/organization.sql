USE [RheemUsers]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_Organization_OrganizationName' AND object_id = OBJECT_ID ('Organization'))
DROP index [IDX_Organization_OrganizationName] on Organization
go

CREATE NONCLUSTERED INDEX [IDX_Organization_OrganizationName] ON [dbo].[Organization] 
(
	[OrganizationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

