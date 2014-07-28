USE rheem;

DROP PROCEDURE IF Exists WAPI__GetOrganizationParents__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetOrganizationParents__Get(
    -- Add the parameters for the stored procedure here
    IN p_OrgID varchar(50))

  BEGIN	 
	SELECT o.OrganizationName, o.OrganizationID 
	FROM  ru_organization o
	INNER JOIN ru_organizationparent op ON op.parentorganizationid = o.organizationid
	WHERE op.organizationid = p_OrgID
	ORDER BY o.OrganizationName;

END$$
DELIMITER ;

