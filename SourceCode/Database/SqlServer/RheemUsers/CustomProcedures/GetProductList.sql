USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductList]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductList]
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
-- Author:		Craig Mason
-- Create date: 07-Sep-2011
-- Description:	Get information to display on the product find page
-- =============================================
CREATE PROCEDURE [dbo].[GetProductList] 
  @searchParam varchar(3000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	
	DECLARE @strSql varchar(4000)
	
	SET @strSql = 'SELECT p.ProductID 
	    ,b.BrandName
	    ,p.Model
	    ,pm.ImageURL
	    ,s.SeriesName
	    ,c.Country
	    ,p.UL
	    ,ac.DualFuel
	    ,p.EnergyStarNorth
		,p.EnergyStarSouth
		,p.EnergyStar2012Most
	    ,p.Gamma
	    ,p.CSA
	    ,ac.ClearControl
	    ,p.ComfortControl2
	    ,p.ComfortControl
	  FROM products..product p 
	  LEFT OUTER JOIN products..Series s ON  p.SeriesID = s.seriesid 
	  LEFT OUTER JOIN rheemdb..brand b ON    p.brandID = b.brandid 
	  LEFT OUTER JOIN rheemusers..organization o ON  p.divisionId = o.OrganizationID 
	  LEFT OUTER JOIN products..ProductCategory pc ON p.ProductCategoryId = pc.ProductCategoryId 
	  LEFT OUTER JOIN products..ProductMaster pm ON    p.ProductId = pm.ProductId 
	  LEFT OUTER JOIN products..AC ac ON    p.ProductId = ac.ProductId
      LEFT OUTER JOIN rheemusers..Country c on pm.CountryID = c.CountryID 
	  WHERE '
	   +  @searchParam + 
	'ORDER BY o.OrganizationName, pc.CategoryName, p.Model, s.SeriesName'
	
	EXEC(@strSql)
END
GO
