USE rheem;


DROP PROCEDURE If Exists WAPI__ProductGroup__Get;

DELIMITER $$
CREATE PROCEDURE WAPI__ProductGroup__Get(
    -- Add the parameters for the stored procedure here
	IN GrpNm varchar(200),
	IN BrndNm varchar(200),
    IN BrndID varchar(64),
    IN ProdCatID varchar(64))
BEGIN

    SELECT pg.ProductGroupID, pg.GroupName,  pc.CategoryName, b.BrandName, pg.BrandId, 
           cd.DocumentTypeID, dt.TypeName, pg.ProductCategoryID FROM RU_ProductGroup pg 
       LEFT OUTER JOIN ru_productcategory pc ON pg.ProductCategoryID = pc.ProductCategoryID 
       LEFT OUTER JOIN rdb_brand b ON pg.brandID = b.BrandID 
       LEFT OUTER JOIN ru_clouddocument cd ON pg.ProductGroupID=cd.ObjectID and cd.FriendlyName='Master Image'
       LEFT OUTER JOIN ru_documenttype dt ON cd.DocumentTypeID=dt.DocumentTypeID
	  WHERE 
	     (LENGTH(GrpNm)=0 or pg.GroupName like GrpNm) AND
	     (LENGTH(BrndNm)=0 or b.BrandName like BrndNm) AND
	     (LENGTH(BrndID)=0 OR pg.BrandID=BrndID) AND
         (LENGTH(ProdCatID)=0 OR pg.ProductCategoryID=ProdCatID)
	  order by pg.GroupName;

END$$
DELIMITER ;

