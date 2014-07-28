USE rheem;

DROP PROCEDURE IF Exists WAPI__GetDesignStarRolesForPerson__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__GetDesignStarRolesForPerson__Get(
    IN p_personID varchar(64))
BEGIN

	select pr.PersonID, r.RoleName from ru_application a
	  INNER JOIN ru_applicationrole ar ON ar.ApplicationID = a.ApplicationID 
	  INNER JOIN ru_role r ON ar.RoleID = r.RoleID
	  INNER JOIN ru_personrole pr ON pr.ApplicationRoleID = ar.ApplicationRoleID AND
	                         pr.PersonID = p_personID
     where
        a.ApplicationName ='Design Star' ORDER BY r.RoleName;

END$$
DELIMITER ;


