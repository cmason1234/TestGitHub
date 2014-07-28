USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTCByOrganization]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTCByOrganization]
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
CREATE PROCEDURE [dbo].[GetTCByOrganization] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@DistributorValue uniqueidentifier,
    @UserID UniqueIdentifier
AS
BEGIN

    SELECT 
	  replace(dist.OrganizationName, '''', '&#39') as distOrgName, 
      SectionName, 
      'CatName' = CASE OtherRequired
	                When Null Then CategoryName
	                When 0 Then CategoryName
	                When 1 Then OtherDescription
	              END,
      sum(c.TotalClaim * c.FundingSplit/100) as claimed
	FROM rheemdb..EC_Claims c 
	INNER JOIN rheemdb..EC_ClaimSectionCategory csc on c.ClaimSectionCategoryID=csc.ClaimSectionCategoryID
	INNER JOIN RheemUsers..Organization main on c.OrganizationID = main.OrganizationID and
	      main.OrganizationID=@DistributorValue
	INNER JOIN rheemdb..EC_ClaimBudget cb ON main.OrganizationID=cb.OrganizationID and cb.ClaimsectionCategoryId =csc.ClaimsectionCategoryId
	INNER JOIN RheemUsers..Organization cont on c.AllocatedToOrganizationID = cont.OrganizationID
	INNER JOIN RheemUsers..ContractorAC cac on cont.OrganizationID = cac.OrganizationID
	INNER JOIN RheemUsers..Organization dist on cac.DistributorOrganizationID = dist.OrganizationID
    INNER JOIN rheemdb..EC_ClaimSection cs on csc.ClaimSectionID=cs.ClaimSectionID
    INNER JOIN RheemUsers..MyOrganizations mo on mo.OrganizationID=dist.OrganizationID and mo.PersonID=@UserID
    WHERE c.ClaimYear = @Year and 
          c.Program = 'TC' and 
          c.TotalClaim < 0 and
		  c.ClaimStatus <> 'Denied' 
	GROUP BY dist.OrganizationName, SectionName, OtherDescription, CategoryName, OtherRequired
	ORDER BY dist.OrganizationName, SectionName, CatName

END
