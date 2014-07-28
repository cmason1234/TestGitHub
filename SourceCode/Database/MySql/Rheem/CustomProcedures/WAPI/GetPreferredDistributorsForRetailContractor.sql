USE rheem;

DROP PROCEDURE IF Exists WAPI__GetPreferredDistributorsForRetailContractor;

DELIMITER $$
CREATE PROCEDURE WAPI__GetPreferredDistributorsForRetailContractor(
    -- Add the parameters for the stored procedure here
    IN p_ContractorOrgID varchar(64))

  BEGIN

	SELECT o.OrganizationID,o.OrganizationName,a.AddressLine1,a.AddressLine2,a.City,a.State,a.PostalCode FROM rheem.ru_contractorretailpreferreddistributor crpd
		INNER JOIN rheem.ru_organization o ON o.OrganizationID=crpd.OrganizationIDDistributor
		LEFT OUTER JOIN rheem.ru_address a ON a.AddressID=o.PrimaryAddressID
	WHERE crpd.OrganizationIDContractor=p_ContractorOrgID
	ORDER BY o.OrganizationName;

END$$
DELIMITER ;

