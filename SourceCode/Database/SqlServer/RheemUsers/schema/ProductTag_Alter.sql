use [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Name'  
            and Object_ID = Object_ID(N'ProductTag'))
ALTER TABLE [dbo].[ProductTag] ADD [Name] [varchar](256) NULL

if NOT EXISTS(select * from sys.columns where Name = N'Description'  
            and Object_ID = Object_ID(N'ProductTag'))
ALTER TABLE [dbo].[ProductTag] ADD [Description] [varchar](512) NULL

if NOT EXISTS(select * from sys.columns where Name = N'LogoUrl'  
            and Object_ID = Object_ID(N'ProductTag'))
ALTER TABLE [dbo].[ProductTag] ADD [LogoUrl] [varchar](550) NULL
GO