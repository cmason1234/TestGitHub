USE rheem;

DROP PROCEDURE IF Exists WAPI__ProductImages__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ProductImages__Get(
    IN p_ProductID varchar(64))
BEGIN

	select 
		concat('http://www.globalimageserver.com/getimage.aspx?maxw=500&maxh=600&id=', pd.DocumentID)
		as ProductImageURL, null as CloudBucket, Null as CloudFileName, 500 as Width, 600 as Height
	 from p_productdocument pd
	   INNER JOIN ru_product p on pd.ProductID=p.ProductID
	 where p.ProductID=p_ProductID AND PairingType = 'Web Product Image'
    UNION
    SELECT null as ProductImageURL, a.CloudBucket, a.CloudFileName, b.Width, b.Height
      FROM ru_clouddocument a
        LEFT OUTER JOIN ru_cloudimage b ON b.CloudDocumentID=a.CloudDocumentID
      WHERE a.IsImage=1 and a.ObjectID=p_ProductID;
END$$
DELIMITER ;
