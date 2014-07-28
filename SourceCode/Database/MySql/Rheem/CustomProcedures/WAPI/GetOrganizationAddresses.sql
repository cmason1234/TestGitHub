USE rheem;

DROP PROCEDURE IF Exists WAPI__GetOrganizationAddresses__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetOrganizationAddresses__Get(
    -- Add the parameters for the stored procedure here
    IN p_OrgID varchar(50))

  BEGIN	 
	SELECT a.AddressLine1, a.AddressLine2, 
		a.City, a.State, a.PostalCode, a.Country
	  FROM ru_organization o
		INNER JOIN ru_organizationaddress oa on o.OrganizationID=oa.OrganizationID
		INNER JOIN ru_address a ON oa.AddressID = a.AddressID
      WHERE o.OrganizationID = p_OrgID;

END$$
DELIMITER ;

