USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSectionReportData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSectionReportData]
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
CREATE PROCEDURE [dbo].[GetSectionReportData] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@GDPUse bit,
	@TCUse bit,
	@cbProgram varchar(3),
	@userID UniqueIdentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select SectionName, ClaimSectionID 
	 from rheemdb..EC_ClaimSection    where 
      GDPYear=@Year  and 
	  (GDPSection=@GDPUse or TCSection=@TCUse) and
	  SectionName <> 'Credits'  
     order by SectionName
                      
select sum(TotalBudget*(case
       when do.SingleLine = 1 then csc.FundingSplitSingleLine
       else csc.FundingSplit
      END) / 100) as budget, SectionName, cs.ClaimSectionID, o.OrganizationName  
 from rheemdb..EC_ClaimSection cs
 inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
 inner join rheemdb..EC_ClaimBudget cb on csc.ClaimSectionCategoryID = cb.ClaimSectionCategoryID 
 inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID 
         and mo.PersonID=@userID
 inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID
 INNER JOIN RheemUsers..DistributorOrganization do on o.OrganizationID = do.OrganizationID
 where cb.BudgetYear= @Year and 
   (cb.GDPBudget=@GDPUse or cb.TCBudget=@TCUse) and 
   cs.GDPYear=@Year  and 
   (cs.GDPSection=@GDPUse or cs.TCSection=@TCUse) and 
   cs.SectionName <> 'Credits'
  group by SectionName, cs.ClaimSectionID, o.OrganizationName
  order by o.OrganizationName, cs.SectionName
 
 select sum(TotalClaim*(cb.FundingSplit/100)) as claimed, SectionName, cs.ClaimSectionID, o.OrganizationName  
   from rheemdb..EC_ClaimSection cs
 inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
 inner join  rheemdb..EC_Claims cb on  cb.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
 inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID and mo.PersonID=@userID
 inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID where cb.ClaimYear= @Year and 
 cb.Program = @cbProgram and cb.ClaimStatus <> 'Denied' and cb.TotalClaim < 0  and
 cs.GDPYear=@Year  and (cs.GDPSection=@GDPUse or cs.TCSection=@TCUse) and cs.SectionName <> 'Credits'
 and (csc.NonBilling is null or csc.NonBilling = 0)
 group by SectionName, cs.ClaimSectionID, o.OrganizationName
 order by o.OrganizationName, cs.SectionName
 
 
END
GO
