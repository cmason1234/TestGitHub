USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_HomeowneraddressesGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_HomeowneraddressesGet(
    IN apiKey varchar(50),
    IN eco_homeowneraddressIDparam varchar(50))
BEGIN

    SELECT HomeowneraddressID,
           HomeOwnerID,
           AddressType,
           Address1,
           Address2,
           City,
           State,
           PostalCode,
           Country,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.homeowneraddress
    WHERE (LENGTH(eco_homeowneraddressIDparam) = 0 OR HomeOwnerAddressID = eco_homeowneraddressIDparam);

END$$
DELIMITER ;
