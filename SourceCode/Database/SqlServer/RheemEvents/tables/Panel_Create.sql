USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Panel]    Script Date: 10/03/2011 15:12:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Panel]') AND type in (N'U'))
DROP TABLE [dbo].[Panel]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Panel](
	[PanelID] [uniqueidentifier] NOT NULL,
	[ParentAssetID] [uniqueidentifier] NOT NULL,
	[PanelType] [varchar](50) NULL,
	[PanelPosition] [int] NULL,
	[PanelName] [varchar](150) NULL,
	[ImageID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Panel] PRIMARY KEY CLUSTERED 
(
	[PanelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
