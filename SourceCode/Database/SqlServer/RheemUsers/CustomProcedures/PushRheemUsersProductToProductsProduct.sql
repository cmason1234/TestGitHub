USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PushRheemUsersProductToProductsProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[PushRheemUsersProductToProductsProduct]
GO

-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PushRheemUsersProductToProductsProduct] 
    -- Add the parameters for the stored procedure here
    @ProductID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @ProductExists int = (SELECT COUNT(ProductID) from Products..Product WHERE ProductID=@ProductID)
    If @ProductExists > 0 
        BEGIN
            UPDATE a 
            SET  a.[Model] = b.[Model],
                 a.[BrandID] = b.[BrandID],
                 a.[ProductCategoryID] = b.[ProductCategoryID],
                 a.[DivisionID] = b.[DivisionID],
                 a.[SeriesID] = b.[SeriesID],
                 a.[MarketCommercial] = b.[Commercial],
                 a.[MarketResidential] = b.[Residential],
                 a.[Historical] = b.[Disabled],
				 a.[UseModelPage] = b.[UseModelPage],
				 a.[Description] = b.[ProductInformation],
				 a.[ProductCopy] = b.[ProductCopy],
				 a.[WarrantyText] = b.[WarrantyText]
            FROM Products..[Product] a 
            INNER JOIN RheemUsers..Product b ON a.ProductID = b.ProductID
            WHERE a.ProductID=@ProductID

            UPDATE a 
            SET  a.[OutdoorUnitOnly] = c.[OutdoorUnitOnly],
				 a.[OutdoorUnitGas] = c.[OutdoorUnitGas],
				 a.[OutdoorUnitAir] = c.[OutdoorUnitAir], 
				 a.[IndoorUnitOnly] = c.[IndoorUnitOnly],
				 a.[PackageUnit] = c.[PackageUnit],
				 a.[OutdoorUnitWithCoil] = c.[OutdoorUnitWithCoil],
 				 a.[GasEfficiency] = c.[GasEfficiency]				 
            FROM Products..[Product] a 
			INNER JOIN RheemUsers..ProductAC c on a.ProductID = c.ProductID
            WHERE a.ProductID=@ProductID
			
            UPDATE a
            SET  a.[CountryID] = b.[CountryID],
			     a.AvailableForLiterature = b.AvailableForLiterature
            FROM Products..ProductMaster a 
            INNER JOIN RheemUsers..Product b ON a.ProductID = b.ProductID
            WHERE a.ProductID=@ProductID
        END
    ELSE
        BEGIN
            INSERT INTO Products..[Product] 
            ([ProductID],[Model],[BrandID],[ProductCategoryID],[DivisionID],[SeriesID],
             [MarketCommercial],[MarketResidential],[Historical],[UseModelPage], [Description], [ProductCopy], [WarrantyText] ) 
             SELECT a.[ProductID], a.[Model],[BrandID],[ProductCategoryID],[DivisionID],a.[SeriesID],
                    a.[Commercial] AS MarketCommercial,a.Residential AS MarketResidential,
                    a.[Disabled] AS Historical,
					a.[UseModelPage], a.[ProductInformation], a.[ProductCopy], a.[WarrantyText]
             FROM RheemUsers..[Product] a
             WHERE a.ProductID=@ProductID

            UPDATE a 
            SET  a.[OutdoorUnitOnly] = c.[OutdoorUnitOnly],
				 a.[OutdoorUnitGas] = c.[OutdoorUnitGas],
				 a.[OutdoorUnitAir] = c.[OutdoorUnitAir], 
				 a.[IndoorUnitOnly] = c.[IndoorUnitOnly],
				 a.[PackageUnit] = c.[PackageUnit],
				 a.[OutdoorUnitWithCoil] = c.[OutdoorUnitWithCoil],
				 a.[GasEfficiency] = c.[GasEfficiency]	 				 
            FROM Products..[Product] a 
			INNER JOIN RheemUsers..ProductAC c on a.ProductID = c.ProductID
            WHERE a.ProductID=@ProductID
					 
             INSERT INTO Products..[ProductMaster]
             (ProductMasterID,CountryID,ProductID,AvailableForLiterature)
             SELECT NEWID() AS ProductMasterID,CountryID,ProductID,AvailableForLiterature from RheemUsers..Product
             WHERE ProductID=@ProductID
        END

    DECLARE @ProductLitExists int = (SELECT COUNT(ProductID) from Products..ProductLiterature WHERE ProductID=@ProductID)
    IF @ProductLitExists > 0 
      BEGIN
			UPDATE a
			 SET a.BriefDescription = b.BriefDescription,
				 a.SeqNumber = b.SeqNumber
			 FROM Products..ProductLiterature a
			  INNER JOIN RheemUsers..ProductLiterature b on a.ProductID = b.ProductID
             WHERE a.ProductID=@ProductID
	  END
    ELSE
      BEGIN
			INSERT INTO Products..[ProductLiterature]
			  (ProductLiteratureID, ProductID, BriefDescription, SeqNumber) 
			    SELECT ProductLiteratureID, ProductID, BriefDescription, SeqNumber FROM
				  RheemUsers..ProductLiterature WHERE ProductID=@ProductID
      END
			
    DECLARE @ProductLitDescExists int = (SELECT COUNT(ProductID) from Products..ProductLiteratureDescription WHERE ProductID=@ProductID)
    IF @ProductLitDescExists > 0 
      BEGIN
			UPDATE a
			  SET a.SeqNumber = b.SeqNumber,
			      a.Description = b.Description,
				  a.BriefDescription = b.BriefDescription,
				  a.WarrantyDescription = b.WarrantyDescription,
				  a.FullDescription = b.FullDescription
			  FROM Products..ProductLiteratureDescription a
			    INNER JOIN RheemUsers..ProductLiteratureDescription b on a.ProductID = b.ProductID
			  WHERE a.ProductID=@ProductID
	  END
    ELSE
      BEGIN			 
			INSERT INTO Products..[ProductLiteratureDescription]
			  (ProductLiteratureDescriptionID, ProductID, SeqNumber, Description,
			   BriefDescription, WarrantyDescription, FullDescription)
			    SELECT ProductLiteratureDescriptionID, ProductID, SeqNumber, Description,
			   BriefDescription, WarrantyDescription, FullDescription FROM
			   RheemUsers..ProductLiteratureDescription WHERE ProductID=@ProductID
      END
 END		
GO
