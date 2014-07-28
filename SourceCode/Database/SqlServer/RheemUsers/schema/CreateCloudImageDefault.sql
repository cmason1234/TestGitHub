USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloudImageDefault]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CloudImageDefault]( 
		[CloudImageDefaultID] [uniqueidentifier] NOT NULL, 
		[Height] [int] NULL, 
		[Width] [int] NULL, 
	CONSTRAINT [PK_CloudImageDefault] PRIMARY KEY CLUSTERED 
	( 
		[CloudImageDefaultID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	CREATE UNIQUE INDEX IDX1_CloudImageDefault ON rheemusers..CloudImageDefault (Height, Width);

END


GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloudDocument]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CloudDocument]( 
		[CloudDocumentID] [uniqueidentifier] NOT NULL, 
		[ObjectID] [uniqueidentifier] NOT NULL, 
		[ObjectType] [varchar](50) NOT NULL, 
		[DocumentTitle] [varchar](50) NOT NULL, 
		[DocumentNumber] [int] NOT NULL, 
		[ObjectDocumentNumber] [int] NOT NULL, 
		[FriendlyName] [varchar](50) NOT NULL, 
		[Abstract] [text] NULL, 
		[Disabled] [bit] NOT NULL, 
		[UploadedFileName] [varchar](200) NOT NULL, 
		[CloudFileName] [varchar](200) NOT NULL, 
		[CloudBucket] [varchar](50) NOT NULL, 
		[IsImage] [bit] NOT NULL, 
		[FileExtension] [varchar](5) NOT NULL, 
	CONSTRAINT [PK_CloudDocument] PRIMARY KEY CLUSTERED 
	( 
		[CloudDocumentID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	CREATE UNIQUE INDEX IDX1_CloudDocument ON rheemusers..CloudDocument (CloudBucket, CloudFileName);
END
GO


GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CloudImage]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[CloudImage]( 
		[CloudImageID] [uniqueidentifier] NOT NULL, 
		[CloudDocumentID] [uniqueidentifier] NOT NULL, 
		[Height] [int] NOT NULL, 
		[Width] [int] NOT NULL, 
		[MasterImage] [bit] not NULL, 
		[Generated] [bit] not NULL, 
	CONSTRAINT [PK_CloudImage] PRIMARY KEY CLUSTERED 
	( 
		[CloudImageID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	ALTER TABLE [dbo].[CloudImage] WITH CHECK ADD  CONSTRAINT [FK_CloudImage_CloudDocument] FOREIGN KEY([CloudDocumentID]) REFERENCES [dbo].[CloudDocument] ([CloudDocumentID]) ON DELETE CASCADE
END
GO