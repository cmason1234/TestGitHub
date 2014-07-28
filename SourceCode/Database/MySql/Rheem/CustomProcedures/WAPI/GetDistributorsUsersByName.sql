USE rheem;

DROP PROCEDURE IF Exists WAPI__GetDistributorsUsersByName__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetDistributorsUsersByName__Get(
    -- Add the parameters for the stored procedure here
    IN p_OrgName varchar(50),
	IN p_OrgID varchar(50))

  BEGIN	 
	SELECT o.OrganizationName as DistributorName, o.OrganizationID, 
	    p.PersonID, p.FirstName, p.LastName, p.EmailAddress
	  FROM ru_organization o
		INNER JOIN ru_distributororganization  do ON do.OrganizationID = o.OrganizationID 
				AND (do.Disabled is null or do.Disabled = 0)
		INNER JOIN ru_address a ON do.primaryaddressID = a.AddressID
		INNER JOIN ru_personorganization po on o.OrganizationID=po.OrganizationID
		INNER JOIN ru_person p on po.PersonID=p.PersonID
      WHERE  (LENGTH(p_OrgName) = 0 OR o.OrganizationName LIKE p_OrgName) AND
		 (LENGTH(p_OrgID) = 0 or o.OrganizationID = p_OrgID)				
      ORDER BY o.OrganizationName, p.LastName;

END$$
DELIMITER ;

