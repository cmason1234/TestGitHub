USE [rheemdb]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRebateAmountsForOneRebateName]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRebateAmountsForOneRebateName]
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
CREATE PROCEDURE [dbo].[GetRebateAmountsForOneRebateName] 
    -- Add the parameters for the stored procedure here
    @CreditRebateNamesID uniqueidentifier

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	Select cmc.CreditMarketingCodeID, cmc.MarketingCode, cmc.SortOrder
	   from EC_CreditMarketingCode cmc
		where cmc.IsActive=1
	   order by cmc.SortOrder, cmc.MarketingCode
	   
	select cmc.CreditMarketingCodeID, cmc.MarketingCode, cmc.SortOrder,
		 cpd.CreditProductDescriptionID, cpd.ProductDescription, cpd.SortOrder,
		 cra.CreditRebateAmountsID, isnull(cra.RebateAmount, 0) as RebateAmount
	   from EC_CreditMarketingCode cmc
		INNER JOIN EC_CreditProductDescription cpd on 
				  cmc.CreditMarketingCodeID = cpd.CreditMarketingCodeID AND
				  cpd.IsActive=1
		LEFT OUTER JOIN EC_CreditRebateAmounts cra ON 
				cpd.CreditProductDescriptionID = cra.CreditProductDescriptionID AND
				cra.CreditRebateNamesID = @CreditRebateNamesID
	   where cmc.IsActive=1
	   ORDER BY cmc.SortOrder, cmc.MarketingCode, cpd.SortOrder, cpd.ProductDescription	   

END
GO
