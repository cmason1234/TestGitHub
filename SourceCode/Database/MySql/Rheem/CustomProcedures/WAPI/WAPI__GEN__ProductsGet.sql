USE rheem;

DROP PROCEDURE IF Exists WAPI__GEN__ProductsGet;

DELIMITER $$
CREATE PROCEDURE WAPI__GEN__ProductsGet(
    IN apiKey varchar(50),
    IN productIDparam varchar(50))
BEGIN

    SELECT ProductID,
           Model,
           MetaTitle,
           MetaDescription,
           BrandID,
           ProductCategoryID,
           DivisionID,
           Commercial,
           Residential,
           Disabled,
           CountryID,
           HeroTitle,
           HeroSubTitle,
           ProductInformation,
           CreateDateTime__Gen,
           UpdateDateTime__Gen,
           AvailableForLiterature,
           UseModelPage,
           ProductLiteratureDirty,
           InternationalBit,
           WarrantyRegistrationBit,
           WarrantyRegistrationInstallationTime,
           ProClubPoints,
           SeriesID
    FROM rheem.ru_product
    WHERE (LENGTH(productIDparam) = 0 OR ProductID = productIDparam);

END$$
DELIMITER ;
