USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PushRheemUsersProductCategoryToProductsProductCategory]') AND type in (N'P', N'PC'))
    DROP PROCEDURE [dbo].[PushRheemUsersProductCategoryToProductsProductCategory]
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
CREATE PROCEDURE [dbo].[PushRheemUsersProductCategoryToProductsProductCategory] 
    -- Add the parameters for the stored procedure here
    @ProductCategoryID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @ProductCategoryExists int = (SELECT COUNT(ProductCategoryID) from Products..ProductCategory WHERE ProductCategoryID=@ProductCategoryID)
    If @ProductCategoryExists > 0 
        BEGIN
            UPDATE a 
            SET a.CategoryName = b.CategoryName,
			a.Model = b.Model, a.Market=b.Market, a.Brand=b.Brand,
			a.Series=b.Series, a.Description=b.Description,
			a.GasEfficiency=b.GasEfficiency, a.HSPF=b.HSPF,
			a.ComfortControl=b.ComfortControl,a.ComfortControl2=b..ComfortControl2,
			a.Gamma=b.Gamma, a.SEER=b.SEER, a.Tonnages=b.Tonnages,
			a.CabinetSize=b.CabinetSize, a.ARI210240=b.ARI210240, a.UL=b.UL,
			a.R410A=b.R410A, a.EnergyGuide=b.EnergyGuide, a.EnergyStar=b.EnergyStar,
			a.EnergyMiser=b.EnergyMiser, a.CSA=b.CSA, a.SACC=b.SACC, a.EIL=b.EIL,
			a.NSF=b.NSF, a.HLW=b.HLW, a.SCAQMD=b.SCAQMD, a.ProductCopy=b.ProductCopy,
			a.VirtualTourText=b.VirtualTourText, a.WarrantyText=b.WarrantyText,
			a.TankWarranty=b.TankWarranty, a.PartsWarranty=b.PartsWarranty, 
			a.LaborWarranty=b.LaborWarranty, a.HeatExchangeWarranty=b.HeatExchangeWarranty,
			a.compressorWarranty=b.compressorWarranty, a.ExtendedWarranty=b.ExtendedWarranty,
			a.DisplayOnBHPG=b.DisplayOnBHPG, a.DRHorton=b.DRHorton, a.GallonCapacity=b.GallonCapacity,
			a.TaxCredit=b.TaxCredit, a.TaxCreditText=b.TaxCreditText, a.Gas=b.Gas, a.Electric=b.Electric,
			a.Tankless=b.Tankless, a.Solar=b.Solar, a.SortOrder=b.SortOrder,
			a.PriceRangeDELETE=b.PriceRangeDELETE, a.ShowInRegistrationDELETE=b.ShowInRegistrationDELETE,
			a.ProductSystem=b.ProductSystem, a.Common=b.Common, a.AgencyApprovals=b.AgencyApprovals,
			a.EfficiencyRange=b.EfficiencyRange, a.ContractorFAB=b.ContractorFAB, 
			a.CreateDateTime__Gen=b.CreateDateTime__Gen, a.UpdateDateTime__Gen=b.UpdateDateTime__Gen
            FROM Products..ProductCategory a 
            INNER JOIN RheemUsers..ProductCategory b ON a.ProductCategoryID = b.ProductCategoryID
            WHERE a.ProductCategoryID=@ProductCategoryID
        END
    ELSE
        BEGIN
            INSERT INTO Products..ProductCategory Select * from ProductCategory where ProductCategoryID=@ProductCategoryID
        END
END
GO







