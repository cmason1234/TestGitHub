USE [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'CreationDate'  
            and Object_ID = Object_ID(N'HDOption'))
ALTER TABLE [dbo].[HDOption] ADD [CreationDate] [datetime] NULL
