USE rheem;

DROP PROCEDURE IF Exists GetProductLiteratureDescriptions;

DELIMITER $$
CREATE PROCEDURE GetProductLiteratureDescriptions(
    IN prodID varchar(64),
	IN brandNm varchar(64),
    IN brandID varchar(64)
)
BEGIN

	SELECT pld.ProductID, pld.SeqNumber, pld.Description
       ,case pld.BriefDescription when 1 then 'true' Else 'false' END as BriefDescription
       ,case pld.WarrantyDescription  when 1 then 'true' Else 'false' END as WarrantyDescription
       ,case pld.FullDescription when 1 then 'true' Else 'false' END as FullDescription
	  from ru_productliteraturedescription pld
	    INNER JOIN ru_product p on pld.ProductID = p.ProductID AND
		             p.AvailableForLiterature = 1 and p.Disabled = 0
		INNER JOIN rdb_brand b ON b.BrandID=p.BrandID
		INNER JOIN ru_productliterature pl on p.ProductID=pl.ProductID
	WHERE (LENGTH(brandNm)=0 OR b.BrandName like brandNm) and
		  (LENGTH(brandID)=0 OR b.BrandID=brandID) and
		  (LENGTH(prodID)=0 or pld.ProductID=prodID)
	ORDER BY pld.ProductID, pld.briefdescription desc, pld.WarrantyDescription desc, pld.FullDescription desc, pld.SeqNumber;

END$$
DELIMITER ;
