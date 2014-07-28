USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MenuOrganizationType]') AND type in (N'U'))
BEGIN
/****** Object:  Table [dbo].[MenuOrganizationType]    Script Date: 05/18/2012 09:45:27 ******/

CREATE TABLE [dbo].[MenuOrganizationType](
	[MenuOrganizationTypeID] [uniqueidentifier] NOT NULL,
	[MenuID] [uniqueidentifier] NULL,
	[OrganizationTypeID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_MenuOrganizationType] PRIMARY KEY CLUSTERED 
(
	[MenuOrganizationTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


