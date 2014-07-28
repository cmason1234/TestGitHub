USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorsForPricing]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorsForPricing]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDistributorsForPricing] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier
AS
BEGIN

	SELECT distinct o.OrganizationID, o.OrganizationName, ISNULL(pr.numPrices, 0) as NumPricing
	  FROM rheemusers..MyOrganizations mo
		INNER JOIN rheemusers..organization o on  mo.OrganizationID   = o.OrganizationId and 
			 o.OrganizationName <> '' and o.OrganizationName is not null  AND
			 o.OrganizationType  = 'Distributor'
		INNER JOIN rheemusers..DistributorOrganization do ON o.OrganizationID    = do.OrganizationId and
			 (do.Disabled is null or do.Disabled=0) and do.AC = 1
		LEFT OUTER JOIN (
			select OrganizationID, COUNT(*) as numPrices from DistributorCatalogPricingNames
			   group by OrganizationID
			) pr on o.OrganizationID=pr.OrganizationID
		WHERE 
			mo.personID         = @PersonId
		ORDER BY o.OrganizationName
END
GO
