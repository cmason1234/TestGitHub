USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_ProductalarmsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_ProductalarmsGet(
    IN apiKey varchar(50),
    IN eco_productalarmIDparam varchar(50))
BEGIN

    SELECT ProductalarmID,
           ProductID,
           AlarmName,
           AlarmType,
           AlarmShortDesc,
           AlarmLongDesc,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.productalarm
    WHERE (LENGTH(eco_productalarmIDparam) = 0 OR ProductAlarmID = eco_productalarmIDparam);

END$$
DELIMITER ;
