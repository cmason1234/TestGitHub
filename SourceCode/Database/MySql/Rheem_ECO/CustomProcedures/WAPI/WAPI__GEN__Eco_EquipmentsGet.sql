USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_EquipmentsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_EquipmentsGet(
    IN apiKey varchar(50),
    IN eco_equipmentIDparam varchar(50))
BEGIN

    SELECT EquipmentID,
           ProductID,
           ModelNumber,
           SerialNumber,
           RegisterDate,
           InstallDate,
           InstallPro,
           InstallType,
           InstallLocation,
           EquipmentName,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.equipment
    WHERE (LENGTH(eco_equipmentIDparam) = 0 OR EquipmentID = eco_equipmentIDparam);

END$$
DELIMITER ;
