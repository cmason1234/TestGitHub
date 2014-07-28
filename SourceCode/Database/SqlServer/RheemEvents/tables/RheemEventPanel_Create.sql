USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventPanel]    Script Date: 10/03/2011 15:12:19 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RheemEventPanel]') AND type in (N'U'))
DROP TABLE [dbo].[RheemEventPanel]SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventPanel](
	[RheemEventPanelID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[RheemEventAssetID] [uniqueidentifier] NOT NULL,
	[PanelID] [uniqueidentifier] NOT NULL,
	[RequestedBy] [uniqueidentifier] NOT NULL,
	[RequestedDate] [smalldatetime] NULL,
	[RequestedNotes] [nvarchar](500) NULL,
	[IsApproved] [bit] NULL,
	[ApprovedBy] [uniqueidentifier] NULL,
	[ApprovedDate] [smalldatetime] NULL,
 CONSTRAINT [PK_RheemEventPanel] PRIMARY KEY CLUSTERED 
(
	[RheemEventPanelID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[RheemEventPanel]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventPanel_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[RheemEventPanel]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventPanel_Panel] FOREIGN KEY([PanelID])
REFERENCES [dbo].[Panel] ([PanelID])
ON DELETE CASCADE
GO