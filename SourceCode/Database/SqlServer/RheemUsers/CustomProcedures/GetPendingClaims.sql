USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPendingClaims]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPendingClaims]
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
CREATE PROCEDURE [dbo].[GetPendingClaims] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT DISTINCT csc.CategoryName, c.*, totalClaim * c.FundingSplit/100 RheemShare,  
	       totalClaim *(100- c.FundingSplit)/100 DistributorShare, 
	       o2.OrganizationName 
	FROM  rheemusers..MyOrganizations mo,rheemusers..Organization o, rheemusers..Organization o2, rheemdb..EC_Claims c, 
	      rheemdb..EC_ClaimSectionCategory csc
    WHERE mo.personID = @PersonID and 
          mo.OrganizationID = o.OrganizationId and 
          (mo.OrganizationID = c.OrganizationId or mo.organizationID = c.AllocatedToOrganizationID ) and 
          c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID and 
          c.AllocatedToOrganizationId = o2.OrganizationID and 
          c.ClaimStatus = 'Pending'  
    ORDER BY claimDate desc

END
GO
