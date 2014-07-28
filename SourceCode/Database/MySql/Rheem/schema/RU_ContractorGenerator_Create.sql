Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorgenerator(
	ContractorGeneratorID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	DistributorOrganizationID varchar(64) NULL,
	BrandID varchar(64) NULL,
	ShowOnLocator bit NULL,
	Disabled bit NULL,
	GeneratorNumber int NULL,
	Cashback bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ContractorGeneratorID)
);

call CreateIndexIfNotExists(null, 'contractorgen_idx1', 'ru_contractorgenerator', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'contractorgen_idx2', 'ru_contractorgenerator', 'BrandID', null);
call CreateIndexIfNotExists(null, 'contractorgen_idx3', 'ru_contractorgenerator', 'DistributorOrganizationID', null);
