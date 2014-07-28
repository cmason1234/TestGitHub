USE [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'CP107109_01'  
            and Object_ID = Object_ID(N'HDLiteratureOrders'))
ALTER TABLE [dbo].[HDLiteratureOrders] ADD [CP107109_01] [bit] Not NULL default 0

go

if NOT EXISTS(select * from sys.columns where Name = N'CP107109_02'  
            and Object_ID = Object_ID(N'HDLiteratureOrders'))
ALTER TABLE [dbo].[HDLiteratureOrders] ADD [CP107109_02] [bit] Not NULL default 0
