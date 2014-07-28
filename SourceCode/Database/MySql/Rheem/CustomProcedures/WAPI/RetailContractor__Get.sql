USE rheem;

DROP PROCEDURE IF Exists WAPI__RetailContractor__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__RetailContractor__Get(
    IN personIDparam varchar(64))
BEGIN

	Call LoadMyOrganizations(personIDparam);

	SELECT cr.HDVendorNumber,
	       o.OrganizationID,
		   o.OrganizationName,
		   o.Phone,
		   a.AddressLine1, 
		   a.AddressLine2, 
		   a.City, 
		   a.State, 
		   a.PostalCode, 
		   a.Country
	FROM rheem.ru_contractorretail cr
		INNER JOIN rheem.ru_myorganizations mo ON mo.OrganizationID=cr.OrganizationID and mo.PersonID=personIDparam
		INNER JOIN rheem.ru_organization o ON o.OrganizationID=cr.OrganizationID
		INNER JOIN rheem.ru_address a ON a.AddressID=o.PrimaryAddressID
	WHERE cr.HDVendorNumber IS NOT NULL order by o.OrganizationName;

END$$
DELIMITER ;

