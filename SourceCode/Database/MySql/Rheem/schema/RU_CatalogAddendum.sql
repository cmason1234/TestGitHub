Use rheem;

CREATE TABLE IF NOT EXISTS ru_catalogaddendum(
	CatalogAddendumID varchar(64) NOT NULL,
	BrandID varchar(64) NOT NULL,
	Name varchar(50) NULL,
	FileUrl varchar(255) NULL,
	Disabled bit NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (CatalogAddendumID)
);

call CreateIndexIfNotExists(NULL, 'catadd_idx1', 'ru_catalogaddendum', 'BrandID', NULL);