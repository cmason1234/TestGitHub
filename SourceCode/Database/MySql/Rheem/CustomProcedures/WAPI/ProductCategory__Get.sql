USE rheem;

DROP PROCEDURE IF Exists WAPI__ProductCategory__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ProductCategory__Get(
	IN CategoryNm varchar(200),
	IN ProductCatID varchar(64))
BEGIN

    SELECT ProductCategoryID, CategoryName
	FROM ru_productcategory
	WHERE (LENGTH(CategoryNm) = 0 OR CategoryName like CategoryNm) and
          (LENGTH(ProductCatID) = 0 OR ProductCatID=ProductCategoryID)
	ORDER BY CategoryName;

END$$
DELIMITER ;

