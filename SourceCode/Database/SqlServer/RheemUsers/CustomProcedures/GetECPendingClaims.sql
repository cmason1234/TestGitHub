USE [RheemUsers]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetECPendingClaims]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetECPendingClaims]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetECPendingClaims] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@ClaimStatus Varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT csc.CategoryName, convert(varchar,c.ClaimDate, 101) cd,  
	       c.*, totalClaim * c.FundingSplit/100 RheemShare,  
	       totalClaim *(100- c.FundingSplit)/100 DistributorShare, 
	       o.OrganizationName as DistributorName,
	       o2.OrganizationName as organizationName
	FROM  rheemusers..MyOrganizations mo
	   INNER JOIN RheemUsers..Organization o ON mo.OrganizationID = o.OrganizationId
	   INNER JOIN RheemDB..EC_Claims c ON mo.OrganizationID = c.OrganizationId AND
         	      c.ClaimStatus = @ClaimStatus
	   INNER JOIN RheemDB..EC_ClaimSectionCategory csc ON c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
	   INNER JOIN RheemUsers..Organization o2 ON c.AllocatedToOrganizationId = o2.OrganizationID
    WHERE mo.personID = @PersonID 
    ORDER BY claimDate desc

END
