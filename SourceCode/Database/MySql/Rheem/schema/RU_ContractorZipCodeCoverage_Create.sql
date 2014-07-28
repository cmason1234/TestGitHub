Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorzipcodecoverage(
	ContractorZipCodeCoverageID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	PostalCode varchar(50) NULL,
	Exclude bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ContractorZipCodeCoverageID)
);

call CreateIndexIfNotExists(null, 'contzipcov_idx1', 'ru_contractorzipcodecoverage', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'contzipcov_idx2', 'ru_contractorzipcodecoverage', 'PostalCode', null);
