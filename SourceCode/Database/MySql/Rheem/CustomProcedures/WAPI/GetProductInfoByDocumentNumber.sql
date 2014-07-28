USE rheem;

DROP PROCEDURE IF Exists GetProductInfoByDocumentNumber;

DELIMITER $$
CREATE PROCEDURE GetProductInfoByDocumentNumber(
    -- Add the parameters for the stored procedure here
    IN p_DocumentNumber varchar(50))

  BEGIN

    drop TEMPORARY table if exists TempProdID0;
    drop TEMPORARY table if exists TempProdID1;
    drop TEMPORARY table if exists TempProdID2;
    drop TEMPORARY table if exists TempProdID3;

	create TEMPORARY table IF NOT EXISTS TempProdID0 (
	    ProductID varchar(50)
	);	
	
	create TEMPORARY table IF NOT EXISTS TempProdID1 (
	    ProductID varchar(50),
		Model Varchar(50),
		ProductCategoryID varchar(50),
		BrandID varchar(50), 
		BrandName varchar(100),
		GroupName varchar(150)
	);

	create TEMPORARY table IF NOT EXISTS TempProdID2 (
	    ProductID varchar(50),
		Model Varchar(50),
		ProductCategoryID varchar(50),
		BrandID varchar(50), 
		BrandName varchar(100),
		GroupName varchar(150)
	);

	create TEMPORARY table IF NOT EXISTS TempProdID3 (
	    ProductID varchar(50),
		Model Varchar(50),
		ProductCategoryID varchar(50),
		BrandID varchar(50), 
		BrandName varchar(100),
		GroupName varchar(150)
	);

	insert into TempProdID0
	  select distinct coalesce(p.ReplacementProductID, p.ProductID)
	    from rcn_document d
		  INNER JOIN p_productdocument pd ON d.DocumentID = pd.DocumentID
		  INNER JOIN ru_product p ON pd.ProductID = p.ProductID 
        where d.DocumentNumber = p_DocumentNumber;	
	
	insert into TempProdID1
	  select  distinct coalesce(p.ReplacementProductID, p.ProductID), p.Model, p.ProductCategoryID, p.BrandID, b.BrandName, GroupName
	    from TempProdID0 ID0
		  INNER JOIN ru_product p ON ID0.ProductID = p.ProductID 
		   INNER JOIN ru_productproductgroup ppg ON p.ProductID = ppg.ProductID 
		   INNER JOIN ru_productgroup pg ON ppg.ProductGroupID = pg.ProductGroupID
		   INNER JOIN rdb_brand b ON b.BrandId=p.BrandID;

	insert into TempProdID2 (select * from TempProdID1);
	insert into TempProdID3 (select * from TempProdID1);

	select 'fetchDocumentURL' As URLType,
		   d.DocumentID,
		   pd.DocumentTitle,
		   d.DocumentTitle As RCNDocumentTitle,
		   tpd1.Model,
		   tpd1.BrandName,
		   'NOT USED' As CategoryName,
		   'NOT USED' As GroupName,
		   'NOT USED' As ProductID
	from TempProdID1 tpd1
	    INNER JOIN p_productdocument pd ON pd.productId = tpd1.ProductID AND pd.PairingType like 'Specifi%sheet%'
        INNER JOIN rcn_document d on d.DocumentID=pd.DocumentID
	union
	select 'imageURL' As URLType,
	       pd.DocumentID,
		   'NOT USED' As DocumentTitle,
		   'NOT USED' As RCNDocumentTitle,
		   'NOT USED' As Model,
           tpd2.BrandName,
		   'NOT USED' As CategoryName,
		   'NOT USED' As GroupName,
		   'NOT USED' As ProductID
	from p_productdocument pd
	    INNER JOIN TempProdID2 tpd2 on pd.ProductID=tpd2.ProductID
	where PairingType = 'Web Product Image'
	union
	select 'productURL' As URLType,
		   'NOT USED' As DocumentID,
		   'NOT USED' As DocumentTitle,
		   'NOT USED' As RCNDocumentTitle,
		   'NOT USED' As Model,
		   tpd3.BrandName,
	       CategoryName,
		   tpd3.GroupName,
		   tpd3.ProductID
	FROM  TempProdID3 tpd3
	    INNER JOIN ru_productcategory pc ON tpd3.ProductCategoryID = pc.ProductCategoryID;

END$$
DELIMITER ;

