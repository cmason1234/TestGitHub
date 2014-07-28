USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_EquipmentAttributeDelete;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_EquipmentAttributeDelete(
    IN EquipmentIDparam INT)
BEGIN

    DELETE
    FROM rheem_eco.equipmentattribute
    WHERE EquipmentID = EquipmentIDparam;

END$$
DELIMITER ;
