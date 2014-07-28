Use rheem;

CREATE TABLE IF NOT EXISTS ru_productgroup(
	ProductGroupID varchar(64) NOT NULL,
	GroupName varchar(256) NULL,
	GroupSpecificationHTML text NULL,
	GroupFeaturesHTML text NULL,
	AC bit NULL,
	WH bit NULL,
	GroupWarrantyHTML text NULL,
	ProductCategoryID varchar(64) NULL,
	SequenceNumber int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	BrandID varchar(64) NULL,
	UseModelPage bit NOT NULL,
	MetaTitle varchar(150) NULL,
	MetaDescription varchar(512) NULL,
	DivisionID varchar(64) NULL,
	HeroTitle varchar(150) NULL,
	HeroSubTitle varchar(150) NULL,
	ProductGroupInformation text NULL,
    PRIMARY KEY (ProductGroupID)
/*	,CONSTRAINT FK_ProductGroup_ProductCategoryID FOREIGN KEY (ProductCategoryID)
	  REFERENCES RU_ProductCategory (ProductCategoryID) ON DELETE CASCADE  */
);

call CreateIndexIfNotExists(null, 'productgroup_idx1', 'ru_productgroup', 'ProductCategoryID', null);
