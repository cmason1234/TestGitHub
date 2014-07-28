USE rheem;

DROP PROCEDURE IF Exists WAPI__SeriesByAPIKey__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__SeriesByAPIKey__Get (
    IN apiKeyparam varchar(64),
	IN pgIDparam varchar(64),
	IN brandIDparam varchar(64),
	IN prodCatIDparam varchar(64))
BEGIN

	SELECT pg.ProductGroupID, 
		   pg.GroupName,
		   pg.GroupSpecificationHTML,
		   pg.GroupFeaturesHTML, 
		   pg.AC, 
		   pg.WH, 
		   pg.GroupWarrantyHTML, 
		   pg.ProductCategoryID, 
		   pg.BrandID,
		   b.BrandName
	FROM rheem.ru_apiaccesskey apik
	INNER JOIN rheem.ru_organizationbrand ob ON ob.OrganizationID=apik.KeyOwner
	INNER JOIN rheem.rdb_brand b ON b.BrandID=ob.BrandID
	INNER JOIN rheem.ru_productgroup pg ON pg.BrandID=b.BrandID
	where apik.AccessKey = apiKeyparam and
	      (LENGTH(brandIDparam) = 0 OR b.BrandID=brandIDparam) and
	      (LENGTH(prodCatIDparam) = 0 OR pg.ProductCategoryID=prodCatIDparam) and
	      (LENGTH(pgIDparam) = 0 OR pg.ProductGroupID=pgIDparam);

END$$
DELIMITER ;

