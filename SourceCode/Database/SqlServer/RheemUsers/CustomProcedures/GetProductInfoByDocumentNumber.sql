USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductInfoByDocumentNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductInfoByDocumentNumber]
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
CREATE PROCEDURE [dbo].[GetProductInfoByDocumentNumber] 
    -- Add the parameters for the stored procedure here
    @DocumentNumber varchar(50) 

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	--http://www.rheem.com/documents/xr90-xr90-spec-sheet

	create table #TempProdID (
	    ProductID uniqueIdentifier,
		Model Varchar(50),
		ProductCategoryID uniqueIdentifier,
		BrandID uniqueIdentifier, 
		groupname varchar(150)
	)
	
	insert into #TempProdID
	  select  distinct p.ProductID, p.Model, p.ProductCategoryID, p.BrandID, GroupName
	    from rcn..Document d
		  INNER JOIN Products..ProductDocument pd ON d.DocumentID = pd.DocumentID
		  INNER JOIN RheemUsers..Product p ON pd.ProductID = p.ProductID 
		   INNER JOIN ProductProductGroup ON p.ProductID = ProductProductGroup.ProductID 
		   INNER JOIN ProductGroup ON ProductProductGroup.ProductGroupID = ProductGroup.ProductGroupID
        where d.DocumentNumber  = @DocumentNumber 
		--+ '%'
	
	select 
	   CASE When tpd.Brandid = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7' then
	      '-http://globalimageserver.com/fetchDocument.aspx?id=' + cast(d.DocumentID as varchar(75))
	     ELSE
	      '-http://www.rheem.com/documents/' + lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(tpd.model, '&', '-'), ' ', '-'), '®', ''), '™', '-'), '/', '-'), '--', ''), '*', ''), '(', ''), ')', ''), '.', '') + '-' + replace(replace(replace(replace(replace(Replace(replace(d.documentTitle, ' ', '-'), ',', ''), '&', ''), '(', '-'), ')', '-'), '--', '-'), '.', ''))
		 END as SpecSheets, pd.DocumentTitle
	from #TempProdID tpd
	  INNER JOIN products..ProductDocument pd ON pd.productId = tpd.ProductID AND 
						 pd.PairingType like 'Specifi%sheet%'
      INNER JOIN rcn..Document d on d.DocumentID=pd.DocumentID

	select 
		'http://www.globalimageserver.com/getimage.aspx?maxw=500&maxh=600&id=' + cast(pd.DocumentID as varchar(75))
		as ProductImageURL
	 from Products..ProductDocument pd
	   INNER JOIN #TempProdID tpd on pd.ProductID=tpd.ProductID
	 where PairingType = 'Web Product Image'

	--select 
	--'https://s3.amazonaws.com/AWSProd/ProductImages/' + CAST (ProductID as varchar(75)) + '_gen_250_250.png' ProductImageURL
	-- from #TempProdID


	SELECT  
	    CASE When tpd.Brandid = 'B91B7302-2342-4B80-B14A-DD7BC9CAE8E7' then
	        'http://www.ruud.com/product.aspx?id=' + cast(tpd.ProductID as varchar(50) ) 
		ELSE
			'http://www.rheem.com/product/' + 
	          lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(pc.categoryname, 
'/', '-'), 'condensing units', 'Air Conditioners'), ' ', '-')  + '-' +  replace(replace(replace(replace(replace(replace(replace(groupname, '&', '-'), '/', '-'), ':', '-'), '%', '-'), ' ', '-'), '---', '-'), '--', '-'), ',', ''), '.', ''), '™', ''), '®', ''), '(', ''), ')', ''), '"', ''), '--','-'))
		END AS URL
	FROM  #TempProdID tpd 
	  INNER JOIN rheemusers..ProductCategory pc ON tpd.ProductCategoryID = pc.ProductCategoryID

END



--LOWER(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(pc.CategoryName, 
--							 'gas/electric', 'gas-electric'), '/', ''), ' ', '-') + '-' + REPLACE(REPLACE(REPLACE(REPLACE(tpd.Model, '&', '-'), ' ', '-'), '™', ''), '®', '-'), '/', '-'), '--', ''), '*', ''), '(', ''), ')', ''), 
--							 '.', ''))
GO
