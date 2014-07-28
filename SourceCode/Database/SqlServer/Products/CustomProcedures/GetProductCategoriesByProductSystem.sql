
USE [Products]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetProductCategoriesByProductSystem]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].GetProductCategoriesByProductSystem
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
CREATE PROCEDURE [dbo].GetProductCategoriesByProductSystem 
	-- Add the parameters for the stored procedure here
	@BrandID uniqueidentifier,
	@OutdoorUnitOnly bit,
	@IndoorUnitOnly bit,
	@OutdoorUnitWithCoil bit,
	@OutdoorUnitWithGasFurnace bit,
	@OutdoorUnitWithAirHandler bit,
	@PackageUnit bit
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(4000)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT @sql = 'select ProductCategoryID , CategoryName  from products..ProductCategory 
				      where
				   ProductCategoryID in (
					   select distinct ProductCategoryID from products..product 
						  where 
					   BrandId             = @BrandID '
       
        IF @OutdoorUnitOnly = 1
	     BEGIN
            SELECT @sql = @sql + ' and OutdoorUnitOnly     =1  '
	     END 
       
        IF @IndoorUnitOnly = 1
	     BEGIN
            SELECT @sql = @sql + ' and IndoorUnitOnly     =1  '
	     END 

	      IF @OutdoorUnitWithCoil = 1
	     BEGIN
            SELECT @sql = @sql + ' and OutdoorUnitWithCoil     =1  '
	     END 

	      IF @OutdoorUnitWithGasFurnace = 1
	     BEGIN
            SELECT @sql = @sql + ' and OutdoorUnitGas     =1  '
	     END 

	      IF @OutdoorUnitWithAirHandler = 1
	     BEGIN
            SELECT @sql = @sql + ' and OutdoorUnitAir     =1  '
	     END 

	      IF @PackageUnit = 1
	     BEGIN
            SELECT @sql = @sql + ' and PackageUnit     =1  '
	     END 
       	
     SELECT @sql = @sql + ' )  '
       
	 SELECT @paramlist = '@BrandID  uniqueidentifier '      

     EXEC sp_executesql @sql, @paramlist, @BrandID 

END
GO
