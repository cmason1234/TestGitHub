USE [Products]
GO

/****** Object:  Table [dbo].[MyLiterature]    Script Date: 06/14/2011 18:20:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[MyLiterature](
	[MyLiteratureID] [uniqueidentifier] NOT NULL,
	[LiteratureRequestID] [uniqueidentifier] NULL,
	[PersonID] [uniqueidentifier] NULL,
	[ProductID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_MyLiterature] PRIMARY KEY CLUSTERED 
(
	[MyLiteratureID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

