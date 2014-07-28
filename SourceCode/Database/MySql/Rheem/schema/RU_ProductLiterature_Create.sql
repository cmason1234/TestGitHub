Use rheem;

CREATE TABLE IF NOT EXISTS ru_productliterature(
	ProductLiteratureID varchar(64) NOT NULL,
	ProductID varchar(64) NULL,
	BriefDescription text NULL,
	Disabled bit NOT NULL,
	SeqNumber int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductLiteratureID)
);

call CreateIndexIfNotExists(NULL, 'prodlit_idx1', 'ru_productliterature', 'ProductID', NULL);