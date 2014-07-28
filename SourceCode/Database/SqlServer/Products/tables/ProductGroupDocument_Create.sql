USE [Products]
GO

/****** Object:  Table [dbo].[ProductGroupDocument]    Script Date: 03/09/2011 16:08:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ProductGroupDocument](
	[ProductGroupDocumentID] [uniqueidentifier] NOT NULL,
	[ProductGroupID] [uniqueidentifier] NULL,
	[DocumentID] [uniqueidentifier] NULL,
	[PairingType] [varchar](50) NULL,
 CONSTRAINT [PK_ProductGroupDocument] PRIMARY KEY CLUSTERED 
(
	[ProductGroupDocumentID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

