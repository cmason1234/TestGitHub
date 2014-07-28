USE rheem;

DROP PROCEDURE IF Exists GetProductTags;

DELIMITER $$
CREATE PROCEDURE GetProductTags(
    IN productIDparam varchar(64))
BEGIN

	SELECT distinct pt.ProductTagID, pt.Label, pt.TagOrder, pt.ParentProductTagID, pt.LogoURL, pt.Name, pt.Description
	FROM rheem.ru_producttag pt
	LEFT OUTER JOIN rheem.ru_productproducttag ppt ON pt.ProductTagID=ppt.ProductTagID
	WHERE (LENGTH(productIDparam) = 0 OR ppt.ProductID = productIDparam);

END$$
DELIMITER ;