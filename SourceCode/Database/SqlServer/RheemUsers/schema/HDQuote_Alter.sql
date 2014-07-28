USE [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'CoSignSignatureDrawingPoints'  
            and Object_ID = Object_ID(N'HDQuote'))
ALTER TABLE [dbo].[HDQuote] ADD [CoSignSignatureDrawingPoints] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'EmailConsent'  
            and Object_ID = Object_ID(N'HDQuote'))
ALTER TABLE [dbo].[HDQuote] ADD [EmailConsent] [bit] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'InitialsConsent'  
            and Object_ID = Object_ID(N'HDQuote'))
ALTER TABLE [dbo].[HDQuote] ADD [InitialsConsent] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'EmailConfirm'  
            and Object_ID = Object_ID(N'HDQuote'))
ALTER TABLE [dbo].[HDQuote] ADD [EmailConfirm] [bit] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'InitialsCancellation'  
            and Object_ID = Object_ID(N'HDQuote'))
ALTER TABLE [dbo].[HDQuote] ADD [InitialsCancellation] [text] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'InitialsTermination'  
            and Object_ID = Object_ID(N'HDQuote'))
ALTER TABLE [dbo].[HDQuote] ADD [InitialsTermination] [text] NULL
GO