USE [Products]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductListing]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ProductListing]


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
CREATE PROCEDURE [dbo].[ProductListing] 
    -- Add the parameters for the stored procedure here
    @ProductID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

   SELECT TOP 1 ProductCategory.CategoryName, Product.ComfortControl, Product.EnergyStarNorth, Product.EnergyStarSouth, 
            Series.SeriesName, Product.ProductCopy, Product.VirtualTourText, Product.Model, 
			'http://globalimageserver.com/default.aspx?cachei=true&maxw=200&maxh=340&watermarkid=0d697559-3109-4985-87f3-83edaf6fb776&id=' + CAST(ProductDocument.DocumentID AS NVARCHAR(MAX)) AS DocumentIDLink, 
			'http://globalimageserver.com/default.aspx?maxw=500&maxh=600&id=' + CAST(ProductDocument.DocumentID AS NVARCHAR(MAX)) AS DocumentIDLinkFull, 
			CAST(ProductDocument.DocumentID AS NVARCHAR(MAX)) as DocumentID, Product.Description, Product.TankWarranty, Product.PartsWarranty, 
			Product.LaborWarranty, Product.HeatExchangeWarranty, Product.CompressorWarranty, Product.WarrantyText, Seer.Seer, 
			Product.GasEfficiency, Product.HSPF, Product.CabinetSize, Product.TaxCredit, Product.TaxCreditText, Product.EnergyGuide, 
			Product.EnergyMiser, Product.HLW, Product.SCAQMD, Product.Gamma, Product.ARI210240, Product.UL, Product.R410A, 
			Product.CSA, Product.SACC, Product.EIL, Product.NSF
    FROM   Product 
	INNER JOIN ProductCategory ON Product.ProductCategoryID = ProductCategory.ProductCategoryID 
	LEFT OUTER JOIN SEER ON Product.SeerID = SEER.SeerID 
	INNER JOIN Series ON Product.SeriesID = Series.SeriesID 
	LEFT OUTER JOIN ProductDocument on ProductDocument.ProductID = Product.ProductID
    WHERE Product.ProductID = @ProductID AND (ProductDocument.PairingType = 'WebPhoto' or ProductDocument.PairingType = 'Web Product Image')
    Order by ProductDocument.PairingType
    
    
    select * from Products.dbo.ProductDocument 
      where productID = @ProductID and pairingtype not like '%historical%' and PairingType <> 'WebPhoto'
    
END
GO
