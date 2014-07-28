Use rheem;

CREATE TABLE IF NOT EXISTS ru_organizationbrand(
	OrganizationBrandID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	BrandID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (OrganizationBrandID)
);

call CreateIndexIfNotExists(null, 'orgbrand_idx1', 'ru_organizationbrand', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'orgbrand_idx2', 'ru_organizationbrand', 'BrandID', null);
