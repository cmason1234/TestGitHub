USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WAPI__Product__Get]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WAPI__Product__Get]
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
CREATE PROCEDURE [dbo].[WAPI__Product__Get] 
    -- Add the parameters for the stored procedure here
    @brandName varchar(200),
    @categoryName varchar(200),
    @groupName varchar(200),
    @countryName varchar(200),
    @brandID uniqueidentifier,
    @productCategoryID uniqueidentifier,
    @productGroupID uniqueidentifier,
    @productID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	if @brandID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @brandID = null
	if @ProductCategoryID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @ProductCategoryID = null
	if @productGroupID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @productGroupID = null
	if @productID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @productID = null

	SELECT p.ProductID,p.Model,p.Residential,c.Country,p.HeroTitle,p.HeroSubTitle,p.ProductInformation,p.AvailableForLiterature,p.UseModelPage,p.InternationalBit As IsInternational,b.BrandName,pc.CategoryName,pg.GroupName 
	  from rheemusers..Product p
		INNER JOIN rheemdb..Brand b ON b.BrandID=p.BrandID
		INNER JOIN rheemusers..ProductCategory pc ON pc.ProductCategoryID=p.ProductCategoryID
		INNER JOIN rheemusers..Country c ON c.CountryID=p.CountryID
		LEFT OUTER JOIN rheemusers..ProductProductGroup ppg ON ppg.ProductID=p.ProductID
		LEFT OUTER JOIN rheemusers..ProductGroup pg ON pg.ProductGroupID=ppg.ProductGroupID
	WHERE (LEN(@brandName)=0 OR b.BrandName like @brandName) and
		  (LEN(@categoryName)=0 OR pc.CategoryName like @categoryName) and
		  (LEN(@groupName)=0 OR pg.GroupName like @groupName) and
		  (LEN(@countryName)=0 OR c.Country like @countryName) and
		  (@brandID IS NULL OR b.BrandID=@brandID) and
		  (@productCategoryID IS NULL OR pc.ProductCategoryID=@productCategoryID) and
		  (@productID IS NULL OR p.ProductID=@productID) and
		  (@productGroupID IS NULL OR pg.ProductGroupID=@productGroupID)
	ORDER BY p.Model

END
GO
