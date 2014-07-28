USE rheem;

DROP PROCEDURE IF Exists WAPI__GetContractorsForDistributor__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetContractorsForDistributor__Get(
    -- Add the parameters for the stored procedure here
    IN p_DistID varchar(50),
	IN p_ContractorID varchar(50))

  BEGIN	 
	SELECT o.OrganizationName as ContractorName, o.OrganizationID, a.AddressLine1, 
		a.AddressLine2, a.City, a.State, a.PostalCode, o.Phone, o.Fax,
		co.WebSite, co.CorporateEmail as EmailAddress 
	  FROM ru_organization o
	    INNER JOIN ru_contractororganization co on o.OrganizationID = co.OrganizationID AND
		       (co.Disabled is null or co.Disabled = 0)
		INNER JOIN ru_address a ON o.primaryaddressID = a.AddressID 
		WHERE (LENGTH(p_ContractorID) = 0 or o.OrganizationID = p_ContractorID) AND
		   (LENGTH(p_DistID) = 0 or 
		       o.OrganizationID in (
			      select op.organizationid FROM ru_organizationparent op WHERE 
				       op.ParentOrganizationID = p_DistID))
        ORDER BY o.OrganizationName;

END$$
DELIMITER ;

