USE rheem;

DROP PROCEDURE IF Exists GetAdMakerImages;

DELIMITER $$
CREATE PROCEDURE GetAdMakerImages (
	IN amiName varchar(50),
	IN amiType varchar(50),
	IN brandName varchar(250),
	IN amiPageSize varchar(50),
	IN amiAssetCategory varchar(50),
    IN amiHorizVert varchar(1),
	IN amiBlackWhite bit,
	IN amiDisabled bit)
BEGIN

	SELECT ami.AdMakerImageID, 
		   ami.Name,
		   ami.ImageType, 
		   ami.ImageUrl, 
		   ami.PageSize, 
		   ami.AssetCategory, 
		   ami.BlackWhite, 
		   ami.Disabled, 
		   ami.BrandID,
           ami.HorizVert,
		   b.BrandName
	FROM rheem.ru_admakerimage ami
	INNER JOIN rheem.rdb_brand b ON b.BrandID=ami.BrandID
	where (LENGTH(amiName) = 0 OR ami.Name like amiName) and
		  (LENGTH(amiType) = 0 OR ami.ImageType like amiType) and
	      (LENGTH(brandName) = 0 OR b.BrandName like brandName) and
		  (LENGTH(amiPageSize) = 0 OR ami.PageSize like amiPageSize) and
		  (LENGTH(amiAssetCategory) = 0 OR ami.AssetCategory like amiAssetCategory) and
          (LENGTH(amiHorizVert) = 0 or ami.HorizVert = amiHorizVert or ami.HorizVert = 'X') and
		  (amiBlackWhite = 1 OR ami.BlackWhite=0) and
		  (amiDisabled = 1 OR ami.Disabled=0)
         ORDER BY ami.AssetCategory, ami.Name;

END$$
DELIMITER ;
