USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDesignStarDebits]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDesignStarDebits]
GO
/****** Object:  StoredProcedure [dbo].[GetDSMDiscretionaryDebits]    Script Date: 02/02/2012 12:23:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDesignStarDebits] 
	-- Add the parameters for the stored procedure here
	@DistributorValue uniqueidentifier,
	@ProgramValue varchar(50),
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    --SELECT sum(totalClaim * c.FundingSplit/100  ) 
	--FROM rheemdb..EC_Claims c  
    --WHERE c.OrganizationId = @DistributorValue and 
    --     c.ClaimYear = @Year and 
    --      c.Program= @ProgramValue and 
    --     c.totalClaim < 0 and 
    --      (c.claimstatus = 'Approved' or c.claimstatus is null) and 
    --      c.ClaimSectionCategoryID in (
    --           SELECT ClaimSectionCategoryId 
	--		   FROM rheemdb..EC_ClaimSectionCategory csc 
    --           WHERE ClaimSectionId in (
    --                 SELECT ClaimSectionId 
	--				 FROM rheemdb..EC_ClaimSection 
	--				 WHERE SectionName like '%Design Star' and GDPYear= @Year 
    --             )
    --         )

	   SELECT sum(totalClaim * c.FundingSplit/100 ) * .05 * -1 FROM rheemdb..EC_Claims c 
    WHERE c.OrganizationId = @DistributorValue and 
          c.ClaimYear = @Year and 
          c.Program = @ProgramValue and 
          c.totalClaim > 0 
	
	
END
