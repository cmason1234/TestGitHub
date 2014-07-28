use [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'RDModelNumber'  
            and Object_ID = Object_ID(N'ProductModelNumber'))
ALTER TABLE [dbo].[ProductModelNumber] ADD [RDModelNumber] [varchar](50) NULL

if NOT EXISTS(select * from sys.columns where Name = N'AHRIModelNumber'  
            and Object_ID = Object_ID(N'ProductModelNumber'))
ALTER TABLE [dbo].[ProductModelNumber] ADD [AHRIModelNumber] [varchar](50) NULL
GO