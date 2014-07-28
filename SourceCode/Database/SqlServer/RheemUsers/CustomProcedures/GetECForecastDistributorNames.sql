USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECForecastDistributorNames]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECForecastDistributorNames]
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
CREATE PROCEDURE [dbo].[GetECForecastDistributorNames] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
    @Year int,
	@Month varchar(30),
	@OrgID uniqueidentifier
AS
BEGIN
	SELECT o.OrganizationName, o.OrganizationID, do.DistributorNumber,
		   f.Y1DecAllocated, f.Y2JanAllocated, f.Y2FebAllocated, f.Y2MarAllocated, f.Y2AprAllocated, f.Y2MayAllocated, 
		   f.Y2JunAllocated, f.Y2JulAllocated, f.Y2AugAllocated, f.Y2SepAllocated, f.Y2OctAllocated, f.Y2NovAllocated,
		   f.Y1DecPurchases, f.Y2JanPurchases, f.Y2FebPurchases, f.Y2MarPurchases, f.Y2AprPurchases, f.Y2MayPurchases,
		   f.Y2JunPurchases, f.Y2JulPurchases, f.Y2AugPurchases, f.Y2SepPurchases, f.Y2OctPurchases, f.Y2NovPurchases,
		   f.IgnoreSalesThresholdForTC, f.Y2TotalDollars, f.GDPBudgetStatus, f.TCBudgetStatus,
		   f.PreviousYear1Sales, f.PreviousYear2Sales,
		   f.GDPEarningPercentage, f.TCEarningPercentage, 
		   gdpCredit.ClaimID as GDPClaimID, tcCredit.ClaimID as TCClaimID
	FROM  RheemUsers..Organization o
	  INNER JOIN RheemUsers..MyOrganizations mo on o.OrganizationID=mo.OrganizationID and 
		   mo.PersonID = @PersonID
	  INNER JOIN RheemUsers..DistributorOrganization do ON o.OrganizationID    = do.OrganizationId and  
									 do.COOPEligible        = '1'
	  INNER JOIN RheemDB..EC_Forecast f on o.OrganizationID=f.OrganizationID and f.GDPYear=@Year
	  LEFT OUTER JOIN (
		 Select a1.OrganizationID, a1.ClaimID from RheemDB..AllocatedClaims a1 
			INNER JOIN RheemDB..EC_Claims cl on a1.ClaimID = cl.ClaimID and
				 cl.Program='GDP'
		   where a1.ClaimYear = @Year and a1.Month = @Month AND
		     (@OrgID = '00000000-0000-0000-0000-000000000000' or a1.OrganizationID=@OrgID)
		  ) gdpCredit on o.OrganizationID=gdpCredit.OrganizationID
	  LEFT OUTER JOIN (
		 Select a2.OrganizationID, a2.ClaimID from RheemDB..AllocatedClaims a2 
			INNER JOIN RheemDB..EC_Claims cl on a2.ClaimID = cl.ClaimID and
				 cl.Program='TC'
		   where a2.ClaimYear = @Year and a2.Month = @Month AND
		       (@OrgID = '00000000-0000-0000-0000-000000000000' or a2.OrganizationID=@OrgID)
		  ) tcCredit on o.OrganizationID=tcCredit.OrganizationID
	  WHERE (@OrgID = '00000000-0000-0000-0000-000000000000' or o.OrganizationID=@OrgID)
	  order by o.OrganizationName

END
GO
