USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductGroupGrid]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductGroupGrid]
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
CREATE PROCEDURE [dbo].[GetProductGroupGrid] 
	-- Add the parameters for the stored procedure here
	@ProductID UniqueIdentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT GroupName, ProductGroupID, b.BrandName, pc.CategoryName
	 FROM ProductGroup pg
	  INNER JOIN Product p on ProductID = @ProductID
	  INNER JOIN RheemDB..Brand b ON pg.BrandID=b.BrandID and
	     p.BrandID=b.BrandID
	  INNER JOIN ProductCategory pc on pg.ProductCategoryID=pc.ProductCategoryID 
	 ORDER BY GroupName

END
GO
