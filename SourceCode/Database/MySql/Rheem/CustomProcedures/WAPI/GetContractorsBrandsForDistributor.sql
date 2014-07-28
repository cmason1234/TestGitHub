USE rheem;

DROP PROCEDURE IF Exists WAPI__GetContractorsBrandsForDistributor__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetContractorsBrandsForDistributor__Get(
    -- Add the parameters for the stored procedure here
    IN p_DistID varchar(50),
	IN p_ContractorID varchar(50))

  BEGIN	 
	SELECT o.OrganizationName as ContractorName, o.OrganizationID, 
	      br.BrandID, br.BrandName
	  FROM ru_organization o
	    INNER JOIN ru_contractororganization co on o.OrganizationID = co.OrganizationID AND
		       (co.Disabled is null or co.Disabled = 0)
		INNER JOIN ru_address a ON o.primaryaddressID = a.AddressID
        INNER JOIN ru_organizationbrand ob on o.OrganizationID=ob.OrganizationID
		INNER JOIN rdb_brand br on ob.BrandID=br.BrandID
		WHERE (LENGTH(p_ContractorID) = 0 or o.OrganizationID = p_ContractorID) AND
		   (LENGTH(p_DistID) = 0 or 
		       o.OrganizationID in (
			      select op.organizationid FROM ru_organizationparent op WHERE 
				       op.ParentOrganizationID = p_DistID))
        ORDER BY o.OrganizationName, br.BrandName;

END$$
DELIMITER ;

