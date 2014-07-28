USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMonthlyPurchasesAllDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMonthlyPurchasesAllDistributors]
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
CREATE PROCEDURE [dbo].[GetMonthlyPurchasesAllDistributors] 
    -- Add the parameters for the stored procedure here
    @GDPYear Integer,
	@GDPMonth varchar(50)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	SELECT OrganizationName, DistributorNumber, OracleAccountNumber, OracleCustomerSiteNumberACD, o.organizationID,
	   ISNULL(countData.countUnits, 0) AS countUnits, 
	   ISNULL(noCount.noCountUnits, 0) AS noCountUnits, 
	   ISNULL(countData.countTotal, 0) + ISNULL(noCount.noCountTotal, 0) AS TotalEarned,
	   ISNULL(ecf.GDPEarningPercentage, 0.65) as GDPEarningPercentage, 
	   ISNULL(ecf.TCEarningPercentage, 0.35) as TCEarningPercentage,
	   countData.RebateName, countData.CreditRebateNamesID,
	   @GDPYear as Year, @GDPMonth as Month, ISNULL(numClaims, 0) as numClaims,
	   IgnoreSalesThresholdForTC
	  FROM rheemusers..Organization o 
	   INNER JOIN rheemusers..DistributorOrganization do ON o.OrganizationID=do.OrganizationID
	   LEFT OUTER JOIN EC_Forecast ecf on o.OrganizationID=ecf.OrganizationID and
	        ecf.GDPYear = @GDPYear
	   LEFT OUTER JOIN (
		SELECT ecum.OrganizationID, crn.RebateName, crn.CreditRebateNamesID,
			SUM(ecum.Units) AS countUnits, SUM(ecum.RebateTotal) AS countTotal
		  FROM EC_CreditUnitsByMonth ecum 
		   INNER JOIN EC_CreditRebateAmounts crm ON ecum.CreditRebateAmountsID=crm.CreditRebateAmountsID
		   INNER JOIN EC_CreditProductDescription cpd ON crm.CreditProductDescriptionID=cpd.CreditProductDescriptionID
		   INNER JOIN EC_CreditMarketingCode cmc ON cpd.CreditMarketingCodeID=cmc.CreditMarketingCodeID
		   INNER JOIN EC_CreditRebateNames crn on crm.CreditRebateNamesID=crn.CreditRebateNamesID
		   WHERE IncludeInTotals = 1 AND
		   ecum.GDPYear=@GDPYear AND
		   GDPMonth=@GDPMonth
		   GROUP BY ecum.OrganizationID, crn.RebateName, crn.CreditRebateNamesID
		) AS countData ON o.organizationid=countData.OrganizationID
	   LEFT OUTER JOIN (
		SELECT ecum.OrganizationID, SUM(ecum.Units) AS noCountUnits, SUM(ecum.RebateTotal) AS noCountTotal
		  FROM EC_CreditUnitsByMonth ecum 
		   INNER JOIN EC_CreditRebateAmounts crm ON ecum.CreditRebateAmountsID=crm.CreditRebateAmountsID
		   INNER JOIN EC_CreditProductDescription cpd ON crm.CreditProductDescriptionID=cpd.CreditProductDescriptionID
		   INNER JOIN EC_CreditMarketingCode cmc ON cpd.CreditMarketingCodeID=cmc.CreditMarketingCodeID
		 WHERE IncludeInTotals = 0 AND
		   GDPYear=@GDPYear AND
		   GDPMonth=@GDPMonth
		 GROUP BY ecum.OrganizationID
	   ) AS noCount ON o.OrganizationID=noCount.OrganizationID
	   LEFT OUTER JOIN (
	    Select a1.OrganizationID, count(a1.ClaimID) as numClaims from RheemDB..AllocatedClaims a1 
			INNER JOIN RheemDB..EC_Claims cl on a1.ClaimID = cl.ClaimID AND
				 cl.Program in ('GDP', 'TC') 
		   WHERE a1.ClaimYear = @GDPYear AND a1.Month = @GDPMonth
		   GROUP BY a1.OrganizationID
	   ) as Credits on o.OrganizationID=Credits.OrganizationID
	   WHERE o.OrganizationType  = 'Distributor' AND
	   o.OrganizationName <> '' AND o.OrganizationName IS NOT NULL  AND
	   do.COOPEligible    = 1 
	   ORDER BY OrganizationName
	   
	SELECT crm.CreditRebateNamesID, crm.RebateName, corm.OrganizationID from EC_CreditRebateNames crm
	   INNER JOIN EC_CreditOrgsWithRebateAmount corm on crm.CreditRebateNamesID=corm.CreditRebateNamesID
	  where
		GDPYear = @GDPYear
	  ORDER BY OrganizationID

END
GO
