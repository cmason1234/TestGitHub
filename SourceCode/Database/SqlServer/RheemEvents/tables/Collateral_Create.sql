USE [RheemEvents]
GO
/****** Object:  Table [dbo].[Collateral]    Script Date: 11/17/2010 13:46:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Collateral](
	[CollateralID] [uniqueidentifier] NOT NULL,
	[IsActive] [int] NOT NULL,
	[CollateralType] [varchar](50) NULL,
	[Brand] [varchar](50) NULL,
	[Title] [nvarchar](150) NULL,
	[Description] [ntext] NULL,
	[Cost] [money] NULL,
 CONSTRAINT [PK_Collateral] PRIMARY KEY CLUSTERED 
(
	[CollateralID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Literature, Promo Item, Advertising' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Collateral', @level2type=N'COLUMN',@level2name=N'CollateralType'
GO
ALTER TABLE [dbo].[Collateral] ADD  CONSTRAINT [DF_Collateral_CollateralID]  DEFAULT (newid()) FOR [CollateralID]
GO
ALTER TABLE [dbo].[Collateral] ADD  CONSTRAINT [DF_Collateral_IsActive]  DEFAULT ((0)) FOR [IsActive]
GO
