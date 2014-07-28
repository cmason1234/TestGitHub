USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MenuBrand]') AND type in (N'U'))
BEGIN
/****** Object:  Table [dbo].[MenuBrand]    Script Date: 05/18/2012 09:45:27 ******/

CREATE TABLE [dbo].[MenuBrand](
	[MenuBrandID] [uniqueidentifier] NOT NULL,
	[MenuID] [uniqueidentifier] NULL,
	[BrandID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_MenuBrand] PRIMARY KEY CLUSTERED 
(
	[MenuBrandID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


