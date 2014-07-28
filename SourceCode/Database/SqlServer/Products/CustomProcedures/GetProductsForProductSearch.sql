USE [Products]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductsForProductSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductsForProductSearch]


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
CREATE PROCEDURE [dbo].[GetProductsForProductSearch] 
    -- Add the parameters for the stored procedure here
    @searchBy varchar(400),
	@personId uniqueidentifier,
	@bucketName varchar(50)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	SELECT Product.ProductID,
		   Product.Model, 
		   @bucketName As S3BucketName,
		   rheemdb..Brand.BrandID,
		   CategoryName, 
		   Product.Description,
		   CASE ruProd.InternationalBit
				WHEN 1 THEN 'international-icon.png'
				ELSE 'transparent4x4.png'
		   END AS InternationalIcon
	FROM products..Product 
		INNER JOIN products..ProductCategory ON products..Product.ProductCategoryID = products..ProductCategory.ProductCategoryID 
		INNER JOIN rheemdb..Brand ON rheemdb..Brand.BrandID = products..Product.BrandID 
		INNER JOIN products..ProductMaster ON products..Product.ProductID = products..ProductMAster.ProductID 
		INNER JOIN rheemusers..Product ruProd ON ruProd.ProductID=products..Product.ProductID
	WHERE (Product.BrandID IN (SELECT BrandID from rheemusers..PersonBrand where PersonID=@personID))  AND 
		  (Product.Model LIKE '%' + @searchBy + '%' OR 
		   CategoryName LIKE '%' + @searchBy + '%' OR 
		   Product.Description LIKE '%' + @searchBy + '%') AND 
		   ISNULL(Product.Historical, 'False') != 'True'         

END
GO
