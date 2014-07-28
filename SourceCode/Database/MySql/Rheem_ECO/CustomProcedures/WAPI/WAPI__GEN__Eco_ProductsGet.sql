USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_ProductsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_ProductsGet(
    IN apiKey varchar(50),
    IN eco_productIDparam varchar(50))
BEGIN

    SELECT ProductID,
           ProductDesc,
           AddressLower,
           AddressUpper,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.product
    WHERE (LENGTH(eco_productIDparam) = 0 OR ProductID = eco_productIDparam);

END$$
DELIMITER ;
