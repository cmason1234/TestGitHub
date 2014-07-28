USE rheem_eco;

DROP PROCEDURE IF Exists WAPI__GEN__Eco_HomeownersGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__Eco_HomeownersGet(
    IN apiKey varchar(50),
    IN eco_homeownerIDparam varchar(50))
BEGIN

    SELECT HomeownerID,
           FirstName,
           LastName,
           Email,
           Password,
           PasswordSeed,
           PasswordDate,
           Phone,
           PhoneAlt,
           CreateDateTime__Gen,
           UpdateDateTime__Gen
    FROM rheem_eco.homeowner
    WHERE (LENGTH(eco_homeownerIDparam) = 0 OR HomeOwnerID = eco_homeownerIDparam);

END$$
DELIMITER ;
