Use rheem;

CREATE TABLE IF NOT EXISTS ru_distributororganization(
	DistributorOrganizationID varchar(64) NOT NULL,
	OrganizationID varchar(64) NOT NULL,
	DistributorID varchar(64) NOT NULL,
	DistributorNumber varchar(50) NULL,
	MFAccountCode varchar(50) NULL,
	Disabled bit NULL,
	ProStockStores bit NULL,
	DSMPersonID varchar(64) NULL,
	DTRPersonID varchar(64) NULL,
	DPMPersonID varchar(64) NULL,
	Corporate bit NULL,
	PrimaryAddressID varchar(64) NULL,
	SingleLine bit NULL,
	CountryID varchar(64) NULL,
	AC bit NULL,
	ACDisabled bit NULL,
	WHTank bit NULL,
	WHTankDisabled bit NULL,
	WHtankless bit NULL,
	WHTanklessDisabled bit NULL,
	DistributorWHNumber varchar(50) NULL,
	Generator bit NULL,
	GeneratorNumber varchar(50) NULL,
	GeneratorDisabled bit NULL,
	PoolSpa bit NULL,
	PoolSpaDisabled bit NULL,
	Parts bit NULL,
	PartsDisabled bit NULL,
	ScheduledPay bit NULL,
	WHSolar bit NULL,
	WHSolarDisabled bit NULL,
	WHHeatPump bit NULL,
	WHHeatPumpDisabled bit NULL,
	ManufacturedHousing bit NULL,
	WebSite varchar(512) NULL,
	OracleAccountNumber int NULL,
	OracleCustomerSiteNumberACD int NULL,
	OracleCustomerSiteNumberRPD int NULL,
	OracleCustomerSiteNumberWHD int NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (DistributorOrganizationID)
);

call CreateIndexIfNotExists(null, 'distorg_idx1', 'ru_distributororganization', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'distorg_idx2', 'ru_distributororganization', 'DistributorID', null);
call CreateIndexIfNotExists(null, 'distorg_idx3', 'ru_distributororganization', 'DSMPersonID', null);
call CreateIndexIfNotExists(null, 'distorg_idx4', 'ru_distributororganization', 'DTRPersonID', null);
call CreateIndexIfNotExists(null, 'distorg_idx5', 'ru_distributororganization', 'DPMPersonID', null);

Call AddColumnIfNotExists(null, 'ru_distributororganization', 'COOPEligible',  'bit NOT NULL DEFAULT 0');
Call AddColumnIfNotExists(null, 'ru_distributororganization', 'CorporateEmail', 'varchar(250) NULL');

