USE [Cris]
GO

if NOT EXISTS(select * from sys.columns where Name = N'EmailAddress'  
            and Object_ID = Object_ID(N'UserAdmin'))
    alter table UserAdmin add EmailAddress varchar(50)
GO


