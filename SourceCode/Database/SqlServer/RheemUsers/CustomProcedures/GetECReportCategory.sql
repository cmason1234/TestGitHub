USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECReportCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECReportCategory]
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
CREATE PROCEDURE [dbo].[GetECReportCategory] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@Year int,
	@OrgID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

	SELECT 
	   'GDP' as programValue, cs.SectionName, isnull(claims.claimed, 0) as claimedValue, cs.ShortName
	   FROM RheemDB..EC_ClaimSection cs
	   LEFT OUTER JOIN 
		(Select sum(TotalClaim*(c.FundingSplit/100)) as claimed, cs1.ClaimSectionID
		   from rheemdb..EC_Claims c 
			  INNER JOIN RheemUsers..MyOrganizations mo on c.OrganizationID = mo.OrganizationID and
				   mo.PersonID=@PersonID and (@OrgID is Null or mo.OrganizationID=@OrgID)
				INNER JOIN rheemdb..EC_ClaimSectionCategory csc on c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID 
				INNER JOIN rheemdb..EC_ClaimSection cs1 on cs1.ClaimSectionID = csc.ClaimSectionID 
		  Where
		   (c.ClaimStatus is null or c.ClaimStatus <> 'Denied') and 
		   c.Program in ('GDP') and c.ClaimYear = @Year and c.TotalClaim < 0
		   group by cs1.ClaimSectionID 
		   ) as claims on cs.ClaimSectionID = claims.ClaimSectionID
	   where cs.GDPYear = @Year and cs.GDPSection = '1'     and cs.SectionName <> 'Credits' 
	 union
	SELECT 
	 'TC' as programValue, cs.SectionName, isnull(claims.claimed, 0) as claimedValue, cs.ShortName
	   FROM RheemDB..EC_ClaimSection cs
	   LEFT OUTER JOIN 
		(Select sum(TotalClaim*(c.FundingSplit/100)) as claimed, cs1.ClaimSectionID
		   from rheemdb..EC_Claims c 
			  INNER JOIN RheemUsers..MyOrganizations mo on c.OrganizationID = mo.OrganizationID and
				   mo.PersonID=@PersonID and (@OrgID is Null or mo.OrganizationID=@OrgID)
				INNER JOIN rheemdb..EC_ClaimSectionCategory csc on c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID 
				INNER JOIN rheemdb..EC_ClaimSection cs1 on cs1.ClaimSectionID = csc.ClaimSectionID 				   				   
		  Where
		   (c.ClaimStatus is null or c.ClaimStatus <> 'Denied') and 
		   c.Program in ('TC') and c.ClaimYear = @Year and c.TotalClaim < 0
		   group by cs1.ClaimSectionID 
		   ) as claims on cs.ClaimSectionID = claims.ClaimSectionID
	   where cs.GDPYear = @Year and cs.TCSection = '1'   and cs.SectionName <> 'Credits' 
	order by  programValue, SectionName
   
END
GO

   
    
