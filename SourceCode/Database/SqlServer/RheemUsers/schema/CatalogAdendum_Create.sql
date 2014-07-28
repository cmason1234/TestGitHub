USE [RheemUsers]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CatalogAddendum]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CatalogAddendum](
	[CatalogAddendumID] [uniqueidentifier] NOT NULL,
	[BrandID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[FileUrl] [varchar](255) NULL,
	[Disabled] [bit] NOT NULL DEFAULT 0,
	[CreateDateTime__Gen] [datetime] NULL,
	[UpdateDateTime__Gen] [datetime] NULL,
 CONSTRAINT [PK_CatalogAddendum] PRIMARY KEY CLUSTERED 
(
	[CatalogAddendumID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
