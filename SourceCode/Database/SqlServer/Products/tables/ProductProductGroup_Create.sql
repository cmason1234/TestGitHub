USE [Products]
GO

/****** Object:  Table [dbo].[ProductProductGroup]    Script Date: 03/03/2011 12:44:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ProductProductGroup](
	[ProductProductGroupID] [uniqueidentifier] NOT NULL,
	[ProductID] [uniqueidentifier] NULL,
	[ProductGroupID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ProductProductGroup] PRIMARY KEY CLUSTERED 
(
	[ProductProductGroupID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

