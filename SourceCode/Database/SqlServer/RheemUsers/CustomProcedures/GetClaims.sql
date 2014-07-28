USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaims]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaims]
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
CREATE PROCEDURE [dbo].[GetClaims] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@Description varchar(256),
	@Year int,
	@DistributorID uniqueidentifier,
	@Vendor varchar(50),
	@VendorInvoiceNumber varchar(50),
	@DistributorClaimNumber varchar(50),
	@MFGInvoice varchar(50),
	@OracleBatchNumber int,
	@OracleInvoiceNumber int,
	@ClaimStatus varchar(50),
	@ClaimStatusNull varchar(50),
	@ProgSel varchar(50)
AS
BEGIN
DECLARE @sql nvarchar(MAX),
        @paramlist  nvarchar(4000)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	 SET NOCOUNT ON;	

     SELECT c.ClaimID, convert(varchar,c.ClaimDate, 101) cd, csc.OtherRequired,  csc.CategoryName, c.*, 
	          totalClaim * c.FundingSplit/100 RheemShare,  totalClaim *(100- c.FundingSplit)/100 DistributorShare, 
			  o.OrganizationName, cs.SectionName, cb.OtherDescription, AllocatedOrg.OrganizationName as AllocOrgName
    	FROM rheemdb..EC_Claims c
		   INNER JOIN rheemdb..EC_ClaimSectionCategory csc ON c.ClaimSectionCategoryID = csc.ClaimSectionCategoryID
		   INNER JOIN RheemDB..EC_ClaimSection cs on csc.ClaimSectionID=cs.ClaimSectionID
		   INNER JOIN rheemUsers..Organization o ON c.OrganizationId = o.OrganizationID
		   INNER JOIN RheemUsers..MyOrganizations mo on o.OrganizationID=mo.OrganizationID and
		                     mo.PersonID=@PersonID
		   INNER JOIN RheemUsers..Organization AllocatedOrg ON c.AllocatedToOrganizationID=AllocatedOrg.OrganizationID
		   LEFT OUTER JOIN RheemDB..EC_ClaimBudget cb on csc.ClaimSectionCategoryID=cb.ClaimSectionCategoryID and
		         c.OrganizationID = cb.OrganizationID
        WHERE 
			(@Description is null or  c.Description like @Description) and 
			(@Vendor is NULL or c.Vendor like @Vendor) and 
			(@VendorInvoiceNumber IS NULL OR c.VendorInvoiceNumber like @VendorInvoiceNumber) and 
			(@DistributorClaimNumber IS NULL OR c.DistributorClaimNumber like @DistributorClaimNumber) and 
			(@MFGInvoice IS NULL OR c.MFGInvoice is null or c.MFGInvoice like @MFGInvoice) and 
			(@OracleBatchNumber is NULL OR c.OracleBatchNumber=@OracleBatchNumber) and
            (@OracleInvoiceNumber IS NULL OR c.OracleInvoiceNumber=@OracleInvoiceNumber) and
			(@Year is NULL or c.ClaimYear=@Year) and
			(@DistributorID is NULL or c.OrganizationID=@DistributorID) and
			(@ClaimStatus is NULL or c.ClaimStatus=@ClaimStatus) and
			(@ClaimStatusNull is Null or c.ClaimStatus is Null) and
			(@ProgSel is Null or c.Program=@ProgSel)
	  ORDER BY claimDate desc

END
GO

   
