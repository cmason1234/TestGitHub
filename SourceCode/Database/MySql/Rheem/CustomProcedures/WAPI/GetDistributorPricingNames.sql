USE rheem;

DROP PROCEDURE IF Exists WAPI__GetDistributorPricingNames__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetDistributorPricingNames__Get(
    -- Add the parameters for the stored procedure here
	IN p_PersonID varchar(64),
    IN p_OrgID varchar(64),
	IN p_BrandID varchar(64),
	IN p_IsActive bit)

  BEGIN	 
  
	SELECT o.OrganizationName, o.OrganizationID, b.BrandName, 
	  dcp.IsActive, dcp.IsPublic, dcp.DistributorCatalogPricingNamesID,
	  dcp.PricingName, dcp.Remarks  FROM ru_myorganizations mo
		INNER JOIN ru_organization o ON mo.OrganizationID = o.OrganizationId AND
		   o.OrganizationType  = 'Distributor' AND
		   o.OrganizationName <> '' AND o.OrganizationName is not null
		INNER JOIN ru_distributororganization do ON o.OrganizationID = do.OrganizationId AND
			(do.Disabled is null or do.Disabled=0) 
		INNER JOIN ru_distributorcatalogpricingnames dcp ON o.OrganizationID = dcp.OrganizationID
		INNER JOIN rdb_brand b on dcp.BrandID = b.BrandID
		WHERE mo.personID         = p_PersonID AND
		  (LENGTH(p_OrgID) = 0 OR o.OrganizationID=p_OrgID) AND
		  (LENGTH(p_BrandID) = 0 OR dcp.BrandID=p_BrandID) AND
		  (p_IsActive = 0 or dcp.IsActive=p_IsActive)
		ORDER BY o.OrganizationName, dcp.PricingName;

END$$
DELIMITER ;

