USE rheem;

DROP PROCEDURE IF Exists WAPI__GetProductsByAHRIModelAndBrand;

DELIMITER $$
CREATE PROCEDURE WAPI__GetProductsByAHRIModelAndBrand(
    IN p_ahrimodel varchar(255),
    IN p_brandname varchar(255))
BEGIN

	SELECT pm.RPS_Model, pm.ProductID, b.BrandID, pd1.DocumentID As ConsumerLiteratureDocumentID, pd2.DocumentID As ImageDocumentID, p.ProductCopy from rheem.ru_productmodel pm
	INNER JOIN rheem.ru_product p ON pm.ProductID=p.ProductID
	INNER JOIN rheem.rdb_brand b ON b.BrandID=p.BrandID
	LEFT OUTER JOIN rheem.p_productdocument pd1 ON pd1.ProductID=p.ProductID and pd1.PairingType ='Consumer Literature'
	LEFT OUTER JOIN rheem.p_productdocument pd2 ON pd2.ProductID=p.ProductID and pd2.PairingType = 'Web Product Image'
	WHERE RPS_Model like concat(p_ahrimodel, '%') and b.BrandName=p_brandname;


END$$
DELIMITER ;

