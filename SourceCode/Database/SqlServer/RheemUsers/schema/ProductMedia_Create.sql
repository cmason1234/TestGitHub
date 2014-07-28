USE [RheemUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductMedia]') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[ProductMedia](
		[ProductMediaID] [uniqueidentifier] NOT NULL,
		[ProductID] [uniqueidentifier] NOT NULL,
		[FriendlyName] [varchar](50) NOT NULL,
		[URL] [varchar](255) NOT NULL,
	CONSTRAINT [PK_ProductMedia] PRIMARY KEY CLUSTERED
	(
		[ProductMediaID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE [dbo].[ProductMedia]  WITH CHECK ADD  CONSTRAINT [FK_ProductMedia_Product] FOREIGN KEY([ProductID]) REFERENCES [dbo].[Product] ([ProductID]) ON DELETE CASCADE

END
