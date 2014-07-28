Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorgeneratorbrands(
	ContractorGeneratorBrandID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	BrandID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ContractorGeneratorBrandID)
);
