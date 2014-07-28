USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetContractorWH]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetContractorWH]
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
CREATE PROCEDURE [dbo].[GetContractorWH] 
    -- Add the parameters for the stored procedure here
@WHNumber varchar(50)		

AS
BEGIN
SELECT o.OrganizationID, o.OrganizationType, o.OrganizationName, o.Phone, o.Phone2, o.Fax, 
       co.ACContractor, co.WaterHeaterContractor, co.GeneratorContractor, co.Installer, co.KwikComfort, 
       co.KwikComfortNumber, co.corporateEmail, co.WebSite, co.PrimaryAddressID, 
       a.AddressLine1, a.AddressLine2, a.city, a.State, a.PostalCode, 
       cwh.WHNumber, cr.*, cwh.VendorNumber
FROM rheemusers..Organization o, rheemusers..ContractorOrganization co, rheemusers..Address a, 
     rheemusers..contractorWaterHeater cwh, rheemusers..ContractorRates cr
WHERE cwh.WHNumber    = @WHNumber and
      o.OrganizationID    = co.OrganizationID and 
      co.PrimaryAddressID = a.AddressID and 
      co.WaterHeaterContractor     = '1' and 
      co.OrganizationID = cwh.OrganizationID and 
      co.OrganizationId = cr.OrganizationID
END
GO
