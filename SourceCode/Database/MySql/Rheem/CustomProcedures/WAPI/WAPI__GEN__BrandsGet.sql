USE rheem;

DROP PROCEDURE IF Exists WAPI__GEN__BrandsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__BrandsGet(
    IN apiKey varchar(50),
    IN brandIDparam varchar(50))
BEGIN

	SELECT b.BrandName, b.BrandID 
	FROM rheem.ru_apiaccesskey apik, rheem.ru_organizationbrand ob, rheem.rdb_brand b
	WHERE (LENGTH(brandIDparam) = 0 OR b.BrandID = brandIDparam) and
	      apik.AccessKey = apiKey and 
          apik.KeyOwner = ob.OrganizationID and 
          ob.BrandID = b.BrandID;

END$$
DELIMITER ;
