USE [RheemUsers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECReportSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECReportSummary]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsMgmtSummary]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimsMgmtSummary]
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
CREATE PROCEDURE [dbo].[GetECReportSummary] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
	
	
    SELECT Credits.ClaimYear, Credits.Program, ISNULL(SUM(Credits.TotalClaim), 0) as Credit,
         isnull(Debits.Debit, 0) as Debit,
       ISNULL(SUM(Credits.TotalClaim), 0) + isnull(Debits.Debit, 0) as Balance
     FROM rheemdb..EC_Claims Credits
        INNER JOIN rheemusers..MyOrganizations mo on mo.OrganizationID = Credits.OrganizationId AND
            mo.personID = @PersonID
   	  LEFT OUTER JOIN (
   	    Select db.ClaimYear, db.Program, ISNULL(SUM(db.TotalClaim * db.FundingSplit/100), 0) as Debit
            From rheemdb..EC_Claims db 
            INNER JOIN rheemusers..MyOrganizations mo on db.OrganizationID = mo.OrganizationID and
                 mo.PersonID = @PersonID
            WHERE db.TotalClaim < 0 and 
                (db.ClaimStatus <> 'Denied' or db.ClaimStatus is null)
             Group By db.ClaimYear, db.Program
  	   ) as Debits on Debits.ClaimYear = Credits.ClaimYear and Debits.Program = Credits.Program  
      WHERE  Credits.TotalClaim > 0 
	   GROUP BY Credits.ClaimYear, Credits.Program, Debits.Debit
	   order by Credits.ClaimYear, Credits.Program

END
GO
