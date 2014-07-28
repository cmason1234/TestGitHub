USE [RheemUsers]
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'TopOne'  
            and Object_ID = Object_ID(N'ContractorAC'))
    ALTER TABLE rheemusers..ContractorAC ADD TopOne bit not NULL default 0
GO

