USE [Products]
GO

/****** Object:  Table [dbo].[ProductLiteratureDescription]    Script Date: 04/12/2011 09:58:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ProductLiteratureDescription](
	[ProductLiteratureDescriptionID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NULL,
	[SeqNumber] [int] NULL,
	[Description] [varchar](1024) NULL,
	[BriefDescription] [bit] NULL,
	[WarrantyDescription] [bit] NULL,
	[FullDescription] [bit] NULL,
 CONSTRAINT [PK_ProductLiteratureDescription] PRIMARY KEY CLUSTERED 
(
	[ProductLiteratureDescriptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

