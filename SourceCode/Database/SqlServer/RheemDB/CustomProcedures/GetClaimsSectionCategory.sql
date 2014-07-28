USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsSectionCategory]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimsSectionCategory]
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
CREATE PROCEDURE [dbo].[GetClaimsSectionCategory] 
	-- Add the parameters for the stored procedure here
	@YearSelected int,
	@ProgramValue varchar(50),
	@EClaimsAdmin bit,
	@DistributorValue uniqueidentifier

AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(4000)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


    -- Insert statements for procedure here
	 IF @ProgramValue = 'PROSTOCK' 
	  BEGIN
        SELECT  @sql = 'SELECT *,
	                     ''CatName'' = 
	                        CASE OtherRequired
	                        When Null Then CategoryName
	                        When 0 Then CategoryName
	                        When 1 Then CategoryName
	                        END
		                FROM rheemdb..EC_ClaimSectionCategory csc, rheemdb..EC_ClaimSection cs 
                        WHERE csc.ClaimSectionID = cs.ClaimSectionId and 
                              cs.ProStockSection=1 and 
                              csc.CategoryName not in ( ''Credit'') and 
                              cs.GDPYear = @YearSelected 
                        ORDER BY CatName '
      END

     IF @ProgramValue = 'SPECIAL' 
	  BEGIN
	    SELECT  @sql = 'SELECT *,
	                     ''CatName'' = 
	                        CASE OtherRequired
	                        When Null Then CategoryName
	                        When 0 Then CategoryName
	                        When 1 Then CategoryName
	                        END
				        FROM rheemdb..EC_ClaimSectionCategory csc, rheemdb..EC_ClaimSection cs 
                        WHERE csc.ClaimSectionID = cs.ClaimSectionId and 
                              cs.SpecialProgramSection=1 and 
                              csc.CategoryName not in ( ''Credit'') and 
                              cs.GDPYear= @YearSelected
                        ORDER BY CatName'

      END

     IF @ProgramValue = 'GDP' 
      BEGIN
	    SELECT  @sql = 'SELECT *,
	                     ''CatName'' = 
	                        CASE OtherRequired
	                        When Null Then CategoryName
	                        When 0 Then CategoryName
	                        When 1 Then OtherDescription
	                        END
		                FROM rheemdb..EC_ClaimSectionCategory csc, rheemdb..EC_ClaimSection cs, rheemdb..EC_ClaimBudget cb
                        WHERE csc.ClaimSectionID = cs.ClaimSectionId and '

        IF @EclaimsAdmin = 0
         BEGIN
	        SELECT @sql = @sql + ' (csc.nonbilling is null or csc.NonBilling =0) and '
         END

        SELECT @sql = @sql + ' cs.GDPSection=1 and csc.CategoryName not in ( ''Credit'', ''Design Star'' ) and 
                               cb.OrganizationId = @DistributorValue and 
                               cb.ClaimsectionCategoryId =csc.ClaimsectionCategoryId and 
                               not(csc.OtherRequired = 1 and (cb.OtherDescription is null or cb.OtherDescription='''')) and 
                               cb.BudgetYear = @YearSelected
                               ORDER BY CatName'

      END

     IF @ProgramValue = 'TC' 
	  BEGIN
	    SELECT  @sql = 'SELECT *,
	                     ''CatName'' = 
	                        CASE OtherRequired
	                        When Null Then CategoryName
	                        When 0 Then CategoryName
	                        When 1 Then OtherDescription
	                        END
		                FROM rheemdb..EC_ClaimSectionCategory csc, rheemdb..EC_ClaimSection cs, rheemdb..EC_ClaimBudget cb 
                        WHERE csc.ClaimSectionID = cs.ClaimSectionId and 
                              cs.TCSection=1 and '

        IF @EclaimsAdmin = 0
         BEGIN
	        SELECT @sql = @sql + ' (csc.nonbilling is null or csc.NonBilling =0) and '
         END
              
	    SELECT @sql = @sql + ' csc.CategoryName not in (''Credit'') and 
                               cb.OrganizationId = @DistributorValue and
                               cb.ClaimsectionCategoryId =csc.ClaimsectionCategoryId and 
                               not(csc.OtherRequired = 1 and (cb.OtherDescription is null or cb.OtherDescription='''')) and
                               cb.BudgetYear = @YearSelected
                               ORDER BY CatName '

     END

	 SELECT @paramlist = '@distributorValue uniqueidentifier,                             
			              @yearSelected     int '      

     EXEC sp_executesql @sql, @paramlist, @DistributorValue, @YearSelected
  
END
GO