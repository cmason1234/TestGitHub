USE [RheemUsers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Referrer'  
            and Object_ID = Object_ID(N'ExceptionLog'))
    alter table ExceptionLog add Referrer varchar(250)
GO
if NOT EXISTS(select * from sys.columns where Name = N'IP_Addr'  
            and Object_ID = Object_ID(N'ExceptionLog'))
    alter table ExceptionLog add IP_Addr varchar(25)
GO
if NOT EXISTS(select * from sys.columns where Name = N'FatalBit'  
            and Object_ID = Object_ID(N'ExceptionLog'))
    alter table ExceptionLog add FatalBit bit Not Null default 1
GO
