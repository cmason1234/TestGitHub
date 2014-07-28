Use rheem;

CREATE TABLE IF NOT EXISTS ru_productproductgroup(
	ProductProductGroupID varchar(64) NOT NULL,
	ProductID varchar(64) NULL,
	ProductGroupID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductProductGroupID)
	-- ,FOREIGN KEY FK_ProductGroup_ProductProductGroup (ProductGroupID)
    --    REFERENCES RU_ProductGroup(ProductGroupID) ON DELETE CASCADE
	-- ,FOREIGN KEY FK_Product_ProductProductGroup (ProductID) REFERENCES
	--    RU_Product(ProductID) ON DELETE CASCADE
);


call CreateIndexIfNotExists(null, 'productproductgroup_idx1', 'ru_productproductgroup', 'ProductID', null);
call CreateIndexIfNotExists(null, 'productproductgroup_idx2', 'ru_productproductgroup', 'ProductGroupID', null);

