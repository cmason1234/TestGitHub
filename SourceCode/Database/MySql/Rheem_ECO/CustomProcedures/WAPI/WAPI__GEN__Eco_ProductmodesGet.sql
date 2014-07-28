USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_ProductmodesGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_ProductmodesGet(
    IN apiKey varchar(50),
    IN eco_productmodeIDparam varchar(50))
BEGIN

    SELECT ProductmodeID,
           ProductID,
           Mode,
           ModeShortDesc,
           ModeLongDesc,
           TempMin,
           TempMax,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.productmode
    WHERE (LENGTH(eco_productmodeIDparam) = 0 OR ProductModeID = eco_productmodeIDparam);

END$$
DELIMITER ;
