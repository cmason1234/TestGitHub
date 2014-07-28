USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_WhequipmentsettingsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_WhequipmentsettingsGet(
    IN apiKey varchar(50),
    IN eco_whequipmentsettingIDparam varchar(50))
BEGIN

    SELECT WhequipmentsettingID,
           HomeOwnerSystemID,
           EquipmentID,
           ProductModeID,
           ProductStatusID,
           HttpAgent,
           Temperature,
           SetPoint,
           WhEquipmentSettingSource,
           Alarm,
           Alarm_01,
           Alarm_02,
           Alarm_03,
           EquipmentAddress,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.whequipmentsetting
    WHERE (LENGTH(eco_whequipmentsettingIDparam) = 0 OR WhEquipmentSettingID = eco_whequipmentsettingIDparam);

END$$
DELIMITER ;
