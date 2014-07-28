USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMonthlyPurchases]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetMonthlyPurchases]
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
CREATE PROCEDURE [dbo].[GetMonthlyPurchases] 
	-- Add the parameters for the stored procedure here
	@PersonID UniqueIdentifier,
	@Year int,
	@Month varchar(50),
	@DistID UniqueIdentifier
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT ccn.CategoryName, cc.CreditCategoryID,
		ISNULL(ccum.CreditCategoryUnitsByMonthID, '00000000-0000-0000-0000-000000000000') as CreditCategoryUnitsByMonthID,
		ISNULL(cc.GDPYear, @Year) as GDPYear, 
		ISNULL(cc.RebateAmount, 0) as RebateAmount,
		ISNULL(ccum.Units, 0) as Units,
		ISNULL(ccum.RebateTotal, 0) as RebateTotal 
	  FROM EC_CreditCategoryNames ccn
      INNER JOIN EC_CreditCategory cc ON 
	     ccn.CreditCategoryNameID=cc.CreditCategoryNameID AND
		 GDPYear=@Year
	  INNER JOIN RheemUsers..MyOrganizations mo on mo.PersonID=@PersonID and mo.OrganizationID=@DistID
	  LEFT OUTER JOIN EC_CreditCategoryUnitsByMonth ccum on ccum.OrganizationID = mo.OrganizationID AND
	        ccum.GDPYear = @Year AND ccum.GDPMonth = @Month AND cc.CreditCategoryID=ccum.CreditCategoryID
  	  WHERE ccn.Active = 1
	  ORDER BY ccn.CategoryName

END
GO
