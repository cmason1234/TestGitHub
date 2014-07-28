Use [RheemDB]
GO

IF NOT EXISTS(select * from sys.columns where Name = N'WHSection'  
            and Object_ID = Object_ID(N'EC_ClaimSection'))
BEGIN
	ALTER TABLE EC_ClaimSection ADD WHSection bit NOT NULL DEFAULT 0;
END
GO

IF NOT EXISTS(select * from sys.columns where Name = N'ShortName'  
            and Object_ID = Object_ID(N'EC_ClaimSection'))
BEGIN
	ALTER TABLE EC_ClaimSection ADD ShortName varchar(18) NOT NULL DEFAULT 'NEED SHORT NAME';
END
GO

IF NOT EXISTS(select * from sys.columns where Name = N'Reserved'  
            and Object_ID = Object_ID(N'EC_ClaimSection'))
BEGIN
	ALTER TABLE EC_ClaimSection ADD Reserved bit NOT NULL DEFAULT 0;
END

GO

