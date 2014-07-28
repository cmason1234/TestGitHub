USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_HomeownerordersGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_HomeownerordersGet(
    IN apiKey varchar(50),
    IN eco_homeownerorderIDparam varchar(50))
BEGIN

    SELECT HomeownerorderID,
           HomeOwnerID,
           OrderDate,
           OrderStatus,
           OrderTrackingNum,
           OrderNote,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.homeownerorder
    WHERE (LENGTH(eco_homeownerorderIDparam) = 0 OR HomeOwnerOrderID = eco_homeownerorderIDparam);

END$$
DELIMITER ;
