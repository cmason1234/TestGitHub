USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_WhequipmentsettinghistoriesGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_WhequipmentsettinghistoriesGet(
    IN apiKey varchar(50),
    IN eco_whequipmentsettinghistoryIDparam varchar(50))
BEGIN

    SELECT WhequipmentsettinghistoryID,
           WhEquipmentSettingID,
           ProductStatusID,
           ProductModeID,
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
    FROM rheem_eco.whequipmentsettinghistory
    WHERE (LENGTH(eco_whequipmentsettinghistoryIDparam) = 0 OR WhEquipmentSettingHistoryID = eco_whequipmentsettinghistoryIDparam);

END$$
DELIMITER ;
