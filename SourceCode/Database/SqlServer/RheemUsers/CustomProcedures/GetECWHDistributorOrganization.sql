USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECWHDistributorOrganization]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECWHDistributorOrganization]
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
CREATE PROCEDURE [dbo].[GetECWHDistributorOrganization] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
    SELECT distinct o.OrganizationID, o.OrganizationName  FROM rheemusers..MyOrganizations mo
 INNER JOIN rheemusers..organization o on mo.OrganizationID   = o.OrganizationId and
             o.OrganizationType  = 'Distributor'  and  
			 o.OrganizationName <> '' and o.OrganizationName is not null  
  INNER JOIN RheemDB..EC_Claims ec on o.OrganizationID =ec.OrganizationID and
            Program='WHCOOP' and TotalClaim > 0
  WHERE			 mo.personID         = @PersonID
	   ORDER BY o.OrganizationName


END
GO
