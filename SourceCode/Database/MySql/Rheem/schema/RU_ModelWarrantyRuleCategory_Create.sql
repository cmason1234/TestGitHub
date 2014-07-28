Use rheem;

CREATE TABLE IF NOT EXISTS ru_modelwarrantyrulecategory(
	ModelWarrantyRuleCategoryID varchar(64) NOT NULL,
	ModelWarrantyRuleID varchar(64) NOT NULL,
	ProductCategoryID varchar(64) NOT NULL,
	CategoryName varchar(150) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ModelWarrantyRuleCategoryID)
);