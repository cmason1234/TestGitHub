USE [rheemusers]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[APIOrganization]') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[APIOrganization](
	[APIOrganizationID] [uniqueidentifier] NOT NULL,
	[OrganizationID] [uniqueidentifier] NOT NULL,
	[OrgType] [varchar](50) NOT NULL,
	[APINumber] int identity (1,1) NOT NULL  ,
	[Disabled] [bit] NOT NULL,
	[WebSite] varchar(512) NULL,
    [Email] varchar(150) NULL,
	[CreateDateTime__Gen] [datetime] NULL,
	[UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_APIOrganization] PRIMARY KEY CLUSTERED 
(
	[APIOrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO