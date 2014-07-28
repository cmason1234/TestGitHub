USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetGDPByAllocatedReportData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetGDPByAllocatedReportData]
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
CREATE PROCEDURE [dbo].[GetGDPByAllocatedReportData] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@userID UniqueIdentifier,
	@OrganizationID UniqueIdentifier	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
    CREATE TABLE #sp_distOrgs (
  	[OrganizationID] [uniqueidentifier] NOT NULL,
 	[OrganizationName] Varchar(255) NOT NULL
    )
	
	IF @OrganizationID = 'eea73f84-a3ec-4c91-884e-0ab88fb5279b' 
	BEGIN
	  insert into #sp_distOrgs(OrganizationID, OrganizationName)
	    SELECT o.OrganizationID, o.OrganizationName
		FROM  rheemusers..Organization o
		WHERE o.OrganizationID in (
		   select o2.OrganizationID from rheemusers..Organization o2
			 inner join rheemusers..OrganizationParent op on
				op.ParentOrganizationID = 'eea73f84-a3ec-4c91-884e-0ab88fb5279b' and 
			   o2.OrganizationID   = op.OrganizationId  
			   where 
				   o2.OrganizationType  = 'Distributor' and 
				  (o2.OrganizationName like '%richmon%' or
				   o2.OrganizationName like '%houston%' or
				   o2.OrganizationName like '%pompano%' or
				   o2.OrganizationName like '%orlando%' or
				   o2.OrganizationName like '%North Car%')) OR
			  o.OrganizationID = 'bfe18e23-1c6a-42e7-b347-b8589b509df7' OR
			  o.OrganizationID = 'eea73f84-a3ec-4c91-884e-0ab88fb5279b'
		ORDER BY OrganizationName
	END
	ELSE
	BEGIN
	  insert into #sp_distOrgs(OrganizationID, OrganizationName)
	    SELECT o.OrganizationID, replace(o.OrganizationName, '''', '&#39') 
	    FROM  RheemUsers..Organization o
	    WHERE o.OrganizationID in (
	        SELECT o2.OrganizationID from RheemUsers..Organization o2
	          INNER JOIN RheemUsers..OrganizationParent op on
	            op.ParentOrganizationID = @OrganizationID
	           WHERE 
	            o2.OrganizationID   = op.OrganizationId and
	            o2.OrganizationType  = 'Distributor' and 
	            o2.OrganizationName <> '') or
	         o.OrganizationID = @OrganizationID
       ORDER BY o.OrganizationName
    END

   Select OrganizationID, OrganizationName from #sp_distOrgs order by OrganizationName
	
   select OrganizationID, OrganizationName, SectionName
	 from rheemdb..EC_ClaimSection cs, #sp_distOrgs
	 where 
      GDPYear=@Year  and 
	  GDPSection=1 and
	  SectionName <> 'Credits'  
     order by OrganizationName, SectionName

    select spOrg.OrganizationID as OrganizationID, spOrg.OrganizationName as OrganizationName, cs.SectionName, csc.CategoryName, budg.OtherDescription, isnull(claim.claimed, 0) as claimed
	 from rheemdb..EC_ClaimSection cs
	 inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID
	 inner join #sp_distOrgs spOrg on 1=1
	 Left Outer Join ( 
	  select cb.OtherDescription, csc.ClaimSectionCategoryID
        from rheemdb..EC_ClaimSection cs
       inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
       inner join rheemdb..EC_ClaimBudget cb on csc.ClaimSectionCategoryID = cb.ClaimSectionCategoryID 
             and cb.OrganizationID=@organizationID
       inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID 
             and mo.PersonID=@userID
       inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID
       group by cb.OtherDescription, csc.ClaimSectionCategoryID
	  ) as budg on csc.ClaimSectionCategoryID=budg.ClaimSectionCategoryID
 	 left outer Join (
      select sum(TotalClaim*(cb.FundingSplit/100)) as claimed, csc.ClaimSectionCategoryID, cb.AllocatedToOrganizationID 
        from rheemdb..EC_ClaimSection cs
       inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
       inner join  rheemdb..EC_Claims cb on  cb.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
                   and cb.OrganizationID=@organizationID
       inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID and mo.PersonID=@userID
       inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID where cb.ClaimStatus <> 'Denied'
      group by SectionName, csc.CategoryName, csc.ClaimSectionCategoryID, cb.AllocatedToOrganizationID 
	 ) as claim on csc.ClaimSectionCategoryID=claim.ClaimSectionCategoryID and spOrg.OrganizationID = claim.AllocatedToOrganizationID
	 where 
      GDPYear=@Year  and 
	  GDPSection=1 and
	  SectionName <> 'Credits'  
     order by OrganizationName, SectionName, CategoryName

END
GO
