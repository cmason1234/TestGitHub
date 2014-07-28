USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_ProductstatusesGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_ProductstatusesGet(
    IN apiKey varchar(50),
    IN eco_productstatusIDparam varchar(50))
BEGIN

    SELECT ProductstatusID,
           ProductID,
           ProductStatus,
           ProductStatusShortDesc,
           ProductStatusLongDesc,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.productstatus
    WHERE (LENGTH(eco_productstatusIDparam) = 0 OR ProductStatusID = eco_productstatusIDparam);

END$$
DELIMITER ;
