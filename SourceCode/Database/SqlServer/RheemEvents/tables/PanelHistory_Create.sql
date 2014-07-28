USE [RheemEvents]
GO
/****** Object:  Table [dbo].[PanelHistory]    Script Date: 10/03/2011 15:12:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PanelHistory]') AND type in (N'U'))
DROP TABLE [dbo].[PanelHistory]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PanelHistory](
	[PanelHistoryID] [uniqueidentifier] NOT NULL,
	[PanelID] [uniqueidentifier] NOT NULL,
	[ApprovedOrDenied] [varchar](50) NOT NULL,
	[ApprovedOrDeniedDate] [datetime] NOT NULL,
	[ApprovingPersonID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PanelHistory] PRIMARY KEY CLUSTERED 
(
	[PanelHistoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[PanelHistory]  WITH CHECK ADD  CONSTRAINT [FK_PanelHistory_Panel] FOREIGN KEY([PanelID])
REFERENCES [dbo].[Panel] ([PanelID])
ON DELETE CASCADE
GO

