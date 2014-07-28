Use rheem;

CREATE TABLE IF NOT EXISTS ru_personbrand(
	PersonBrandID varchar(64) NOT NULL,
	PersonID varchar(64) NOT NULL,
	BrandID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (PersonBrandID)
);

call CreateIndexIfNotExists(null, 'personbrand_idx1', 'ru_personbrand', 'PersonID', null);
call CreateIndexIfNotExists(null, 'personbrand_idx2', 'ru_personbrand', 'BrandID', null);
