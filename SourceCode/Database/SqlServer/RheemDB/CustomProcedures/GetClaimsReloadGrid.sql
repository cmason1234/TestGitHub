USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimsReloadGrid]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimsReloadGrid]
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
CREATE PROCEDURE [dbo].[GetClaimsReloadGrid] 
	-- Add the parameters for the stored procedure here
	@DistributorValue uniqueidentifier,
	@Year int,
	@ProgramValue varchar(50)
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(50)
	 -- SET NOCOUNT ON added to prevent extra result sets from
	 -- interfering with SELECT statements.
	 SET NOCOUNT ON;

     -- Insert statements for procedure here
     SELECT c.ClaimID, convert(varchar,c.ClaimDate, 101) cd, csc.OtherRequired,  csc.CategoryName, c.*, 
	        totalClaim * c.FundingSplit/100 RheemShare,  
	        totalClaim *(100- c.FundingSplit)/100 DistributorShare, o.OrganizationName, 
            convert(varchar(10), c.BatchNumber) + '/' + convert (varchar(10), BatchRecordNumber) bn, c.OracleBatchNumber  
	 FROM rheemdb..EC_Claims c, rheemdb..EC_ClaimSectionCategory csc , rheemUsers..Organization o 
     WHERE c.OrganizationId = @DistributorValue and 
           c.AllocatedToOrganizationId = o.OrganizationID and 
           c.ClaimYear = @Year and 
           c.Program= @ProgramValue and 
           c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID  and
           (claimstatus = 'Approved' or claimstatus is null or claimstatus='Pending' or claimstatus='PendingDSM' or claimstatus='PendingRSM') 
     ORDER BY claimDate 


END
GO
