USE [One800]
GO

if NOT EXISTS(select * from sys.columns where Name = N'EmailAddress'  
            and Object_ID = Object_ID(N'Sys2'))
    ALTER TABLE Sys2 add EmailAddress Varchar(50) NULL
GO
