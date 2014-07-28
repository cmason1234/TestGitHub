USE [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Gender'  
            and Object_ID = Object_ID(N'Person'))
ALTER TABLE [dbo].[Person] ADD [Gender] [varchar](1) NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'LastLogin'  
            and Object_ID = Object_ID(N'Person'))
ALTER TABLE [dbo].[Person] ADD [LastLogin] [DateTime] NULL
GO


if NOT EXISTS(select * from sys.columns where Name = N'PartsDistributionWestCoast'  
            and Object_ID = Object_ID(N'Person'))
ALTER TABLE [dbo].[Person] ADD [PartsDistributionWestCoast] bit not NULL default 0
GO


if NOT EXISTS(select * from sys.columns where Name = N'Signature'  
            and Object_ID = Object_ID(N'Person'))
	ALTER TABLE [dbo].[Person] ADD [Signature] TEXT Null
GO
