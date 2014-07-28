USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductGroupIDFromRheemURL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductGroupIDFromRheemURL]
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
CREATE PROCEDURE [dbo].[GetProductGroupIDFromRheemURL] 
    -- Add the parameters for the stored procedure here
    @URLQueryString varchar(1024)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT ProductGroup.ProductGroupID 
    from ProductGroup, ProductCategory 
    where productgroup.productcategoryid = productcategory.productcategoryid
    And lower(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(productcategory.categoryname, '/', '-'), 'condensing units', 'Air Conditioners'), ' ', '-')  + '-' +  replace(replace(replace(replace(replace(replace(groupname, '&', '-'), '/', '-'), ':', '-'), '%', '-'), ' ', '-'), '---', '-'), '--', '-'), ',', ''), '.', ''), '™', ''), '®', ''), '(', ''), ')', '')) = @URLQueryString

END
GO
