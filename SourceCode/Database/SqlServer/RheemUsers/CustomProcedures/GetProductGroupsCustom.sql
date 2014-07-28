USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductGroupsCustom]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductGroupsCustom]
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
CREATE PROCEDURE [dbo].[GetProductGroupsCustom] 
    -- Add the parameters for the stored procedure here
	@SearchStr varchar(200),
    @BrandID uniqueidentifier,
    @ProductCategoryID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT pg.ProductGroupID, pg.GroupName,  pc.CategoryName, b.BrandName, pg.BrandId, 
           cd.DocumentTypeID, dt.TypeName FROM RheemUsers..ProductGroup pg 
       LEFT OUTER JOIN RheemUsers..ProductCategory pc ON pg.ProductCategoryID = pc.ProductCategoryID 
       LEFT OUTER JOIN rheemdb..Brand b ON pg.brandID = b.BrandID 
       LEFT OUTER JOIN RheemUsers..CloudDocument cd ON pg.ProductGroupID=cd.ObjectID and cd.FriendlyName='Master Image'
       LEFT OUTER JOIN RheemUsers..DocumentType dt ON cd.DocumentTypeID=dt.DocumentTypeID
	  WHERE 
	     pg.GroupName like @SearchStr AND
	     (@BrandID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR pg.BrandID=@BrandID) AND
         (@ProductCategoryID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR pg.ProductCategoryID=@ProductCategoryID) 
	  order by pg.GroupName

END
GO
