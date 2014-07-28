USE [RheemUsers]
GO

if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'ProductGroup' and column_name = 'UseModelPage')
    ALTER TABLE dbo.ProductGroup ADD
	UseModelPage bit NOT NULL CONSTRAINT DF_ProductGroup_UseModelPage DEFAULT 0
Go

if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'ProductGroup' and column_name = 'MetaTitle')
	ALTER TABLE dbo.ProductGroup ADD MetaTitle varchar(150) NULL
Go
if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'ProductGroup' and column_name = 'MetaDescription')
	ALTER TABLE dbo.ProductGroup ADD MetaDescription varchar(512) NULL
Go
if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
	table_name = 'ProductGroup' and column_name = 'DivisionID')
	ALTER TABLE dbo.ProductGroup ADD DivisionID uniqueidentifier NULL
Go
if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
	table_name = 'ProductGroup' and column_name = 'HeroTitle')
	ALTER TABLE dbo.ProductGroup ADD HeroTitle varchar(150) NULL
Go
if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
	table_name = 'ProductGroup' and column_name = 'HeroSubTitle')
	ALTER TABLE dbo.ProductGroup ADD HeroSubTitle varchar(150) NULL
Go
if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
	table_name = 'ProductGroup' and column_name = 'ProductGroupInformation')
	ALTER TABLE dbo.ProductGroup ADD ProductGroupInformation text NULL
GO