USE [RheemUsers]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RestrictedWord]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[RestrictedWord]( 
		[RestrictedWordID] [uniqueidentifier] NOT NULL, 
		[RestrictedWord] [varchar](50) NOT NULL,
		[RestrictedWordCategory] [varchar](50) NOT NULL,
	CONSTRAINT [PK_RestrictedWord] PRIMARY KEY CLUSTERED 
	( 
		[RestrictedWordID] ASC 
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY] 
	) ON [PRIMARY] 

	CREATE UNIQUE INDEX IDX1_RestrictedWord ON rheemusers..RestrictedWord (RestrictedWord);

END
GO

IF NOT EXISTS (SELECT 1 FROM rheemusers..RestrictedWord) 
BEGIN

	INSERT INTO rheemusers..RestrictedWord (RestrictedWordID, RestrictedWord, RestrictedWordCategory) values (NEWID(), 'trane', 'competitors')
	INSERT INTO rheemusers..RestrictedWord (RestrictedWordID, RestrictedWord, RestrictedWordCategory) values (NEWID(), 'carrier', 'competitors')
	INSERT INTO rheemusers..RestrictedWord (RestrictedWordID, RestrictedWord, RestrictedWordCategory) values (NEWID(), 'shit', 'profanity')
	INSERT INTO rheemusers..RestrictedWord (RestrictedWordID, RestrictedWord, RestrictedWordCategory) values (NEWID(), 'fuck', 'profanity')

END
GO

