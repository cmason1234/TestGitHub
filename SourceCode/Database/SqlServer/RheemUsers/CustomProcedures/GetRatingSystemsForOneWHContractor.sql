USE [rheemusers]
GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRatingSystemsForOneWHContractor]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRatingSystemsForOneWHContractor]
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
CREATE PROCEDURE [dbo].[GetRatingSystemsForOneWHContractor] 
    -- Add the parameters for the stored procedure here
    @ContractorWaterHeaterID uniqueidentifier
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT a.RatingParentID,RatingParentName
    FROM rheemusers..RatingContractorWaterHeater a
    INNER JOIN rheemusers..RatingParent c ON c.RatingParentID=a.RatingParentID
    INNER JOIN (SELECT * from rheemusers..ContractorWaterHeater 
    WHERE ContractorWaterHeaterID=@ContractorWaterHeaterID) AS b 
    ON    (b.Installer=1 and a.Installer=1) or
          (b.Retail=1 and a.Retail=1) or
          (b.ServiceContractor=1 and a.ServiceContractor=1) or
          (b.Repair=1 and a.Repair=1) or
          (b.Wholesaler=1 and a.Wholesaler=1) or
          (b.Commercial=1 and a.Commercial=1) or
          (b.Residential=1 and a.Residential=1) or
          (b.ManufacturedHome=1 and a.ManufacturedHome=1) or
          (b.ServiceWhatWeSell=1 and a.ServiceWhatWeSell=1) or
          (b.ServiceCommercialElectric=1 and a.ServiceCommercialElectric=1) or
          (b.ServiceCommercialGas=1 and a.ServiceCommercialGas=1) or
          (b.ServiceResidentialElectric=1 and a.ServiceResidentialElectric=1) or
          (b.ServiceResidentialGas=1 and a.ServiceResidentialGas=1) or
          (b.ServiceMobileHomeElectric=1 and a.ServiceMobileHomeElectric=1) or
          (b.ServiceMobileHomeGas=1 and a.ServiceMobileHomeGas=1) or
          (b.ServiceTanklessElectric=1 and a.ServiceTanklessElectric=1) or
          (b.ServiceTanklessGas=1 and a.ServiceTanklessGas=1) or
          (b.ServiceSolar=1 and a.ServiceSolar=1) or
          (b.LicensedPlumber=1 and a.LicensedPlumber=1) or
          (b.ShowRoom=1 and a.ShowRoom=1) or
          (b.ShowOnLocator=1 and a.ShowOnLocator=1) or
          (b.SellProduct=1 and a.SellProduct=1) or
          (b.NewInstallation=1 and a.NewInstallation=1) or
          (b.ReplacementInstallation=1 and a.ReplacementInstallation=1) or
          (b.ProClubMember=1 and a.ProClubMember=1) or
          (b.PrivateLabel=1 and a.PrivateLabel=1) or
          (b.HomeDepot=1 and a.HomeDepot=1) or
          (b.GE=1 and a.GE=1) or
          (b.NoGE=1 and a.NoGE=1) or
          (b.Vanguard=1 and a.Vanguard=1) or
          (b.RheemTankless=1 and a.RheemTankless=1) or
          (b.RuudTankless=1 and a.RuudTankless=1) or
          (b.RheemTank=1 and a.RheemTank=1) or
          (b.RuudTank=1 and a.RuudTank=1) or
          (b.Richmond=1 and a.Richmond=1) or
          (b.RichmondTankless=1 and a.RichmondTankless=1) or
          (b.PalomaTankless=1 and a.PalomaTankless=1)


END
GO
