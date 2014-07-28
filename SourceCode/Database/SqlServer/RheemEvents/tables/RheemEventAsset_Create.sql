USE [RheemEvents]
GO
/****** Object:  Table [dbo].[RheemEventAsset]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RheemEventAsset](
	[RheemEventAssetID] [uniqueidentifier] NOT NULL,
	[RheemEventID] [uniqueidentifier] NOT NULL,
	[AssetID] [uniqueidentifier] NOT NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[RequestedBy] [uniqueidentifier] NOT NULL,
	[RequestedDate] [smalldatetime] NULL,
	[RequestedNotes] [nvarchar](500) NULL,
	[IsApproved] [varchar](50) NULL,
	[ApprovedBy] [uniqueidentifier] NULL,
	[ApprovedDate] [smalldatetime] NULL,
 CONSTRAINT [PK_RheemEventAsset] PRIMARY KEY CLUSTERED 
(
	[RheemEventAssetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RheemEvent.StartDate - 1 day?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RheemEventAsset', @level2type=N'COLUMN',@level2name=N'StartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'RheemEvent.EndDate + 1 day?' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RheemEventAsset', @level2type=N'COLUMN',@level2name=N'EndDate'
GO
ALTER TABLE [dbo].[RheemEventAsset]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventAsset_Asset] FOREIGN KEY([AssetID])
REFERENCES [dbo].[Asset] ([AssetID])
GO
ALTER TABLE [dbo].[RheemEventAsset] CHECK CONSTRAINT [FK_RheemEventAsset_Asset]
GO
ALTER TABLE [dbo].[RheemEventAsset]  WITH CHECK ADD  CONSTRAINT [FK_RheemEventAsset_RheemEvent] FOREIGN KEY([RheemEventID])
REFERENCES [dbo].[RheemEvent] ([RheemEventID]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RheemEventAsset] CHECK CONSTRAINT [FK_RheemEventAsset_RheemEvent]
GO
ALTER TABLE [dbo].[RheemEventAsset] ADD  CONSTRAINT [DF_RheemEventAsset_RheemEventAsset]  DEFAULT (newid()) FOR [RheemEventAssetID]
GO
