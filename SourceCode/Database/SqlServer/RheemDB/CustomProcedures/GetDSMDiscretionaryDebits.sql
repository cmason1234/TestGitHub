USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDSMDiscretionaryDebits]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDSMDiscretionaryDebits]
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
CREATE PROCEDURE [dbo].[GetDSMDiscretionaryDebits] 
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
    SELECT sum(totalClaim * c.FundingSplit/100  ) 
	FROM rheemdb..EC_Claims c  
    WHERE c.OrganizationId = @DistributorValue and 
          c.ClaimYear = @Year and 
          c.Program= @ProgramValue and 
          c.totalClaim < 0 and 
          (c.claimstatus <> 'Denied' ) and 
          c.ClaimSectionCategoryID in (
               SELECT ClaimSectionCategoryId 
			   FROM rheemdb..EC_ClaimSectionCategory csc 
               WHERE ClaimSectionId in (
                     SELECT ClaimSectionId 
					 FROM rheemdb..EC_ClaimSection 
					 WHERE SectionName='DSM Discretionary' and MaxRequirement='1' and GDPYear= @Year 
                 )
              )

END
GO
