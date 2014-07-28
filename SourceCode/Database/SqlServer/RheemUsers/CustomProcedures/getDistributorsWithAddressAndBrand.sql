USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[getDistributorsWithAddressAndBrand]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[getDistributorsWithAddressAndBrand]
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
CREATE PROCEDURE [dbo].[getDistributorsWithAddressAndBrand] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here    
    SELECT o.OrganizationName, a.AddressLine1, a.AddressLine2, a.City, a.State, a.PostalCode,
      a.Country, 
      isnull(dsm.FirstName + ' ' + dsm.LastName, 'No DSM') as DSM, 
      isnull(dpm.FirstName + ' ' + dpm.LastName, 'No DPM') as DPM,
      isnull(dtr.FirstName + ' ' + dtr.LastName, 'No DTR') as DTR, 
      rheemusers.dbo.GetOrgBrandList(o.OrganizationID) as Brandlist
	FROM rheemusers..organization o 
	   INNER JOIN rheemusers..DistributorOrganization do ON   o.OrganizationID    = do.OrganizationId and  
          do.Corporate    = '1'
       left outer join Address a on o.PrimaryAddressID=a.AddressID
       left outer join Person dsm on do.DSMPersonID=dsm.PersonID
       left outer join Person dpm on do.DPMPersonID=dpm.PersonID
       left outer join Person dtr on do.DTRPersonID=dtr.PersonID
    WHERE 
	      o.OrganizationType  = 'Distributor' and 
		  o.OrganizationName <> '' and o.OrganizationName is not null
    ORDER BY o.OrganizationName

END
GO
