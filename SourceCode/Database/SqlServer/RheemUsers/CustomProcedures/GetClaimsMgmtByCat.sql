USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsMgmtByCat]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimsMgmtByCat]
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
CREATE PROCEDURE [dbo].[GetClaimsMgmtByCat] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@Year int,
	@OrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

	SELECT Case when cs.SectionName='Credits' then 'Accrued' else 'Claims' end as Section,
	   'GDP' as programValue, cs.SectionName, csc.CategoryName , isnull(claims.claimed, 0) as claimedValue
	   FROM RheemDB..EC_ClaimSection cs
	   INNER JOIN rheemdb..EC_ClaimSectionCategory csc ON cs.ClaimSectionID = csc.ClaimSectionID
	   LEFT OUTER JOIN 
		(Select sum(TotalClaim*(c.FundingSplit/100)) as claimed, c.ClaimSectionCategoryID
		   from rheemdb..EC_Claims c 
			  INNER JOIN RheemUsers..MyOrganizations mo on c.OrganizationID = mo.OrganizationID and
				   mo.PersonID=@PersonID and (@OrgID is Null or mo.OrganizationID=@OrgID)
		  Where
		   (c.ClaimStatus is null or c.ClaimStatus <> 'Denied') and 
		   c.Program in ('GDP') and c.ClaimYear = @Year
		   group by c.ClaimSectionCategoryID 
		   ) as claims on csc.ClaimSectionCategoryID = claims.ClaimSectionCategoryID
	   where cs.GDPYear = @Year and cs.GDPSection = '1'   
	 union
	SELECT Case when cs.SectionName='Credits' then 'Accrued' else 'Claims' end as Section,
	 'TC' as programValue, cs.SectionName, csc.CategoryName , isnull(claims.claimed, 0) as claimedValue
	   FROM RheemDB..EC_ClaimSection cs
	   INNER JOIN rheemdb..EC_ClaimSectionCategory csc ON cs.ClaimSectionID = csc.ClaimSectionID
	   LEFT OUTER JOIN 
		(Select sum(TotalClaim*(c.FundingSplit/100)) as claimed, c.ClaimSectionCategoryID
		   from rheemdb..EC_Claims c 
			  INNER JOIN RheemUsers..MyOrganizations mo on c.OrganizationID = mo.OrganizationID and
				   mo.PersonID=@PersonID and (@OrgID is Null or mo.OrganizationID=@OrgID)
		  Where
		   (c.ClaimStatus is null or c.ClaimStatus <> 'Denied') and 
		   c.Program in ('TC') and c.ClaimYear = @Year
		   group by c.ClaimSectionCategoryID 
		   ) as claims on csc.ClaimSectionCategoryID = claims.ClaimSectionCategoryID
	   where cs.GDPYear = @Year and cs.TCSection = '1' 
	order by Section, programValue, SectionName, CategoryName
   
END
GO

   
    
