USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsReport]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimsReport]
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
CREATE PROCEDURE [dbo].[GetClaimsReport] 
	-- Add the parameters for the stored procedure here
	@OrgID uniqueidentifier,
	@Year int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    Select convert(varchar,c.ClaimDate, 101) cd, csc.*, c.*, o.*, o2.OrganizationName AllocatedName, do.*, 
           totalClaim * c.FundingSplit/100 RheemShare,  totalClaim *(100- c.FundingSplit)/100 DistributorShare
    FROM rheemdb..EC_Claims c, rheemusers..Organization o, rheemusers..Organization o2, 
         rheemdb..EC_ClaimSectionCategory csc, rheemusers..DistributorOrganization do 
    WHERE o.OrganizationId = @OrgID and 
          c.OrganizationID = o.OrganizationID and 
		  c.totalClaim < 0 and 
		  c.AllocatedToOrganizationID = o2.OrganizationID and 
		  c.ClaimYear = @Year and 
		  c.ClaimSectionCategoryId = csc.ClaimSectionCategoryId and 
		  csc.ClaimSectionCategoryID in (
              Select ClaimSectionCategoryID 
			  FROM rheemdb..EC_ClaimSectionCategory 
              WHERE ClaimSectionID in (
			     Select ClaimSectionID from rheemdb..EC_ClaimSection 
                 WHERE SectionName ='Training' and 
                       GDPSection=1 and 
                       GDPYear = @Year)) 
		  and c.OrganizationID = do.OrganizationID

END
GO
