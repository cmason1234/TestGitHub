USE [RheemUsers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBalanceTotals]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBalanceTotals]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetBalanceTotals] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@ProgramValue varchar(50),
    @Year int
AS
BEGIN
  IF @ProgramValue != 'WHCOOP' 
   BEGIN
	
    SELECT o.OrganizationID,  o.OrganizationName, ISNULL(SUM(Credits.TotalClaim), 0) as Credits, 
      Debit.Debits,
      (ISNULL(SUM(Credits.TotalClaim), 0) + Debit.Debits + ISNULL(SUM(Credits.TotalClaim), 0) * fp/100) as Balance, 
      ISNULL(SUM(Credits.TotalClaim), 0) * fp/100 as FixedCost
     FROM rheemusers..MyOrganizations mo
	  INNER JOIN rheemusers..organization o ON mo.OrganizationID = o.OrganizationId AND
                            o.OrganizationType  = 'Distributor' AND
                            o.OrganizationName <> '' AND 
							o.OrganizationName is not null
  	  INNER JOIN rheemdb..EC_Forecast ecf ON o.OrganizationID=ecf.OrganizationID and ecf.GDPYear=@Year
	  INNER JOIN rheemusers..DistributorOrganization do ON o.OrganizationID    = do.OrganizationId AND
                                 do.COOPEligible    = 1
	  LEFT OUTER JOIN rheemdb..EC_Claims Credits ON o.OrganizationID = Credits.OrganizationId AND
   	      Credits.ClaimYear = @Year and Credits.Program = @ProgramValue and Credits.TotalClaim > 0
	  INNER JOIN (
	      select o2.OrganizationID, ISNULL(SUM(db.TotalClaim * db.FundingSplit/100), 0) as Debits 
	         from rheemUsers..Organization o2 
   	         LEFT OUTER JOIN rheemdb..EC_Claims db ON o2.OrganizationID = db.OrganizationId AND
  	          db.ClaimYear = @Year and db.Program = @ProgramValue AND db.TotalClaim < 0 and
	           db.ClaimStatus <> 'Denied' Group by o2.OrganizationID
	      ) Debit  ON Debit.OrganizationID=o.OrganizationID
	   INNER JOIN (
	       Select -SUM(isnull(FixedPercent,0)) fp from RheemDB..EC_ClaimSection 
	         where GDPYear = @Year and
	           (('GDP' = @ProgramValue and GDPSection=1) OR
	            ('TC' = @ProgramValue and TCSection=1) OR
	            ('PROSTOCK' = @ProgramValue and ProStockSection=1) OR
	            ('SPECIAL' = @ProgramValue and SpecialProgramSection=1))
	    ) FixedCost on 1=1
      WHERE mo.personID = @PersonId 
	   GROUP BY o.OrganizationID, o.OrganizationName, Debit.Debits, fp
       ORDER BY o.OrganizationName
   END
  ELSE
   BEGIN
    SELECT  o.OrganizationID, o.OrganizationName, ISNULL(SUM(Credits.TotalClaim), 0) as Credits, 
      Debit.Debits,
      (ISNULL(SUM(Credits.TotalClaim), 0) + Debit.Debits + ISNULL(SUM(Credits.TotalClaim), 0) * fp/100) as Balance, 
      ISNULL(SUM(Credits.TotalClaim), 0) * fp/100 as FixedCost
     FROM rheemusers..MyOrganizations mo
	  INNER JOIN rheemusers..organization o ON mo.OrganizationID = o.OrganizationId AND
                            o.OrganizationType  = 'Distributor' AND
                            o.OrganizationName <> '' AND 
							o.OrganizationName is not null
	  INNER JOIN rheemdb..EC_Claims Credits ON o.OrganizationID = Credits.OrganizationId AND
   	      Credits.ClaimYear = @Year and Credits.Program = @ProgramValue and Credits.TotalClaim > 0
	  INNER JOIN (
	      select o2.OrganizationID, ISNULL(SUM(db.TotalClaim * db.FundingSplit/100), 0) as Debits 
	         from rheemUsers..Organization o2 
   	         LEFT OUTER JOIN rheemdb..EC_Claims db ON o2.OrganizationID = db.OrganizationId AND
  	          db.ClaimYear = @Year and db.Program = @ProgramValue AND db.TotalClaim < 0 and
	           db.ClaimStatus <> 'Denied' Group by o2.OrganizationID
	      ) Debit  ON Debit.OrganizationID=o.OrganizationID
	   INNER JOIN (
	       Select -SUM(isnull(FixedPercent,0)) fp from RheemDB..EC_ClaimSection 
	         where GDPYear = @Year and
	           (('WHCOOP' = @ProgramValue and WHSection=1))
	    ) FixedCost on 1=1
      WHERE mo.personID = @PersonId 
	   GROUP BY o.OrganizationID, o.OrganizationName, Debit.Debits, fp
       ORDER BY o.OrganizationName
   END
END
GO
