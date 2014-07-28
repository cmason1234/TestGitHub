USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_HomeownersystemsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_HomeownersystemsGet(
    IN apiKey varchar(50),
    IN eco_homeownersystemIDparam varchar(50))
BEGIN

    SELECT HomeownersystemID,
           HomeOwnerID,
           HomeOwnerAddressID,
           SystemName,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.homeownersystem
    WHERE (LENGTH(eco_homeownersystemIDparam) = 0 OR HomeOwnerSystemID = eco_homeownersystemIDparam);

END$$
DELIMITER ;
