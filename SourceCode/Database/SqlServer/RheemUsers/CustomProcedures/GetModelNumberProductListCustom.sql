USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetModelNumberProductListCustom]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetModelNumberProductListCustom]
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
CREATE PROCEDURE [dbo].[GetModelNumberProductListCustom] 
    -- Add the parameters for the stored procedure here
    @ProductModelNumberID varchar(50)

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT distinct a.ProductModelNumberProductID,a.ProductModelNumberID,a.ProductID,p.BrandID,c.ProductCategoryID,
	CASE WHEN LEN(p.Model)=0 THEN 'NO__MODEL__NAME' WHEN LEN(p.Model)>0 THEN p.Model END AS Model,
	b.BrandName, c.CategoryName
FROM rheemusers..ProductModelNumberProduct a
    LEFT OUTER JOIN rheemusers..Product p ON a.ProductID=p.ProductID 
    LEFT OUTER JOIN RheemDB..Brand b ON p.BrandID=b.BrandID
    LEFT OUTER JOIN rheemusers..ProductCategory c ON p.ProductCategoryID=c.ProductCategoryID

WHERE (LEN(@ProductModelNumberID) = 0 OR a.ProductModelNumberID = @ProductModelNumberID)
	  Order by Model

END
GO
