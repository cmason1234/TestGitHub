USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetClaimCreditCategoryByYear]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetClaimCreditCategoryByYear]
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
CREATE PROCEDURE [dbo].[GetClaimCreditCategoryByYear] 
	-- Add the parameters for the stored procedure here
	@Year int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT ccn.CreditCategoryNameID, ccn.CategoryName, 
		ISNULL(cc.CreditCategoryID, '00000000-0000-0000-0000-000000000000') as CreditCategoryID,
		ISNULL(cc.GDPYear, @Year) as GDPYear, 
		ISNULL(cc.RebateAmount, 0) as RebateAmount 
	  FROM EC_CreditCategoryNames ccn
      LEFT OUTER JOIN EC_CreditCategory cc ON 
	     ccn.CreditCategoryNameID=cc.CreditCategoryNameID AND
		 GDPYear=@Year
  	  WHERE ccn.Active = 1
	  ORDER BY ccn.CategoryName

END
GO
