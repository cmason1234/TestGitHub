Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorretailpreferreddistributor(
	ContractorRetailPreferredDistributorID varchar(64) NOT NULL,
	OrganizationIDContractor varchar(64) NOT NULL,
	OrganizationIDDistributor varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (ContractorRetailPreferredDistributorID)
);

