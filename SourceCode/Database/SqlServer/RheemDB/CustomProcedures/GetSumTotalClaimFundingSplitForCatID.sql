USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSumTotalClaimFundingSplitForCatID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSumTotalClaimFundingSplitForCatID]
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
CREATE PROCEDURE [dbo].[GetSumTotalClaimFundingSplitForCatID] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier,
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT SUM(TotalClaim * FundingSplit / 100 ) 
	FROM rheemdb..EC_Claims 
    WHERE OrganizationId = @OrgID and 
          Program        = 'GDP' and 
          ClaimYear      = @Year and 
          ClaimSectionCategoryID in 
		  (
            SELECT ClaimSectionCategoryID 
 	        FROM rheemdb..EC_ClaimSectionCategory 
            WHERE ClaimSectionID in 
 		    (
             SELECT ClaimSectionID 
		     FROM rheemdb..EC_ClaimSection 
             WHERE SectionName ='Training' and 
                   GDPSection=1 and 
                   GDPYear= @Year
            )
          )

END
GO
