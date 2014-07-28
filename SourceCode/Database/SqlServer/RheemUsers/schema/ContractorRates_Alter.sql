use [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'GERepairMax'  
            and Object_ID = Object_ID(N'ContractorRates'))
ALTER TABLE [dbo].[ContractorRates] ADD [GERepairMax] [float] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'GEReplaceMax'  
            and Object_ID = Object_ID(N'ContractorRates'))
ALTER TABLE [dbo].[ContractorRates] ADD [GEReplaceMax] [float] NULL
GO
