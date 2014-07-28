USE [Products]
GO

/****** Object:  Table [dbo].[ProductLiterature]    Script Date: 04/07/2011 16:27:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProductLiterature](
	[ProductLiteratureID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NULL,
	[Description] [text] NULL,
	[BriefDescription] [text] NULL,
	[AvailableForLiterature] [bit] NULL,
 CONSTRAINT [PK_ProductLiterature] PRIMARY KEY CLUSTERED 
(
	[ProductLiteratureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

