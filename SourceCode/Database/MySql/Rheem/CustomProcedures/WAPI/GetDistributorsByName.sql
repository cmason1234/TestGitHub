USE rheem;

DROP PROCEDURE IF Exists WAPI__GetDistributorsByName__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetDistributorsByName__Get(
    -- Add the parameters for the stored procedure here
    IN p_OrgName varchar(50),
	IN p_OrgID varchar(50))

  BEGIN	 
	SELECT o.OrganizationName as DistributorName, o.OrganizationID, a.AddressLine1, 
		a.AddressLine2, a.City, a.State, a.PostalCode, o.Phone, o.Fax,
		do.WebSite, do.CorporateEmail as EmailAddress 
	  FROM ru_organization o
		INNER JOIN ru_distributororganization  do ON do.OrganizationID = o.OrganizationID 
				AND (do.Disabled is null or do.Disabled = 0)
		INNER JOIN ru_address a ON do.primaryaddressID = a.AddressID 
		WHERE (LENGTH(p_OrgName) = 0 OR o.OrganizationName LIKE p_OrgName) AND
		 (LENGTH(p_OrgID) = 0 or o.OrganizationID = p_OrgID)
        ORDER BY o.OrganizationName;

END$$
DELIMITER ;


