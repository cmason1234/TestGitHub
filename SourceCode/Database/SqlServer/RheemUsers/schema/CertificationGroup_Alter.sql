USE [RheemUsers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Description'  
            and Object_ID = Object_ID(N'CertificationGroup'))
    ALTER TABLE CertificationGroup add Description text NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'SortOrder'  
            and Object_ID = Object_ID(N'CertificationGroup'))
    ALTER TABLE CertificationGroup add SortOrder int not NULL default 0
GO
