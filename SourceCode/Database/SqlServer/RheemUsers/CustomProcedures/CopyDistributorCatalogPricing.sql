USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CopyDistributorCatalogPricing]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[CopyDistributorCatalogPricing]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CopyDistributorCatalogPricing] 
	-- Add the parameters for the stored procedure here
	@CopyFromID uniqueidentifier,
	@CopyToID uniqueidentifier
AS
BEGIN
	INSERT INTO DistributorCatalogPricing (DistributorCatalogPricingID, DistributorCatalogPricingNamesID, ProductModelID
      ,ModelCost, IsActive, CreateDateTime__Gen, UpdateDateTime__Gen) 
      (SELECT NEWID(), @CopyToID, productModelID, ModelCost, IsActive, SYSDATETIME(), SYSDATETIME()
       FROM DistributorCatalogPricing WHERE DistributorCatalogPricingNamesID=@CopyFromID)

END
GO
