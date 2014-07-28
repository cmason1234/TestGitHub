USE rheem;

DROP PROCEDURE IF Exists WAPI__ComponentNumber__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ComponentNumber__Get(
    IN p_componentnumber varchar(50))
BEGIN

	select ComponentNumber, ComponentDescription, ComponentLength,
	   ComponentWidth, ComponentHeight, ComponentWeight, Replacement from ru_parts_component
	where ComponentNumber = p_componentNumber;

END$$
DELIMITER ;


