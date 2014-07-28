Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractororganization(
	ContractorOrganizationID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	ACContractor bit NULL,
	WaterHeaterContractor bit NULL,
	PoolAndSpaContractor bit NULL,
	GeneratorContractor bit NULL,
	ServiceContractorDELETE bit NULL,
	Installer bit NULL,
	Disabled bit NULL,
	KwikComfort bit NULL,
	KwikComfortNumber varchar(50) NULL,
	CorporateEmail varchar(50) NULL,
	CountryID varchar(64) NULL,
	WebSite varchar(128) NULL,
	MarketID varchar(64) NULL,
	Radius float NULL,
	FederalID varchar(50) NULL,
	BusinessType char(1) NULL,
	PrimaryAddressID varchar(64) NULL,
	FollowUp bit NULL,
	TAP bit NULL,
	RetailContractor bit NULL,
	ZipCodesUpdated datetime NULL,
	FactoryDirectContractor bit NULL,
	ServiceExperts bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	TimeZone varchar(1) NULL,
	CustomerAccountID varchar(50) NULL,
	SiteUseID varchar(50) NULL,
    PRIMARY KEY (ContractorOrganizationID)
);

call CreateIndexIfNotExists(null, 'contractororg_idx1', 'ru_contractororganization', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'contractororg_idx2', 'ru_contractororganization', 'PrimaryAddressID', null);

Call AddColumnIfNotExists(null, 'ru_contractororganization', 'CorporateEmail2',  'varchar(50) NULL');

Call AddColumnIfNotExists(null, 'ru_contractororganization', 'PHCC',  ' bit NOT NULL default 0');
Call AddColumnIfNotExists(null, 'ru_contractororganization', 'AboutUs',  'varchar(512) NULL');

