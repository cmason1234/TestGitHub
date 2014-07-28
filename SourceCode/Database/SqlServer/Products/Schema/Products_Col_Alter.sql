USE [Products]
GO

if NOT EXISTS (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'Product' and column_name = 'UseModelPage')
    ALTER TABLE dbo.Product ADD
	UseModelPage bit NOT NULL CONSTRAINT DF_Product_UseModelPage DEFAULT 0
GO

