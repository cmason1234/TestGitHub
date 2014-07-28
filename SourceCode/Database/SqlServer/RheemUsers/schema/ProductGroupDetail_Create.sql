USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductGroupDetail]') AND type in (N'U'))
BEGIN

CREATE TABLE [dbo].[ProductGroupDetail](
   [ProductGroupDetailID] [uniqueidentifier] NOT NULL,
   [ProductGroupID] [uniqueidentifier] NOT NULL REFERENCES ProductGroup(ProductGroupID) ON DELETE CASCADE,
   [ProductPageSectionID] [uniqueidentifier] NOT NULL,
   [SortOrder] [int] NOT NULL,
   [BodyContent] [text] NULL,
   [ExternalURL] [varchar](256) NULL,
   [OnClick] [varchar](512) NULL,
   [Disabled] [bit] NOT NULL,
   [CreateDateTime__Gen] [datetime] NULL,
   [UpdateDateTime__Gen] [datetime] NULL,
   CONSTRAINT [PK_ProductGroupDetail] PRIMARY KEY CLUSTERED 
(
	[ProductGroupDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

END
GO


