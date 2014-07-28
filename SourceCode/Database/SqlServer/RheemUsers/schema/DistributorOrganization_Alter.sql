USE [RheemUsers]
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'COOPEligible'  
            and Object_ID = Object_ID(N'DistributorOrganization'))
    ALTER TABLE rheemusers..DistributorOrganization ADD COOPEligible bit not NULL default 0
GO

IF NOT EXISTS(SELECT * FROM sys.columns where Name = N'CorporateEmail'  
            and Object_ID = Object_ID(N'DistributorOrganization'))
    ALTER TABLE rheemusers..DistributorOrganization ADD CorporateEmail varchar(250) NULL 
GO
