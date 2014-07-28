USE [Warranty]
GO

if NOT EXISTS(select * from sys.columns where Name = N'WarrantyType'  
            and Object_ID = Object_ID(N'Units'))
    alter table Units add WarrantyType varchar(1) NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'PPKSerialNum'  
            and Object_ID = Object_ID(N'Units'))
    alter table Units add PPKSerialNum varchar(50) NULL
GO
if NOT EXISTS(select * from sys.columns where Name = N'InstanceID'  
            and Object_ID = Object_ID(N'Units'))
BEGIN
    alter table Units add InstanceID varchar(50) NULL
END
GO

if NOT exists(SELECT * FROM sys.indexes WHERE name='IX_Units_4' AND object_id = OBJECT_ID('Units'))
BEGIN
	CREATE INDEX IX_Units_4 on Units (UnitSerial)
END
GO
if NOT exists(SELECT * FROM sys.indexes WHERE name='IX_Units_5' AND object_id = OBJECT_ID('Units'))
BEGIN
	CREATE INDEX IX_Units_5 on Units (RegistrationDate)
END
GO
