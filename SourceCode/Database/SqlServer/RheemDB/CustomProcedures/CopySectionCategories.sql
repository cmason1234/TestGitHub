USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CopySectionCategories]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CopySectionCategories]
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
CREATE PROCEDURE [dbo].[CopySectionCategories] 
	-- Add the parameters for the stored procedure here
	@Year int,
	@NextYear int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
    INSERT INTO EC_ClaimSection (ClaimSectionID, SectionName, MinRequirement, MaxRequirement, GDPSection, TCSection, 
	       ProStockSection, SpecialProgramSection, GDPYear, MinPercent, MaxPercent, FixedRequirement, FixedPercent,
		   DisplayOrder, WHSection, ShortName, Reserved)
    (SELECT NEWID(), SectionName, MinRequirement, MaxRequirement, GDPSection, TCSection, ProStockSection, SpecialProgramSection, @NextYear, 
	        MinPercent, MaxPercent, FixedRequirement, FixedPercent, DisplayOrder, WHSection, ShortName, Reserved
			FROM EC_ClaimSection where GDPYear=@Year)
 
    INSERT INTO EC_ClaimSectionCategory (ClaimSectionCategoryID, ClaimSectionID, CategoryName,
              RheemAccountCode, RuudAccountCode, FundingSplit, FundingSplitSingleLine, ApprovalRequired,
              OtherRequired, NonBilling, FixedCost, FixedCostPercent, OracleRheemAccountCode, OracleRuudAccountCode,
			  Description, Examples)
       (SELECT newid(), ecnew.ClaimSectionID, CategoryName, RheemAccountCode, RuudAccountCode, FundingSplit, 
	     FundingSplitSingleLine, ApprovalRequired, OtherRequired, NonBilling, FixedCost, FixedCostPercent, 
		 OracleRheemAccountCode, OracleRuudAccountCode, Description, Examples 
		   FROM EC_ClaimSectionCategory ecsc 
        INNER JOIN EC_ClaimSection ecold on ecsc.ClaimSectionID = ecold.ClaimSectionID AND
                        ecold.GDPYear=@Year
        INNER JOIN EC_ClaimSection ecnew on ecold.SectionName = ecnew.SectionName AND 
					 ecold.MinRequirement = ecnew.MinRequirement and
					 ecold.MaxRequirement = ecnew.MaxRequirement and
					 ecold.GDPSection = ecnew.GDPSection and
					 ecold.TCSection = ecnew.TCSection and
					 ecold.ProStockSection = ecnew.ProStockSection and
					 ecold.SpecialProgramSection = ecnew.SpecialProgramSection and
					 ecold.WHSection = ecnew.WHSection and
					 ecold.ShortName = ecnew.ShortName and
                     ecnew.GDPYear=@NextYear)
					 
					 
	insert into EC_DistributorTag (EC_DistributorTagID, GDPClaimYear, OrganizationID, TagName, GDPBudget, TCBudget,
			WHBudget, SPBudget, PROSTOCKBudget) 
		select NEWID(), @NextYear, OrganizationID, TagName, GDPBudget, TCBudget,
			WHBudget, SPBudget, PROSTOCKBudget from EC_DistributorTag where GDPClaimYear=@Year
    
END
GO
