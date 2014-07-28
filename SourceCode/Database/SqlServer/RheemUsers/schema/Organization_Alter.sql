USE [RheemUsers]
if NOT EXISTS(select * from sys.columns where Name = N'TreeUpdated'  
            and Object_ID = Object_ID(N'Organization'))
ALTER TABLE [dbo].[Organization] ADD [TreeUpdated] [datetime] NULL
GO