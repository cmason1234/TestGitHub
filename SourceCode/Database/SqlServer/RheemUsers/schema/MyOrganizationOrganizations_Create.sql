USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyOrganizationOrganizations]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[MyOrganizationOrganizations]( 
		[MyOrganizationOrganizationsID] [uniqueidentifier] NOT NULL, 
		[OrganizationIDNode] [uniqueidentifier] NOT NULL, 
		[OrganizationIDChild] [uniqueidentifier] NOT NULL, 
	CONSTRAINT [PK_MyOrganizationOrganizations] PRIMARY KEY CLUSTERED 
	( 
	[MyOrganizationOrganizationsID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	CREATE UNIQUE INDEX IDX1_MyOrganizationOrganizations ON rheemusers..MyOrganizationOrganizations (OrganizationIDNode, OrganizationIDChild);

END
GO

