USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Asset]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Asset](
	[AssetID] [uniqueidentifier] NOT NULL,
	[AssetTag] [varchar](50) NULL,
	[IsActive] [bit] NOT NULL,
	[IsAvailable] [int] NOT NULL,
	[Brand] [varchar](50) NULL,
	[Title] [nvarchar](150) NOT NULL,
	[AssetCategory] [varchar](150) NOT NULL,
	[Description] [ntext] NULL,
	[ShipWeightLbs] [int] NOT NULL,
	[ShipLengthInches] [int] NULL,
	[ShipWidthInches] [int] NULL,
	[ShipHeightInches] [int] NULL,
	[ShipLeadDays] [int] NOT NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[AssetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = no, 1 = yes' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Asset', @level2type=N'COLUMN',@level2name=N'IsActive'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Weight in Pounds' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Asset', @level2type=N'COLUMN',@level2name=N'ShipWeightLbs'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of Days needed to ship item (lead time)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Asset', @level2type=N'COLUMN',@level2name=N'ShipLeadDays'
GO
ALTER TABLE [dbo].[Asset] ADD  CONSTRAINT [DF_Asset_AssetID]  DEFAULT (newid()) FOR [AssetID]
GO
ALTER TABLE [dbo].[Asset] ADD  CONSTRAINT [DF_Table_1_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Asset] ADD  CONSTRAINT [DF_Asset_IsAvailable]  DEFAULT ((0)) FOR [IsAvailable]
GO
ALTER TABLE [dbo].[Asset] ADD  CONSTRAINT [DF_Table_1_Weight]  DEFAULT ((0)) FOR [ShipWeightLbs]
GO
ALTER TABLE [dbo].[Asset] ADD  CONSTRAINT [DF_Asset_ShipLeadDays]  DEFAULT ((1)) FOR [ShipLeadDays]
GO
