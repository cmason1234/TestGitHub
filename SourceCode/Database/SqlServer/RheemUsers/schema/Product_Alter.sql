USE [rheemusers]
GO

if NOT EXISTS(select * from sys.columns where Name = N'WarrantyRegistrationBit'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD
	WarrantyRegistrationBit bit NOT NULL CONSTRAINT DF_Product_WarrantyRegistrationBit DEFAULT ((0))
GO

if EXISTS(select * from sys.columns where Name = N'WarrantyRegistrationMsg'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product DROP COLUMN WarrantyRegistrationMsg
GO

if NOT EXISTS(select * from sys.columns where Name = N'WarrantyRegistrationInstallationTime'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD
	WarrantyRegistrationInstallationTime int NOT NULL CONSTRAINT DF_Product_WarrantyRegistrationInstallationTime DEFAULT 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'ProClubPoints'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD
	ProClubPoints int NOT NULL CONSTRAINT DF_Product_ProClubPoints DEFAULT 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'SeriesID'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD
	SeriesID uniqueidentifier NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ProductCopy'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD	ProductCopy text NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'WarrantyText'  
            and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD	WarrantyText text NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'ReplacementProductID'  and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD ReplacementProductID uniqueidentifier NULL
GO

if NOT EXISTS(select * from sys.columns where Name = N'Transitional'  and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD Transitional bit NOT NULL  DEFAULT 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'Market'  and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD Market varchar(1) NOT NULL  DEFAULT 'U'
GO

if NOT EXISTS(select * from sys.columns where Name = N'EconetEnabled'  and Object_ID = Object_ID(N'Product'))
	ALTER TABLE dbo.Product ADD EconetEnabled bit NOT NULL  DEFAULT 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'ProductLiteratureDirtyAPI'  and Object_ID = Object_ID(N'Product'))
  ALTER TABLE Product ADD ProductLiteratureDirtyAPI bit Not Null Default 0
GO

if NOT EXISTS(select * from sys.columns where Name = N'PTSURL'  and Object_ID = Object_ID(N'Product'))
  ALTER TABLE Product ADD PTSURL varchar(550) Null
GO



