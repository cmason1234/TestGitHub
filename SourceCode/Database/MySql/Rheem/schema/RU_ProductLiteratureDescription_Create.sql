Use rheem;

CREATE TABLE IF NOT EXISTS ru_productliteraturedescription(
	ProductLiteratureDescriptionID varchar(64) NOT NULL,
	ProductID varchar(64) NULL,
	SeqNumber int NULL,
	Description varchar(1024) NULL,
	BriefDescription bit NOT NULL,
	WarrantyDescription bit NOT NULL,
	FullDescription bit NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductLiteratureDescriptionID)
);


call CreateIndexIfNotExists(NULL, 'prodlitdesc_idx1', 'ru_productliteraturedescription', 'ProductID', NULL);

