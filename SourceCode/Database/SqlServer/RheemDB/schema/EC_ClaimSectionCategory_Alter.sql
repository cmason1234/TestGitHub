Use [RheemDB]
GO

if NOT EXISTS(select * from sys.columns where Name = N'Description'  
            and Object_ID = Object_ID(N'EC_ClaimSectionCategory'))
BEGIN
	ALTER TABLE EC_ClaimSectionCategory ADD Description text;
END

if NOT EXISTS(select * from sys.columns where Name = N'Examples'  
            and Object_ID = Object_ID(N'EC_ClaimSectionCategory'))
BEGIN
	ALTER TABLE EC_ClaimSectionCategory ADD Examples text;
END
GO

