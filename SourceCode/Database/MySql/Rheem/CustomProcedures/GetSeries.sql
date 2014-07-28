USE rheem;

DROP PROCEDURE IF Exists GetSeries;

DELIMITER $$
CREATE PROCEDURE GetSeries (
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
	FROM rheem.rdb_brand b
	INNER JOIN rheem.ru_productgroup pg ON pg.BrandID=b.BrandID
	where (LENGTH(brandIDparam) = 0 OR b.BrandID=brandIDparam) and
	      (LENGTH(prodCatIDparam) = 0 OR pg.ProductCategoryID=prodCatIDparam) and
	      (LENGTH(pgIDparam) = 0 OR pg.ProductGroupID=pgIDparam);

END$$
DELIMITER ;

