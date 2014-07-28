USE rheem;

DROP PROCEDURE IF Exists WAPI__GEN__ProductgroupsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__ProductgroupsGet(
    IN apiKey varchar(50),
    IN productgroupIDparam varchar(50))
BEGIN

    SELECT ProductgroupID,
           GroupName,
           GroupSpecificationHTML,
           GroupFeaturesHTML,
           AC,
           WH,
           GroupWarrantyHTML,
           ProductCategoryID,
           SequenceNumber,
           CreateDateTime__Gen,
           UpdateDateTime__Gen,
           BrandID,
           UseModelPage,
           MetaTitle,
           MetaDescription,
           DivisionID,
           HeroTitle,
           HeroSubTitle,
           ProductGroupInformation
    FROM rheem.ru_productgroup
    WHERE (LENGTH(productgroupIDparam) = 0 OR ProductgroupID = productgroupIDparam);

END$$
DELIMITER ;
