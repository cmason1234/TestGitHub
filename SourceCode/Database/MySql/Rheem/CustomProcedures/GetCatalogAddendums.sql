USE rheem;

DROP PROCEDURE IF Exists GetCatalogAddendums;

DELIMITER $$
CREATE PROCEDURE GetCatalogAddendums (
	IN caName varchar(50),
	IN brandName varchar(256))
BEGIN

	SELECT ca.CatalogAddendumID, 
		   ca.BrandID,
		   b.BrandName,
		   ca.Disabled, 
		   ca.FileUrl, 
		   ca.Name
	FROM rheem.ru_catalogaddendum ca
	INNER JOIN rheem.rdb_brand b ON b.BrandID=ca.BrandID
	where (LENGTH(caName) = 0 OR ca.Name like caName) and
	      (LENGTH(brandName) = 0 OR b.BrandName like brandName);

END$$
DELIMITER ;
