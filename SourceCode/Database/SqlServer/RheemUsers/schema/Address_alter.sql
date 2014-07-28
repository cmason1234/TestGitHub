USE [RheemUsers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'LocationType'  
            and Object_ID = Object_ID(N'Address'))
    alter table Address add LocationType varchar(50)
GO


alter table Address alter column city varchar(50) null
alter table Address alter column state char(3) null
alter table Address alter column PostalCode varchar(50) null
