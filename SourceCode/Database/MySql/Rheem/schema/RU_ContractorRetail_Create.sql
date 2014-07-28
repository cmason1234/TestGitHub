Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorretail(
	ContractorRetailID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	HomeDepot bit NULL,
	HDVendorNumber int NULL,
	Contact varchar(50) NULL,
	Disabled bit NULL,
	HDCashback bit NULL,
	PersonCreated datetime NULL,
	LiteratureBundleCount int NULL,
	VendorNumber int NULL,
	HDShowOnLocator bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (ContractorRetailID)
);

call CreateIndexIfNotExists(null, 'contret_idx1', 'ru_contractorretail', 'OrganizationID', null);
