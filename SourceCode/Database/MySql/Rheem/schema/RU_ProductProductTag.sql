Use rheem;

CREATE TABLE IF NOT EXISTS ru_productproducttag(
	ProductProductTagID varchar(64) NOT NULL,
	ProductTagID varchar(64) NOT NULL,
	ProductID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ProductProductTagID)
);