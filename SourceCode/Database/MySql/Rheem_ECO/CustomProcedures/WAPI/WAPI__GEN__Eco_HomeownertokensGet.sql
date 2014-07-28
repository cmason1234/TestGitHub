USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_HomeownertokensGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_HomeownertokensGet(
    IN apiKey varchar(50),
    IN eco_homeownertokenIDparam varchar(50))
BEGIN

    SELECT HomeownertokenID,
           HomeOwnerID,
           DeviceToken,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.homeownertoken
    WHERE (LENGTH(eco_homeownertokenIDparam) = 0 OR HomeOwnerTokenID = eco_homeownertokenIDparam);

END$$
DELIMITER ;
