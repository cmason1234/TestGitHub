Use [RheemDB]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Lat'  
            and Object_ID = Object_ID(N'PostalCode'))
BEGIN
	ALTER TABLE PostalCode ADD Lat float
    exec('Update PostalCode Set Lat = cast(Latitude as float)')
END
GO

if NOT EXISTS(select * from sys.columns where Name = N'Lon'  
            and Object_ID = Object_ID(N'PostalCode'))
BEGIN
	ALTER TABLE PostalCode ADD Lon float
    exec('Update PostalCode Set Lon = cast(Longitude as float)')
END
GO

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name = 'idxPCLatLon' AND object_id = OBJECT_ID('PostalCode'))
BEGIN
   CREATE NONCLUSTERED INDEX idxPCLatLon ON [dbo].[PostalCode] ([Lat],[Lon])
    INCLUDE ([CountryName],[PostalCode],[City],[StateOrProvinceCode])
END
GO

