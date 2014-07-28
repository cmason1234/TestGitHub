USE rheem;

DROP PROCEDURE IF Exists WAPI__ProductDocuments__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ProductDocuments__Get(
    IN p_ProductID varchar(64))
BEGIN
	select 
		d.documentID, p.BrandID, 
		p.Model, d.documentTitle as rcnDocumentTitle, 
		pd.DocumentTitle as ProductDocumentTitle, pd.MimeType
	from ru_product p
	  INNER JOIN p_productdocument pd ON pd.productId = p.ProductID
	  INNER JOIN rcn_document d on d.DocumentID=pd.DocumentID
	 where p.ProductID=p_ProductID;

END$$
DELIMITER ;
