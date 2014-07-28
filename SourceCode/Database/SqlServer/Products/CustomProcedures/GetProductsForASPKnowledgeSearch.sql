USE [Products]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ASPGetProductsForKnowledgeSearch]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[ASPGetProductsForKnowledgeSearch]


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
CREATE PROCEDURE [dbo].[ASPGetProductsForKnowledgeSearch] 
    -- Add the parameters for the stored procedure here
      @ModelString varchar(4000),
	  @CatString varchar(4000),
	  @ProdCopyString varchar(4000),
	  @DescString varchar(4000)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @Err Int
    DECLARE @strSql1 varchar(4000)
	DECLARE @strSql2 varchar(4000)

    SET @strSql1 = 'SELECT p.productID,  p.Model, b.BrandName, CategoryName, p.Description 
       FROM products..Product p 
         JOIN products..ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID 
       JOIN rheemdb..Brand b ON b.BrandID = p.BrandID and
          b.brandName in (''Rheem/Ruud Commercial'', ''Rheem'', ''Ruud'', ''Richmond'')
       JOIN products..ProductMaster pm ON p.ProductID = pm.ProductID 
        INNER JOIN RheemUsers..Country c on pm.CountryID=c.CountryID and
        c.Country=''USA''
      WHERE  ISNULL(p.Historical, ''False'') != ''True'' AND 
     ((' + @ModelString + ') OR (' + @CatString + ') OR  (' + @ProdCopyString + ') OR (' + @DescString + '))'
	
	EXEC(@strSql1)

  SET @strSql2 = 'select pd.ProductID, pd.DocumentID, pd.PairingType,pd.DocumentTitle 
    from products..ProductDocument pd 
    INNER JOIN Products..Product p on pd.ProductID=p.ProductID
    JOIN products..ProductCategory pc ON p.ProductCategoryID = pc.ProductCategoryID 
    JOIN rheemdb..Brand b ON b.BrandID = p.BrandID and
       b.brandName in (''Rheem/Ruud Commercial'', ''Rheem'', ''Ruud'', ''Richmond'')
   JOIN products..ProductMaster pm ON p.ProductID = pm.ProductID 
   INNER JOIN RheemUsers..Country c on pm.CountryID=c.CountryID and
     c.Country=''USA''
   where pd.pairingtype not like ''%historical%'' and ISNULL(p.Historical, ''False'') != ''True'' AND pd.PairingType <> ''WebPhoto'' and 
    ((' + @ModelString + ') OR (' + @CatString + ') OR  (' + @ProdCopyString + ') OR (' + @DescString + '))'
      
    EXEC(@strSql2)
  
END
GO
