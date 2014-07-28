USE [RheemEvents]
GO

/****** Object:  Table [dbo].[AssetCategory]    Script Date: 12/03/2010 08:52:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[AssetCategory](
	[AssetCategoryID] [uniqueidentifier] NOT NULL,
	[AssetCategory] [varchar](150) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_AssetCategory] PRIMARY KEY CLUSTERED
(
	[AssetCategoryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

CREATE UNIQUE INDEX UK1_AssetCategory ON [dbo].[AssetCategory](AssetCategory)
GO


