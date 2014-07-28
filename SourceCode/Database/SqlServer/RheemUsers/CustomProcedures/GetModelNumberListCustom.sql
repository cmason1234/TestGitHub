USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetModelNumberListCustom]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetModelNumberListCustom]
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
CREATE PROCEDURE [dbo].[GetModelNumberListCustom] 
    -- Add the parameters for the stored procedure here
    @ProductModel varchar(50),
    @MfgModel varchar(50),
    @MktModel varchar(50),
    @RDModel varchar(50),
    @AHRIModel varchar(50)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT a.ProductModelNumberID,a.ManufacturingModelNumber, a.MarketingModelNumber, a.RDModelNumber, a.AHRIModelNumber,
	n.ProductModelNumberProductID,p.ProductID,p.BrandID,c.ProductCategoryID,
	CASE WHEN LEN(p.Model)=0 THEN 'NO__MODEL__NAME' WHEN LEN(p.Model)>0 THEN p.Model END AS Model,
	b.BrandName, c.CategoryName
FROM rheemusers..ProductModelNumber a
	LEFT OUTER JOIN rheemusers..ProductModelNumberProduct n ON a.ProductModelNumberID=n.ProductModelNumberID
    LEFT OUTER JOIN rheemusers..Product p ON n.ProductID=p.ProductID 
    LEFT OUTER JOIN RheemDB..Brand b ON p.BrandID=b.BrandID
    LEFT OUTER JOIN rheemusers..ProductCategory c ON p.ProductCategoryID=c.ProductCategoryID

WHERE a.ProductModelNumberID in (SELECT distinct aa.ProductModelNumberID 
	FROM rheemusers..ProductModelNumber aa
	LEFT OUTER JOIN rheemusers..ProductModelNumberProduct na ON aa.ProductModelNumberID=na.ProductModelNumberID
    LEFT OUTER JOIN rheemusers..Product pa ON na.ProductID=pa.ProductID 
	WHERE (LEN(@ProductModel) = 0 OR pa.Model like '%' + @ProductModel + '%') and
		(LEN(@MfgModel) = 0 OR aa.ManufacturingModelNumber like '%' + @MfgModel + '%') and
		(LEN(@MktModel) = 0 OR aa.MarketingModelNumber like '%' + @MktModel + '%') and
		(LEN(@RDModel) = 0 OR aa.RDModelNumber like '%' + @RDModel + '%') and
		(LEN(@AHRIModel) = 0 OR aa.AHRIModelNumber like '%' + @AHRIModel + '%'))
Order by a.ProductModelNumberID

END
GO
