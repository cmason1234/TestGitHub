USE [RheemUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductTag]') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[ProductTag](
		[ProductTagID] [uniqueidentifier] NOT NULL,
		[Label] [varchar](250) NULL,
		[TagOrder] [int] NULL,
		[ParentProductTagID] [uniqueidentifier] NULL,
		[CreateDateTime__Gen] [datetime] NULL,
		[UpdateDateTime__Gen] [datetime] NULL,
	CONSTRAINT [PK_ProductTag] PRIMARY KEY CLUSTERED
	(
		[ProductTagID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	ALTER TABLE [dbo].[ProductTag] ADD  CONSTRAINT [DF_ProductTag_MenuID]  DEFAULT (newid()) FOR [ProductTagID]	
	ALTER TABLE [dbo].[ProductTag] ADD  CONSTRAINT [DF_ProductTag_TagOrder]  DEFAULT ((0)) FOR [TagOrder]
END
GO