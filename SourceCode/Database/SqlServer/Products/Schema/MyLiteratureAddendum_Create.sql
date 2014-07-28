USE [Products]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyLiteratureAddendum]') AND type in (N'U'))
BEGIN

	CREATE TABLE dbo.MyLiteratureAddendum(
		MyLiteratureAddendumID uniqueidentifier NOT NULL,
		LiteratureRequestID uniqueidentifier NOT NULL,
		FileUrl varchar(255) NULL,
		AddendumName varchar(50) NULL,
		CreateDateTime__Gen datetime NULL,
		UpdateDateTime__Gen datetime NULL,
		CONSTRAINT PK_MyLiteratureAddendum PRIMARY KEY CLUSTERED 
	(
		MyLiteratureAddendumID ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
END
GO

