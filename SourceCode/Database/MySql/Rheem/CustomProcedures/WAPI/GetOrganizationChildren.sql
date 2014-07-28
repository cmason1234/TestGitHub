USE rheem;

DROP PROCEDURE IF Exists WAPI__GetOrganizationChildren__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetOrganizationChildren__Get(
    -- Add the parameters for the stored procedure here
    IN p_OrgID varchar(50),
	IN p_OrgType varchar(256)
	)

  BEGIN	 
	SELECT o.OrganizationName, o.OrganizationID
	  FROM ru_organization o
	  INNER JOIN ru_organizationparent op ON op.organizationid = o.organizationid AND
	      op.ParentOrganizationID = p_OrgID
		WHERE (LENGTH(p_OrgType) = 0 OR o.OrganizationType = p_OrgType)
	  ORDER BY o.OrganizationName;

END$$
DELIMITER ;

