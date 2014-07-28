USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetBatchLogbyNumber]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetBatchLogbyNumber]
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
CREATE PROCEDURE [dbo].[GetBatchLogbyNumber] 
	-- Add the parameters for the stored procedure here
	@BatchNumber int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT o2.OrganizationName AllocatedName,  convert(varchar,c.ClaimDate, 101) cd, csc.CategoryName, c.*, 
	       totalClaim * c.FundingSplit/100 RheemShare,  totalClaim *(100- c.FundingSplit)/100 DistributorShare, o.OrganizationName 
	FROM rheemdb..EC_Claims c, rheemdb..EC_ClaimSectionCategory csc , rheemUsers..Organization o , rheemUsers..Organization o2
    WHERE c.OrganizationId = o.OrganizationID and 
          c.BatchNumber = @BatchNumber and
          c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID and
          c.AllocatedToOrganizationID = o2.OrganizationID 
    ORDER BY BatchRecordNumber
END
GO
