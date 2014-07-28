Use [RheemDB]
GO

if NOT EXISTS(select * from sys.columns where Name = N'FixedRequirement'  
            and Object_ID = Object_ID(N'EC_ClaimSection'))
BEGIN
	ALTER TABLE EC_ClaimSection ADD FixedRequirement bit default 0;
END

if NOT EXISTS(select * from sys.columns where Name = N'FixedPercent'  
            and Object_ID = Object_ID(N'EC_ClaimSection'))
BEGIN
	ALTER TABLE EC_ClaimSection ADD FixedPercent float;
END

if NOT EXISTS(select * from sys.columns where Name = N'DisplayOrder'  
            and Object_ID = Object_ID(N'EC_ClaimSection'))
BEGIN
	ALTER TABLE EC_ClaimSection ADD DisplayOrder int default 0;	
END


alter table EC_ClaimSectionCategory alter column CategoryName varchar(250) null

GO


