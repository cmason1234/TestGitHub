USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetNonInvoicedClaims]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetNonInvoicedClaims]
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
CREATE PROCEDURE [dbo].[GetNonInvoicedClaims] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT c.Description, convert(varchar,c.ClaimDate, 101) cd, csc.*, c.*, o.*, o2.OrganizationName AllocatedName, do.*, 
           totalClaim * c.FundingSplit/100 RheemShare,  totalClaim *(100- c.FundingSplit)/100 DistributorShare 
    FROM rheemdb..EC_Claims c, rheemusers..Organization o, rheemusers..Organization o2, 
         rheemdb..EC_ClaimSectionCategory csc, rheemusers..DistributorOrganization do 
    WHERE c.OrganizationID = o.OrganizationID and 
          c.totalClaim < 0 and 
          c.ClaimStatus = 'Approved' and 
          c.OracleBatchNumber is null and 
          c.AllocatedToOrganizationID = o2.OrganizationID and 
          c.ClaimYear = (SELECT year(getdate())) and 
          c.ClaimSectionCategoryId = csc.ClaimSectionCategoryId and 
          csc.CategoryName <> 'Non-Billing'  and 
          c.OrganizationID = do.OrganizationID and 
          (csc.NonBilling is null or csc.NonBilling = '0')
       order by c.ClaimDate
END
GO
