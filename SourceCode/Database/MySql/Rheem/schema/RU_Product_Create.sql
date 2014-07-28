Use rheem;

CREATE TABLE IF NOT EXISTS ru_product(
	ProductID varchar(64) NOT NULL,
	Model varchar(50) NOT NULL,
	MetaTitle varchar(50) NULL,
	MetaDescription varchar(512) NULL,
	BrandID varchar(64) NULL,
	ProductCategoryID varchar(64) NULL,
	DivisionID varchar(64) NULL,
	Commercial bit NOT NULL,
	Residential bit NOT NULL,
	Disabled bit NOT NULL,
	CountryID varchar(64) NOT NULL,
	HeroTitle varchar(150) NULL,
	HeroSubTitle varchar(150) NULL,
	ProductInformation text NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	AvailableForLiterature bit NOT NULL,
	UseModelPage bit NOT NULL,
	ProductLiteratureDirty bit NOT NULL,
	InternationalBit bit NOT NULL,
    PRIMARY KEY (ProductID)
);

call CreateIndexIfNotExists(null, 'product_idx1', 'ru_product', 'BrandID', null);
call CreateIndexIfNotExists(null, 'product_idx1', 'ru_product', 'ProductCategoryID', null);
