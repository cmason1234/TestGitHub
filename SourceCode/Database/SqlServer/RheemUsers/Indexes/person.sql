USE [RheemUsers]
GO

IF  EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_Person_LastName' AND object_id = OBJECT_ID ('Person'))
DROP index [IDX_Person_LastName] on person
go

CREATE NONCLUSTERED INDEX [IDX_Person_LastName] ON [dbo].[Person] 
(
	[LastName] ASC,
	[FirstName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


/****** Object:  Index [IDX_Person_EmailAddress]    Script Date: 06/27/2013 13:27:19 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE name='IDX_Person_EmailAddress' AND object_id = OBJECT_ID ('Person'))
DROP index [IDX_Person_EmailAddress] on person
go

CREATE NONCLUSTERED INDEX [IDX_Person_EmailAddress] ON [dbo].[Person] 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

