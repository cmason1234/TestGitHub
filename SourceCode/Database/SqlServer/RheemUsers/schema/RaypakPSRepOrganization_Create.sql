USE [rheemusers]
GO

/****** Object:  Table [dbo].[BuilderProgram]    Script Date: 01/03/2011 09:58:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RaypakPSRepOrganization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RaypakPSRepOrganization](
    [RaypakPSRepOrganizationID] [uniqueidentifier] NOT NULL,
    [OrganizationID] [uniqueidentifier] NOT NULL,
    RepNumber varchar(50) Not NULL,
    Disabled bit default 0 Not NULL,
    CreateDate DateTime Not Null,
    RevisionDate DateTime Not Null,
CONSTRAINT [PK_RaypakPSRepOrganization] PRIMARY KEY CLUSTERED 
(
   [RaypakPSRepOrganizationID] asc
   )WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


END
GO

SET ANSI_PADDING OFF
GO

