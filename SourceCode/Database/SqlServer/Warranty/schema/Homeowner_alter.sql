USE [Warranty]
GO

if NOT EXISTS(select * from sys.columns where Name = N'CreateTime'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add CreateTime datetime NULL default GETDATE()
GO
if NOT EXISTS(select * from sys.columns where Name = N'OracleProcessed'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add OracleProcessed bit NOT NULL default 0
GO
if NOT EXISTS(select * from sys.columns where Name = N'OracleSentTime'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add OracleSentTime datetime NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'OracleReceivedTime'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add OracleReceivedTime datetime NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'OracleStatus'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add OracleStatus varchar(50) NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'OracleError'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add OracleError varchar(4000) NULL
GO
if EXISTS(select * from sys.columns where Name = N'Attribute1'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners drop column Attribute1
GO
if NOT EXISTS(select * from sys.columns where Name = N'ContractorOrgName'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add ContractorOrgName varchar(200) NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'ContractorLastName'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add ContractorLastName varchar(200) NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'CanadianRegistration'  
            and Object_ID = Object_ID(N'Homeowners'))
    alter table Homeowners add CanadianRegistration bit NOT NULL DEFAULT 0
GO
