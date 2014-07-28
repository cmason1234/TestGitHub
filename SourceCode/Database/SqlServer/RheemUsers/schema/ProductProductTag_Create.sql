USE [RheemUsers]
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductProductTag]') AND type in (N'U'))
BEGIN

	CREATE TABLE [dbo].[ProductProductTag](
		[ProductProductTagID] [uniqueidentifier] NOT NULL,
		[ProductTagID] [uniqueidentifier] NOT NULL,
		[ProductID] [uniqueidentifier] NOT NULL,
		[CreateDateTime__Gen] [datetime] NULL,
		[UpdateDateTime__Gen] [datetime] NULL,
	CONSTRAINT [PK_ProductProductTag] PRIMARY KEY CLUSTERED
	(
		[ProductProductTagID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END
GO