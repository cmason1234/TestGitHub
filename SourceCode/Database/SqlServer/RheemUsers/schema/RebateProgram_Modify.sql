USE [RheemUsers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Disabled'  
            and Object_ID = Object_ID(N'RebateProgram'))
    alter table RebateProgram ADD Disabled bit NOT NULL default 0
GO


if NOT EXISTS(select * from sys.columns where Name = N'ApplicationRoleID'  
            and Object_ID = Object_ID(N'RebateProgram'))
    alter table RebateProgram ADD ApplicationRoleID uniqueidentifier 
		Foreign Key references ApplicationRole(ApplicationRoleID) on delete cascade
	
GO

