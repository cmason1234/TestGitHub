USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetCategoryReportData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetCategoryReportData]
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
CREATE PROCEDURE [dbo].[GetCategoryReportData] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@GDPUse bit,
	@TCUse bit,
	@cbProgram varchar(3),
	@userID UniqueIdentifier,
	@OrganizationID UniqueIdentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    select SectionName
	 from rheemdb..EC_ClaimSection cs
	 where 
      GDPYear=@Year  and 
	  (GDPSection=@GDPUse or TCSection=@TCUse) and
	  SectionName <> 'Credits'  
     order by SectionName

    select cs.SectionName, csc.CategoryName, budg.OtherDescription, isnull(budg.budget, 0) as budget , isnull(claim.claimed, 0) as claimed
	 from rheemdb..EC_ClaimSection cs
	 inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
	 Left Outer Join ( 
	  select sum(TotalBudget*((case when do.SingleLine = 1 then csc.FundingSplitSingleLine else csc.FundingSplit END)*0.01)) as budget, cb.OtherDescription, csc.ClaimSectionCategoryID
        from rheemdb..EC_ClaimSection cs
       inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
       inner join rheemdb..EC_ClaimBudget cb on csc.ClaimSectionCategoryID = cb.ClaimSectionCategoryID 
             and cb.OrganizationID=@organizationID
       inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID 
             and mo.PersonID=@userID
       inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID
       INNER JOIN RheemUsers..DistributorOrganization do on o.OrganizationID = do.OrganizationID
       group by cb.OtherDescription, csc.ClaimSectionCategoryID
	 ) as budg on csc.ClaimSectionCategoryID=budg.ClaimSectionCategoryID
	 Left Outer Join (
      select sum(TotalClaim*(cb.FundingSplit/100)) as claimed, csc.ClaimSectionCategoryID
        from rheemdb..EC_ClaimSection cs
       inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
       inner join  rheemdb..EC_Claims cb on  cb.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
                   and cb.OrganizationID=@organizationID
       inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID and mo.PersonID=@userID
       inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID where cb.ClaimStatus <> 'Denied'
      group by SectionName, csc.CategoryName, csc.ClaimSectionCategoryID
	 ) as claim on csc.ClaimSectionCategoryID=claim.ClaimSectionCategoryID
	 where 
      GDPYear=@Year  and 
	  (GDPSection=@GDPUse or TCSection=@TCUse) and
	  SectionName <> 'Credits'  
     order by SectionName, CategoryName

END
GO
