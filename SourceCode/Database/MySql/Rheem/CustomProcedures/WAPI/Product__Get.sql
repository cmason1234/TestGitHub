USE rheem;

DROP PROCEDURE IF Exists WAPI__Product__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__Product__Get(
    IN brandNm varchar(200),
    IN catNm varchar(200),
    IN groupName varchar(200),
    IN cntryNm varchar(200),
    IN brndID varchar(64),
    IN prodCatID varchar(64),
    IN prodGrpID varchar(64),
    IN prodID varchar(64),
	IN p_model varchar(50),
	IN p_AvailForLit bit,
	IN p_EcoNetEnabled bit,
	IN p_Disabled bit
)
BEGIN

	SELECT p.ProductID, p.Model
       ,c.Country ,p.HeroTitle ,p.HeroSubTitle ,p.ProductInformation
       ,b.BrandName ,pc.CategoryName ,pg.GroupName, pl.SeqNumber
       ,pl.BriefDescription
       ,case p.Residential when 1 then 'true' Else 'false' END as Residential
       ,case p.Commercial  when 1 then 'true' Else 'false' END as Commercial
       ,case p.AvailableForLiterature when 1 then 'true' Else 'false' END as AvailableForLiterature
       ,case p.Disabled when 1 then 'true' Else 'false' END as Disabled
       ,case p.UseModelPage when 1 then 'true' Else 'false' END as UseModelPage
       ,case p.InternationalBit when 1 then 'true' Else 'false' END as IsInternational
       ,case p.EcoNetEnabled when 1 then 'true' Else 'false' End as IsEcoNetEnabled
	   ,pg.GroupSpecificationHTML
	   ,p.ProductCopy
	   ,p.WarrantyText
	   ,p.PTSURL
	  from ru_product p
		INNER JOIN rdb_brand b ON b.BrandID=p.BrandID
		INNER JOIN ru_productcategory pc ON pc.ProductCategoryID=p.ProductCategoryID
		INNER JOIN ru_country c ON c.CountryID=p.CountryID
		LEFT OUTER JOIN ru_productliterature pl on p.ProductID=pl.ProductID
		LEFT OUTER JOIN ru_productproductgroup ppg ON ppg.ProductID=p.ProductID
		LEFT OUTER JOIN ru_productgroup pg ON pg.ProductGroupID=ppg.ProductGroupID
	WHERE (LENGTH(brandNm)=0 OR b.BrandName like brandNm) and
		  (LENGTH(catNm)=0 OR pc.CategoryName like catNm) and
		  (LENGTH(groupName)=0 OR pg.GroupName like groupName) and
		  (LENGTH(cntryNm)=0 OR c.Country like cntryNm) and
		  (LENGTH(brndID)=0 OR b.BrandID=brndID) and
		  (LENGTH(prodCatID)=0 OR pc.ProductCategoryID=prodCatID) and
		  (LENGTH(prodID)=0 OR p.ProductID=prodID) and
		  (LENGTH(prodGrpID)=0 OR pg.ProductGroupID=prodGrpID) AND
		  (LENGTH(p_Model)= 0 or p.Model like p_Model) AND
		  (p_AvailForLit = 0 OR p.AvailableForLiterature = 1) AND
  		  (p_AvailForLit = 0 OR pl.ProductLiteratureID is NOT NULL) AND
		  (p_EcoNetEnabled = 0 or p.EcoNetEnabled = 1) AND
		  (p_Disabled = 1 OR p.Disabled = 0)
	ORDER BY pc.CategoryName, p.Residential, p.Commercial, pl.SeqNumber, p.Model;

END$$
DELIMITER ;

