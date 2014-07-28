use [rheemusers]
GO

if  EXISTS(select * from sys.columns where Name = N'SSN'  
            and Object_ID = Object_ID(N'ContractorOrganization'))
  ALTER TABLE [dbo].[ContractorOrganization] DROP Column [SSN]
GO
