USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsBySection]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimsBySection]
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
CREATE PROCEDURE [dbo].[GetClaimsBySection] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@Year int,
	@SectionID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

	 -- EC_ClaimSection is not included, since the sectionID already came from there.
     SELECT o.OrganizationName, c.totalClaim, c.Description, c.claimStatus, c.ClaimDate 
    	FROM rheemdb..EC_Claims c
		   INNER JOIN rheemdb..EC_ClaimSectionCategory csc ON c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID AND
		           csc.ClaimSectionID = @SectionID
		   INNER JOIN rheemUsers..Organization o ON c.OrganizationId = o.OrganizationID
		   INNER JOIN RheemUsers..MyOrganizations mo on o.OrganizationID=mo.OrganizationID and
		                     mo.PersonID=@PersonID
        WHERE c.ClaimYear=@Year 
	  ORDER BY organizationName, c.ClaimDate

END
GO

   
