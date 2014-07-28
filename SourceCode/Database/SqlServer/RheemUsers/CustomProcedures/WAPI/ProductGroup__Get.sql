USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WAPI__ProductGroup__Get]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[WAPI__ProductGroup__Get]
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
CREATE PROCEDURE [dbo].[WAPI__ProductGroup__Get] 
    -- Add the parameters for the stored procedure here
	@GroupName varchar(200),
	@BrandName varchar(200),
    @BrandID uniqueidentifier,
    @ProductCategoryID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	if @BrandID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @BrandID = null
	if @ProductCategoryID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) set @ProductCategoryID = null

    SELECT pg.ProductGroupID, pg.GroupName,  pc.CategoryName, b.BrandName, pg.BrandId, 
           cd.DocumentTypeID, dt.TypeName, pg.ProductCategoryID FROM RheemUsers..ProductGroup pg 
       LEFT OUTER JOIN RheemUsers..ProductCategory pc ON pg.ProductCategoryID = pc.ProductCategoryID 
       LEFT OUTER JOIN rheemdb..Brand b ON pg.brandID = b.BrandID 
       LEFT OUTER JOIN RheemUsers..CloudDocument cd ON pg.ProductGroupID=cd.ObjectID and cd.FriendlyName='Master Image'
       LEFT OUTER JOIN RheemUsers..DocumentType dt ON cd.DocumentTypeID=dt.DocumentTypeID
	  WHERE 
	     (@GroupName is null or pg.GroupName like @GroupName) AND
	     (@BrandName is null or b.BrandName like @BrandName) AND
	     (@BrandID IS NULL OR pg.BrandID=@BrandID) AND
         (@ProductCategoryID IS NULL OR pg.ProductCategoryID=@ProductCategoryID)
	  order by pg.GroupName

END
GO
