Use rheem;

CREATE TABLE IF NOT EXISTS ru_modelwarrantyrule(
	ModelWarrantyRuleID varchar(64) NOT NULL,
	ProductID varchar(64) NOT NULL,
	RuleMessage varchar(1500) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ModelWarrantyRuleID)
);