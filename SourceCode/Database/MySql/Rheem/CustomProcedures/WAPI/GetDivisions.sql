USE rheem;

DROP PROCEDURE IF Exists WAPI__GetDivisions;

DELIMITER $$
CREATE PROCEDURE WAPI__GetDivisions()
BEGIN

	SELECT o.OrganizationName,o.OrganizationID from rheem.ru_organizationparent op
		INNER JOIN rheem.ru_organization o ON o.OrganizationID=op.OrganizationID
	WHERE op.ParentOrganizationID='35D4E626-4AB7-47E8-8196-0BCE36B30E8C';

END$$
DELIMITER ;