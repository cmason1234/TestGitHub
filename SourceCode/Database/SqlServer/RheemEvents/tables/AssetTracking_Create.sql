USE [RheemEvents]
GO
/****** Object:  Table [dbo].[AssetTracking]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AssetTracking](
	[AssetTrackingID] [uniqueidentifier] NOT NULL,
	[AssetID] [uniqueidentifier] NOT NULL,
	[TractingAction] [varchar](150) NULL,
	[SendToAddress] [nvarchar](350) NULL,
	[SendToRheemEventID] [uniqueidentifier] NULL,
	[TrackingNumber] [varchar](50) NULL,
	[CreateDate] [smalldatetime] NULL,
	[CreateBy] [uniqueidentifier] NULL,
 CONSTRAINT [PK_AssetTracking] PRIMARY KEY CLUSTERED 
(
	[AssetTrackingID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipped, Receieved, Transferred' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AssetTracking', @level2type=N'COLUMN',@level2name=N'TractingAction'
GO
