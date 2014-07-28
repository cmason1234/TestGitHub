USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloudDocumentSearchableText]') AND type in (N'U'))
BEGIN
	
CREATE TABLE [dbo].[CloudDocumentSearchableText](
	[CloudDocumentSearchableTextID] [uniqueidentifier] NOT NULL,
	[CloudDocumentID]  [uniqueidentifier] NOT NULL,
	[SearchableText] [text] NOT NULL,
 CONSTRAINT [PK_CloudDocumentSearchableText] PRIMARY KEY CLUSTERED 
(
	[CloudDocumentSearchableTextID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

	ALTER TABLE [dbo].[CloudDocumentSearchableText] WITH CHECK ADD  CONSTRAINT [FK_CloudDocSearchText_CloudDocument] FOREIGN KEY([CloudDocumentID]) REFERENCES [dbo].[CloudDocument] ([CloudDocumentID]) ON DELETE CASCADE

END



IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'PageNumber'  
            and Object_ID = Object_ID(N'CloudDocumentSearchableText'))
    ALTER TABLE CloudDocumentSearchableText ADD PageNumber integer 
GO
