USE [RheemUsers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Description'  
            and Object_ID = Object_ID(N'Certification'))
    ALTER TABLE Certification add Description text NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'SortOrder'  
            and Object_ID = Object_ID(N'Certification'))
    ALTER TABLE Certification add SortOrder int not NULL default 0
GO
