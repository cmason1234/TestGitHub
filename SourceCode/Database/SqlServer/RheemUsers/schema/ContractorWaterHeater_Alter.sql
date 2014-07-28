use [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'RankingPointsTankless'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [RankingPointsTankless] [int] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'WeightedRankingTankless'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [WeightedRankingTankless] [float] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPDispatchEmail'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPDispatchEmail] [varchar](128) NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPOracleCustomerNumber'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPOracleCustomerNumber] [int] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPHVACLicensed'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPHVACLicensed] [bit] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPDispatchByEmail'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPDispatchByEmail] [bit] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPDispatchByFax'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPDispatchByFax] [bit] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPDispatchByElectronic'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPDispatchByElectronic] [bit] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPContact'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPContact] [varchar](50) NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPSalesman'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPSalesman] [varchar](50) NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPContactDateUpdated'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPContactDateUpdated] [datetime] NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ASPContactCancelDate'  
            and Object_ID = Object_ID(N'ContractorWaterHeater'))
ALTER TABLE [dbo].[ContractorWaterHeater] ADD [ASPContactCancelDate] [datetime] NULL
GO