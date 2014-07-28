USE rheem;

DROP PROCEDURE IF Exists GetMenus;

DELIMITER $$
CREATE PROCEDURE GetMenus(
    IN parentIDparam varchar(64))
BEGIN

	SELECT m.MenuID, m.MenuType, m.Label, m.URL, m.Target, m.MenuOrder, m.ParentID
	FROM rheem.ru_menu m
	WHERE (LENGTH(parentIDparam) = 0 OR m.ParentID = parentIDparam);

END$$
DELIMITER ;
