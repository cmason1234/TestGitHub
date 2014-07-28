USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SyncProductWithProductsDB]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SyncProductWithProductsDB]
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
CREATE PROCEDURE [dbo].[SyncProductWithProductsDB] 
    -- Add the parameters for the stored procedure here
    @ProductID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @ProductExists int = (SELECT COUNT(ProductID) from rheemusers..Product WHERE ProductID=@ProductID)
    If @ProductExists > 0 
        BEGIN
            UPDATE a 
            SET  a.[Model] = b.[Model],
                 a.[BrandID] = b.[BrandID],
                 a.[ProductCategoryID] = b.[ProductCategoryID],
                 a.[DivisionID] = b.[DivisionID],
                 a.[Commercial] = b.[MarketCommercial],
                 a.[Residential] = b.[MarketResidential],
                 a.[Disabled] = b.[Historical],
                 a.[CountryID] = ISNULL(c.[CountryID], '002D9A81-02D6-4165-B896-0BD066934EAB'),
                 a.[AvailableForLiterature] = ISNULL(c.[AvailableForLiterature], 0),
				 a.[UseModelPage] = b.[UseModelPage],
				 a.[ProductInformation] = b.[Description],
				 a.[ProductCopy] = b.[ProductCopy],
				 a.[WarrantyText] = b.[WarrantyText]
            FROM rheemusers..[Product] a 
            INNER JOIN Products..Product b ON a.ProductID = b.ProductID
            LEFT OUTER JOIN Products..ProductMaster c ON a.ProductID=c.ProductID
            WHERE a.ProductID=@ProductID
        END
    ELSE
        BEGIN
            INSERT INTO rheemusers..[Product] 
            ([ProductID],[Model],[BrandID],[ProductCategoryID],[DivisionID],
             [Commercial],[Residential],[Disabled],[CountryID],[UseModelPage], [AvailableForLiterature],[ProductInformation],
			 [ProductCopy],[WarrantyText]) 
             SELECT a.[ProductID],a.[Model],[BrandID],[ProductCategoryID],[DivisionID],
                    a.[MarketCommercial] AS Commercial,a.[MarketResidential] AS Residential,
                    ISNULL(a.[Historical], 0) AS Disabled,ISNULL(b.[CountryID], '002D9A81-02D6-4165-B896-0BD066934EAB'),
					a.[UseModelPage],
					ISNULL(b.[AvailableForLiterature], 0) AS AvailableForLiterature,
					a.[Description], a.[ProductCopy], a.[WarrantyText]
             FROM Products..[Product] a
                  LEFT OUTER JOIN Products..[ProductMaster] b ON a.ProductID=b.ProductID 
             WHERE a.ProductID=@ProductID
        END


	
	-- Verify Rheemusers..ProductAC table 
	DECLARE @ProductACExists int = (SELECT COUNT(ProductID) from rheemusers..ProductAC WHERE ProductID=@ProductID)
	If @ProductACExists > 0 
        BEGIN
		 UPDATE a 
            SET  a.[OutdoorUnitOnly] = ISNULL(b.[OutdoorUnitOnly], 0),
                 a.[OutdoorUnitGas] = ISNULL(b.[OutdoorUnitGas], 0),
                 a.[OutdoorUnitAir] = ISNULL(b.[OutdoorUnitAir], 0),
                 a.[IndoorUnitOnly] = ISNULL(b.[IndoorUnitOnly], 0),
                 a.[PackageUnit] = ISNULL(b.[PackageUnit], 0),
                 a.[OutdoorUnitWithCoil] =ISNULL( b.[OutdoorUnitWithCoil], 0)
            FROM rheemusers..[ProductAC] a 
            INNER JOIN Products..Product b ON a.ProductID = b.ProductID
            WHERE a.ProductID=@ProductID
		END
	ELSE
		BEGIN
		INSERT INTO rheemusers..[ProductAC] 
            ([ProductACID],[ProductID],
			[OutdoorUnitOnly],[OutdoorUnitGas],[OutdoorUnitAir], [IndoorUnitOnly],[PackageUnit],[OutdoorUnitWithCoil]) 
             SELECT b.[ACID], b.[ProductID],
			        ISNULL(a.[OutdoorUnitOnly], 0) AS OutdoorUnitOnly,
					ISNULL(a.[OutdoorUnitGas], 0) AS OutdoorUnitGas,
					ISNULL(a.[OutdoorUnitAir], 0) AS OutdoorUnitAir,
					ISNULL(a.[IndoorUnitOnly], 0) AS IndoorUnitOnly,
					ISNULL(a.[PackageUnit], 0) AS PackageUnit,
					ISNULL(a.[OutdoorUnitWithCoil], 0) AS OutdoorUnitWithCoil   
             FROM Products..[Product] a
                  LEFT OUTER JOIN Products..[AC] b ON a.ProductID=b.ProductID 
             WHERE a.ProductID=@ProductID
		END
	END
	

	
GO







