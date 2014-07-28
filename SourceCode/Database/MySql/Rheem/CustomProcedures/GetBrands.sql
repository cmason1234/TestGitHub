USE rheem;

DROP PROCEDURE IF Exists GetBrands;

DELIMITER $$
CREATE PROCEDURE GetBrands(
    IN brandIDparam varchar(64))
BEGIN

	SELECT b.BrandName, b.BrandID 
	FROM rheem.rdb_brand b
	WHERE (LENGTH(brandIDparam) = 0 OR b.BrandID = brandIDparam);

END$$
DELIMITER ;
