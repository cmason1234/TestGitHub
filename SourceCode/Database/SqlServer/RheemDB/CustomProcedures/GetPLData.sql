USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPLData]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPLData]
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
CREATE PROCEDURE [dbo].[GetPLData] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@GDPSection bit,
	@TCSection bit,
	@SpecialSection bit,
	@ProStockSection bit,
	@WHSection bit,
	@cbProgram varchar(25),
	@userID UniqueIdentifier,
	@OrganizationID UniqueIdentifier
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    select CASE cs.SectionName When 'Credits' then 'Accrued' Else 'Claims' END as SectionType,
       cs.SectionName, csc.CategoryName, claim.OtherDescription, isnull(claim.claimed, 0) as claimed
	 from rheemdb..EC_ClaimSection cs
	 inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
	 Left Outer Join (
      select sum(TotalClaim*(cb.FundingSplit/100)) as claimed, csc.ClaimSectionCategoryID, cbudg.OtherDescription
        from rheemdb..EC_ClaimSection cs
       inner join rheemdb..EC_ClaimSectionCategory  csc on cs.ClaimSectionID = csc.ClaimSectionID 
       inner join  rheemdb..EC_Claims cb on  cb.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
                   and(@OrganizationID IS Null or cb.OrganizationID=@organizationID) 
                   and cb.ClaimYear = @Year and cb.Program = @cbProgram AND
                   (cb.ClaimStatus <> 'Denied' or cb.ClaimStatus is null)
       inner join rheemusers..MyOrganizations mo on cb.OrganizationID = mo.OrganizationID and mo.PersonID=@userID
       inner join rheemusers..Organization o on mo.OrganizationID = o.OrganizationID 
       LEFT OUTER join rheemdb..EC_ClaimBudget cbudg on csc.ClaimSectionCategoryID = cbudg.ClaimSectionCategoryID 
             and cbudg.OrganizationID=cb.OrganizationID
      group by SectionName, csc.CategoryName, csc.ClaimSectionCategoryID, cbudg.OtherDescription
	 ) as claim on csc.ClaimSectionCategoryID=claim.ClaimSectionCategoryID
	 where 
      GDPYear=@Year  and 
	  (@GDPSection is null or GDPSection=@GDPSection) and
	  (@TCSection is null or TCSection=@TCSection) and
	  (@SpecialSection is null or SpecialProgramSection=@SpecialSection) and
	  (@ProStockSection is null or ProStockSection=@ProStockSection) and
	  (@WHSection is null or WHSection=@WHSection) 
     order by SectionName, CategoryName

END
GO

