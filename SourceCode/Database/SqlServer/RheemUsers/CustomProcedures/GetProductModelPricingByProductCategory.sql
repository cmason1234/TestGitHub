USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductModelPricingByProductCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductModelPricingByProductCategory]
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
CREATE PROCEDURE [dbo].[GetProductModelPricingByProductCategory] 
	-- Add the parameters for the stored procedure here
	@CategoryName Varchar(200),
	@PricingNamesID uniqueIdentifier,
	@BrandID uniqueIdentifier,
	@Residential bit,
	@Commercial bit
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	
	
	SELECT pc.CategoryName, pc.ProductCategoryID, p.ProductID, p.Residential, p.Commercial,
			pm.RPS_Model, pm.ProductModelID, dcp.ModelCost, 
			dcp.IsActive, dcp.UseRemark, dcp.Remark, p.BrandID, 
			@PricingNamesID as PricingNamesID,
			DistributorCatalogPricingID, pl.SeqNumber
	  FROM ProductCategory pc
	    INNER JOIN Product p on p.ProductCategoryID=pc.ProductCategoryID AND
				  p.BrandID=@BrandID AND
				  p.disabled = '0' AND 
				  (@Residential = 0 OR p.Residential = '1') AND
				  (@Commercial = 0 OR p.Commercial = '1') AND
				  p.AvailableForLiterature = '1'
		INNER JOIN ProductModel pm on p.ProductID=pm.ProductID
		INNER JOIN ProductLiterature pl on p.ProductID=pl.ProductID
		LEFT OUTER JOIN DistributorCatalogPricing dcp on pm.ProductModelID=dcp.ProductModelID
				AND dcp.DistributorCatalogPricingNamesID = @PricingNamesID
	  WHERE (LEN(@CategoryName)=0 or  pc.CategoryName = @CategoryName)
	  ORDER BY pc.CategoryName, p.Residential, p.Commercial, pl.SeqNumber, RPS_Model

END
GO

 