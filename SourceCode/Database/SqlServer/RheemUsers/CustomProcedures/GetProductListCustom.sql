USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductListCustom]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetProductListCustom]
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
CREATE PROCEDURE [dbo].[GetProductListCustom] 
    -- Add the parameters for the stored procedure here
    @Model varchar(50),
    @BrandID uniqueidentifier,
    @ProductCategoryID uniqueidentifier,
    @DivisionID uniqueidentifier,
    @Market varchar(1),
    @Commercial bit,
    @Residential bit,
	@EcoNet bit,
    @Disabled bit

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

SELECT a.ProductID,a.Market,a.BrandID,CASE WHEN LEN(a.Model)=0 THEN 'NO__MODEL__NAME' WHEN LEN(a.Model)>0 THEN a.Model END AS Model,
       b.BrandName,c.CategoryName, ISNULL(dt.TypeName, 'Not In Cloud DataBase') TypeName
FROM rheemusers..Product a
    LEFT OUTER JOIN rheemdb..Brand b ON a.BrandID=b.BrandID
    LEFT OUTER JOIN products..ProductCategory c ON a.ProductCategoryID=c.ProductCategoryID
    LEFT OUTER JOIN RheemUsers..CloudDocument cd ON a.ProductID=cd.ObjectID 
                     AND cd.FriendlyName='Master Image'
    LEFT OUTER JOIN RheemUsers..DocumentType dt ON cd.DocumentTypeID=dt.DocumentTypeID

WHERE (@BrandID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR a.BrandID=@BrandID) and
      (@ProductCategoryID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR a.ProductCategoryID=@ProductCategoryID) and
      (@DivisionID = CAST(CAST(0 as BINARY) as UNIQUEIDENTIFIER) OR a.DivisionID=@DivisionID) and
      (LEN(@Market) = 0 OR a.Market = @Market ) and
      (@Commercial = 0 OR a.Commercial=1) and
      (@Residential = 0 OR a.Residential=1) and
      (@Disabled = 1 OR a.Disabled=0) and
	  (@EcoNet = 0 or a.EcoNetEnabled=1) and
      (LEN(@Model) = 0 OR a.Model like '%' + @Model + '%')
	  Order by Model

END
GO
