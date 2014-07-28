Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorpoolspa(
	ContractorPoolSpaID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	DistributorOrganizationID varchar(64) NULL,
	ShowOnLocator bit NULL,
	PoolSpaNumber int NULL,
	Disabled bit NULL,
	WarrantyServiceProvider bit NULL,
	HeatPumpServiceProvider bit NULL,
	GasPoolHeaterServiceProvider bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	GasWarrantyStation bit NOT NULL,
	HeatPumpWarrantyStation bit NOT NULL,
    PRIMARY KEY (ContractorPoolSpaID)
);

call CreateIndexIfNotExists(null, 'contractorps_idx1', 'ru_contractorpoolspa', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'contractorps_idx2', 'ru_contractorpoolspa', 'DistributorOrganizationID', null);
