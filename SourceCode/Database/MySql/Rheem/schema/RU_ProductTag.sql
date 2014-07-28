Use rheem;

CREATE TABLE IF NOT EXISTS ru_producttag(
	ProductTagID varchar(64) NOT NULL,
	Label varchar(250) NULL,
	TagOrder int NULL,
	ParentProductTagID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductTagID)
);