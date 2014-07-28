USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetReferenceDataForOneProduct]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetReferenceDataForOneProduct]
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
CREATE PROCEDURE [dbo].[GetReferenceDataForOneProduct] 
    -- Add the parameters for the stored procedure here

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT BrandName,BrandID 
    FROM rheemdb..Brand
    ORDER BY BrandName

    SELECT DISTINCT OrganizationID AS DivisionID,OrganizationName AS DivisionName
    FROM rheemusers..Organization where OrganizationType='Division'
    ORDER BY OrganizationName

    SELECT Country,CountryID
    FROM rheemusers..Country  where Disabled = 0
    ORDER BY Country

    SELECT CategoryName,ProductCategoryID
    FROM products..ProductCategory
    ORDER BY CategoryName

    SELECT Title,ProductPageSectionID
    FROM rheemusers..ProductPageSection
    ORDER BY Title

END
GO
