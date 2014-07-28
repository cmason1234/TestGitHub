USE rheem;

DROP PROCEDURE IF Exists GetAllKeys;

DELIMITER $$
CREATE PROCEDURE GetAllKeys (
     in p_PersonID varchar(64)
  )
BEGIN
    Call LoadMyOrganizations(p_PersonID);

	SELECT ak.AccessKey, ak.Active, o.OrganizationName, ak.CreateDateTime__Gen
	FROM ru_myorganizations mo 
      INNER JOIN ru_apiaccesskey ak ON mo.OrganizationID = ak.KeyOwner
	  INNER JOIN ru_organization o ON mo.OrganizationID = o.OrganizationID
	WHERE mo.PersonID = p_PersonID
	ORDER BY o.OrganizationName, ak.CreateDateTime__Gen DESC;

END$$
DELIMITER ;


