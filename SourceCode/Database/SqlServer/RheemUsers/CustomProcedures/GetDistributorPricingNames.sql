USE [rheemusers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDistributorPricingNames]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetDistributorPricingNames]
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDistributorPricingNames] 
	-- Add the parameters for the stored procedure here
	@PersonID uniqueidentifier,
	@OrganizationID uniqueidentifier,
	@BrandID uniqueidentifier,
	@IsActive bit
AS
BEGIN

	SELECT o.OrganizationName, o.OrganizationID, b.BrandName, 
	  dcp.IsActive, dcp.IsPublic, dcp.DistributorCatalogPricingNamesID,
	  dcp.PricingName, dcp.Remarks  FROM MyOrganizations mo
		INNER JOIN organization o ON mo.OrganizationID = o.OrganizationId AND
		   o.OrganizationType  = 'Distributor' AND
		   o.OrganizationName <> '' AND o.OrganizationName is not null
		INNER JOIN DistributorOrganization do ON o.OrganizationID = do.OrganizationId AND
			(do.Disabled is null or do.Disabled=0) 
		INNER JOIN DistributorCatalogPricingNames dcp ON o.OrganizationID = dcp.OrganizationID
		INNER JOIN RheemDB..Brand b on dcp.BrandID = b.BrandID
		WHERE mo.personID         = @PersonId AND
		  (@OrganizationID is NULL OR o.OrganizationID=@OrganizationID) AND
		  (@BrandID IS NULL OR dcp.BrandID=@BrandID) AND
		  (@IsActive = 0 or dcp.IsActive=IsActive)
		ORDER BY o.OrganizationName
END
GO
