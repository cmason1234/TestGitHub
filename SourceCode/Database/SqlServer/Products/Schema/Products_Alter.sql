USE [Products]
GO


IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Product_OutdoorOnlyWarranty]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [DF_Product_OutdoorOnlyWarranty]
END

if exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'Product' and column_name = 'OutdoorOnlyWarranty')
        alter table Product drop column OutdoorOnlyWarranty

--
-- cannot drop this column as Rheem.com and Ruud.com are still dependent upon it. 
-- if exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
--     table_name = 'Product' and column_name = 'EnergyStar') ALTER TABLE Product DROP Column EnergyStar
--

if NOT exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'Product' and column_name = 'EnergyStarNorth')
      Alter Table Product Add EnergyStarNorth bit null
      
if NOT exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'Product' and column_name = 'EnergyStarSouth')
      Alter Table Product Add EnergyStarSouth bit null

if NOT exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'Product' and column_name = 'EnergyStar2012Most')
      Alter Table Product Add EnergyStar2012Most bit null

GO

-- This creates foreign keys for the ProductLog, ProductNotes,
--  and ProductDocument tables to the Product table.
--  If a product goes away, these entries should also.

Use [Products]

--Remove ProductLog entries which are orphans
delete from ProductLog where ProductID not in (select ProductID from Product)
  
IF NOT EXISTS (select CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
                   WHERE TABLE_NAME='ProductLog' AND 
                     CONSTRAINT_NAME='FK_ProductLog_ProductID' AND 
                     CONSTRAINT_TYPE='FOREIGN KEY')
ALTER TABLE ProductLog
ADD CONSTRAINT FK_ProductLog_ProductID FOREIGN KEY 
  (ProductID) REFERENCES Product(ProductID)
  on delete cascade

IF NOT EXISTS (select CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
                   WHERE TABLE_NAME='ProductDocument' AND 
                     CONSTRAINT_NAME='FK_ProductDocument_ProductID' AND 
                     CONSTRAINT_TYPE='FOREIGN KEY')
ALTER TABLE ProductDocument
ADD CONSTRAINT FK_ProductDocument_ProductID FOREIGN KEY 
  (ProductID) REFERENCES Product(ProductID)
  on delete cascade

IF NOT EXISTS (select CONSTRAINT_NAME FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
                   WHERE TABLE_NAME='ProductNotes' AND 
                     CONSTRAINT_NAME='FK_ProductNotes_ProductID' AND 
                     CONSTRAINT_TYPE='FOREIGN KEY')
ALTER TABLE ProductNotes
ADD CONSTRAINT FK_ProductNotes_ProductID FOREIGN KEY
 (ProductID) REFERENCES Product(ProductID)
  on delete cascade

if NOT exists (select COLUMN_NAME from INFORMATION_SCHEMA.columns where 
    table_name = 'ProductGroup' and column_name = 'BrandID') 
	BEGIN
      Alter Table ProductGroup Add BrandID uniqueIdentifier null
      declare @runMe varchar(256)
      set @runMe = 'Update ProductGroup Set BrandID = ''3469E15A-B68D-4D4C-92AB-C372F1A6688B'''
      exec (@runMe)
	END

if NOT EXISTS(select * from sys.columns where Name = N'DistributorCatalogPricingNamesID'  
            and Object_ID = Object_ID(N'MyLiteraturePersonalization'))
    alter table MyLiteraturePersonalization add DistributorCatalogPricingNamesID uniqueidentifier
GO
