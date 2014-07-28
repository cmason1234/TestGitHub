USE rheem;

DROP PROCEDURE IF Exists WAPI__ProductModelsWithModelNumbers__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ProductModelsWithModelNumbers__Get(
    IN brandNm varchar(200),
    IN catNm varchar(200),
	IN p_AvailForLit bit,
	IN p_Disabled bit
)
BEGIN

	SELECT p.ProductID, p.Model
       ,b.BrandName ,pc.CategoryName ,pl.SeqNumber 
       ,pm.RPS_Model ,pm.ProductModelID
       ,case p.Residential when 1 then 'true' Else 'false' END as Residential
       ,case p.Commercial  when 1 then 'true' Else 'false' END as Commercial
       ,case p.AvailableForLiterature when 1 then 'true' Else 'false' END as AvailableForLiterature
       ,case p.Disabled when 1 then 'true' Else 'false' END as Disabled
	  from ru_product p
		INNER JOIN rdb_brand b ON b.BrandID=p.BrandID
		INNER JOIN ru_productcategory pc ON pc.ProductCategoryID=p.ProductCategoryID
		INNER JOIN rheem.ru_productmodel pm ON pm.ProductID=p.ProductID
		LEFT OUTER JOIN ru_productliterature pl on p.ProductID=pl.ProductID
		LEFT OUTER JOIN ru_productproductgroup ppg ON ppg.ProductID=p.ProductID
		LEFT OUTER JOIN ru_productgroup pg ON pg.ProductGroupID=ppg.ProductGroupID
	WHERE (LENGTH(brandNm)=0 OR b.BrandName like brandNm) and
		  (LENGTH(catNm)=0 OR pc.CategoryName like catNm) and
		  (p_AvailForLit = 0 OR p.AvailableForLiterature = 1) AND
  		  (p_AvailForLit = 0 OR pl.ProductLiteratureID is NOT NULL) AND
		  (p_Disabled = 1 OR p.Disabled = 0)
	ORDER BY pc.CategoryName, p.Residential, p.Commercial, pl.SeqNumber, p.Model;

END$$
DELIMITER ;

