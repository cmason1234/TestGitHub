USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_HomeownerorderhistoriesGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_HomeownerorderhistoriesGet(
    IN apiKey varchar(50),
    IN eco_homeownerorderhistoryIDparam varchar(50))
BEGIN

    SELECT HomeownerorderhistoryID,
           HomeOwnerOrderID,
           OrderStatus,
           OrderNote,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.homeownerorderhistory
    WHERE (LENGTH(eco_homeownerorderhistoryIDparam) = 0 OR HomeOwnerOrderHistoryID = eco_homeownerorderhistoryIDparam);

END$$
DELIMITER ;
