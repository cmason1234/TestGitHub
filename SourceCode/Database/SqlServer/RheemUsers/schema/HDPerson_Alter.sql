USE [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'SignatureDrawingPoints'  
            and Object_ID = Object_ID(N'HDPerson'))
ALTER TABLE [dbo].[HDPerson] ADD [SignatureDrawingPoints] [text] NULL
GO