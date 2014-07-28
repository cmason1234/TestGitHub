USE [rheemdb]
GO

/****** Object:  Table [dbo].[OracleModule]    Script Date: 08/23/2011 11:59:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OracleModule](
	[OracleModuleID] [uniqueidentifier] NOT NULL,
	[ModuleName] [varchar](50) NULL,
	[ModuleOrder] [int] NULL,
 CONSTRAINT [PK_OracleModule] PRIMARY KEY CLUSTERED 
(
	[OracleModuleID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[OracleLink] ADD  CONSTRAINT [DF_OracleLink_OracleLinkID]  DEFAULT (newid()) FOR [OracleLinkID]
GO

ALTER TABLE [dbo].[OracleLink] ADD  CONSTRAINT [DF_OracleLink_LinkOrder]  DEFAULT ((0)) FOR [LinkOrder]
GO

ALTER TABLE [dbo].[OracleModule] ADD  CONSTRAINT [DF_OracleModule_OracleModuleID]  DEFAULT (newid()) FOR [OracleModuleID]
GO

