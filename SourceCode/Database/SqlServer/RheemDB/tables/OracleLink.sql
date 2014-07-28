USE [rheemdb]
GO

/****** Object:  Table [dbo].[OracleLink]    Script Date: 08/23/2011 11:59:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[OracleLink](
	[OracleLinkID] [uniqueidentifier] NOT NULL,
	[OracleModuleID] [uniqueidentifier] NOT NULL,
	[URL] [varchar](150) NULL,
	[URLText] [varchar](150) NULL,
	[AltText] [varchar](500) NULL,
	[Active] [bit] NULL,
	[AlertText] [varchar](500) NULL,
	[LinkOrder] [int] NOT NULL,
 CONSTRAINT [PK_OracleLink] PRIMARY KEY CLUSTERED 
(
	[OracleLinkID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO