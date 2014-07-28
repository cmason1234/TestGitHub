Use rheem;

CREATE TABLE IF NOT EXISTS ru_modelwarrantyrulemodel(
	ModelWarrantyRuleModelID varchar(64) NOT NULL,
	ModelWarrantyRuleID varchar(64) NOT NULL,
	ProductID varchar(64) NOT NULL,
	Model varchar(150) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ModelWarrantyRuleModelID)
);