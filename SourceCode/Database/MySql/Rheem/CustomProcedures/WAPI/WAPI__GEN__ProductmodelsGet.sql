USE rheem;

DROP PROCEDURE IF Exists WAPI__GEN__ProductmodelsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__ProductmodelsGet(
    IN apiKey varchar(50),
    IN productmodelIDparam varchar(50))
BEGIN

    SELECT ProductmodelID,
           ProductID,
           RPS_ID,
           RPS_Model,
           RPS_Voltage,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem.ru_productmodel
    WHERE (LENGTH(productmodelIDparam) = 0 OR ProductmodelID = productmodelIDparam);

END$$
DELIMITER ;
