USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetTAGPLData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetTAGPLData]
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
CREATE PROCEDURE [dbo].[GetTAGPLData] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@cbProgram varchar(50),
	@userID UniqueIdentifier,
	@OrganizationID UniqueIdentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT 'Accrued' as SectionType,
     'Credits' as TagName, SUM(TotalClaim*(isnull(cb.FundingSplit, 0)/100)) as claimed
    from RheemDB..EC_Claims cb where cb.TotalClaim >0 and cb.ClaimYear = @Year and cb.Program = @cbProgram AND
	       cb.OrganizationID=@organizationID 
   UNION
    select 'Claims' as SectionType,
       dt.TagName, sum(TotalClaim*(isnull(cb.FundingSplit, 0)/100)) as claimed
	 from RheemDB..EC_Claims cb
       inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID and mo.PersonID=@userID
       INNER JOIN rheemdb..EC_ClaimSectionCategory  csc on cb.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
       INNER JOIN RheemDB..EC_ClaimSection cs on csc.ClaimSectionID=cs.ClaimSectionID
       INNER JOIN RheemDB..EC_DistributorTag dt on cb.EC_DistributorTagID = dt.EC_DistributorTagID and
         dt.OrganizationID = cb.OrganizationID 
	 where cb.ClaimYear = @Year and cb.Program = @cbProgram AND
	       cb.OrganizationID=@organizationID AND
	       (cb.ClaimStatus <> 'Denied' or cb.ClaimStatus is null)
	 Group by cs.SectionName, dt.TagName
     order by SectionType DESC, TagName

END
GO

