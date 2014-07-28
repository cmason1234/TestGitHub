USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PushRheemUsersProductGroupToProductsProductGroup]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[PushRheemUsersProductGroupToProductsProductGroup]
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
CREATE PROCEDURE [dbo].[PushRheemUsersProductGroupToProductsProductGroup] 
    -- Add the parameters for the stored procedure here
    @ProductGroupID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @ProductGroupExists int = (SELECT COUNT(ProductGroupID) from Products..ProductGroup WHERE ProductGroupID=@ProductGroupID)
    If @ProductGroupExists > 0 
        BEGIN
            UPDATE a 
            SET a.GroupName = b..GroupName,
			    a.GroupSpecificationHTML = b.GroupSpecificationHTML,
				a.GroupFeaturesHTML = b.GroupFeaturesHTML,
				a.AC = b.AC, a.WH = b.WH,
				a.GroupWarrantyHTML = b.GroupWarrantyHTML,
				a.ProductCategoryID = b.ProductCategoryID,
				a.SequenceNumber = b.SequenceNumber,
				a.CreateDateTime__Gen = b.CreateDateTime__Gen,
				a.UpdateDateTime__Gen = b.UpdateDateTime__Gen,
				a.BrandID = b.BrandID,
				a.UseModelPage = b.UseModelPage
            FROM Products..ProductGroup a 
            INNER JOIN RheemUsers..ProductGroup b ON a.ProductGroupID = b.ProductGroupID
            WHERE a.ProductGroupID=@ProductGroupID
        END
    ELSE
        BEGIN
            INSERT INTO Products..ProductGroup Select * from ProductGroup where ProductGroupID=@ProductGroupID
        END
END
GO







