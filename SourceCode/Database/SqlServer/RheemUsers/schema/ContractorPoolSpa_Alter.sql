USE [RheemUsers]
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'HeatPumpServiceProvider'  
            and Object_ID = Object_ID(N'ContractorPoolSpa'))
    ALTER TABLE rheemusers..ContractorPoolSpa ADD HeatPumpServiceProvider bit NULL
GO
IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'GasPoolHeaterServiceProvider'  
            and Object_ID = Object_ID(N'ContractorPoolSpa'))
    ALTER TABLE rheemusers..ContractorPoolSpa ADD GasPoolHeaterServiceProvider bit NULL
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'GasWarrantyStation'  
            and Object_ID = Object_ID(N'ContractorPoolSpa'))
    ALTER TABLE rheemusers..ContractorPoolSpa ADD GasWarrantyStation bit NOT NULL default 1
GO
IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'HeatPumpWarrantyStation'  
            and Object_ID = Object_ID(N'ContractorPoolSpa'))
    ALTER TABLE rheemusers..ContractorPoolSpa ADD HeatPumpWarrantyStation bit NOT NULL default 1
GO
