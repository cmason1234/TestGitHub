USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyOrganizationParents]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[MyOrganizationParents]( 
		[OrganizationID] [uniqueidentifier] NOT NULL, 
		[PersonID] [uniqueidentifier] NOT NULL, 
	CONSTRAINT [PK_MyOrganizationParents] PRIMARY KEY CLUSTERED 
	( 
	[OrganizationID] ASC,
	[PersonID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	CREATE UNIQUE INDEX IDX1_MyOrganizationParents ON rheemusers..MyOrganizationParents (PersonID, OrganizationID);

END
GO

