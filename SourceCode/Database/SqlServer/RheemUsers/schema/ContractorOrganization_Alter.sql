use [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'TimeZone'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
ALTER TABLE [dbo].[ContractorOrganization] ADD [TimeZone] [varchar](1) NULL

if NOT EXISTS(select * from sys.columns where Name = N'CustomerAccountID'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
ALTER TABLE [dbo].[ContractorOrganization] ADD CustomerAccountID varchar(50) NULL

if NOT EXISTS(select * from sys.columns where Name = N'SiteUseID'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
ALTER TABLE [dbo].[ContractorOrganization] ADD SiteUseID varchar(50) NULL

if NOT EXISTS(select * from sys.columns where Name = N'CorporateEmail2'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
ALTER TABLE [dbo].[ContractorOrganization] ADD CorporateEmail2 varchar(50) NULL

if NOT EXISTS(select * from sys.columns where Name = N'PHCC'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
ALTER TABLE [dbo].[ContractorOrganization] ADD PHCC bit NOT NULL default 0

if NOT EXISTS(select * from sys.columns where Name = N'AboutUs'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
ALTER TABLE [dbo].[ContractorOrganization] ADD AboutUs varchar(512) NULL


GO

