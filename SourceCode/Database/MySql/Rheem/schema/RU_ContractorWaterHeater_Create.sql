Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorwaterheater(
	ContractorWaterHeaterID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	WHNumber varchar(50) NULL,
	VendorNumber varchar(50) NULL,
	Disabled bit NULL,
	Installer bit NULL,
	Retail bit NULL,
	ServiceContractor bit NULL,
	Repair bit NULL,
	Wholesaler bit NULL,
	StateLicense varchar(50) NULL,
	NumberOfInstallers int NULL,
	ResaleCertificate varchar(50) NULL,
	Commercial bit NULL,
	Residential bit NULL,
	Tankless bit NULL,
	ManufacturedHome bit NULL,
	ServiceWhatWeSell bit NULL,
	ServiceCommercialElectric bit NULL,
	ServiceCommercialGas bit NULL,
	ServiceResidentialElectric bit NULL,
	ServiceResidentialGas bit NULL,
	ServiceMobileHomeElectric bit NULL,
	ServiceMobileHomeGas bit NULL,
	ServiceTanklessElectric bit NULL,
	ServiceTanklessGas bit NULL,
	ServiceSolar bit NULL,
	TwentyFourHourServiceMF bit NULL,
	TwentyFourHourServiceSat bit NULL,
	TwentyFourHourServiceSun bit NULL,
	LicensedPlumber bit NULL,
	ShowRoom bit NULL,
	ShowOnLocator bit NULL,
	SellProduct bit NULL,
	NewInstallation bit NULL,
	ReplacementInstallation bit NULL,
	ContractDate datetime NULL,
	ContractExpiration datetime NULL,
	LicenseExpiration datetime NULL,
	InsuranceExpiration datetime NULL,
	BusinessExpiration datetime NULL,
	PlumbingExpiration datetime NULL,
	ResaleExpiration datetime NULL,
	ProClubMember bit NULL,
	ProClubActive bit NULL,
	ProClubNumber int NULL,
	PastPro varchar(50) NULL,
	FileDate datetime NULL,
	Rating int NULL,
	Rheem bit NULL,
	Ruud bit NULL,
	Richmond bit NULL,
	PrivateLabel bit NULL,
	HomeDepot bit NULL,
	GE bit NULL,
	NoGE bit NULL,
	Vanguard bit NULL,
	RheemTankless bit NULL,
	RuudTankless bit NULL,
	RheemTank bit NULL,
	RuudTank bit NULL,
	RichmondTankless bit NULL,
	PalomaTankless bit NULL,
	LocatorPlacement int NULL,
	DistributorOrganizationID varchar(64) NULL,
	NoAddressOnConsumer bit NULL,
	RankingPointsTankless int NULL,
	WeightedRankingTankless float NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	ASPDispatchEmail varchar(128) NULL,
	ASPOracleCustomerNumber int NULL,
	ASPHVACLicensed bit NULL,
	ASPDispatchByEmail bit NULL,
	ASPDispatchByFax bit NULL,
	ASPDispatchByElectronic bit NULL,
	ASPContact varchar(50) NULL,
	ASPSalesman varchar(50) NULL,
	ASPContactDateUpdated datetime NULL,
	ASPContactCancelDate datetime NULL,
    PRIMARY KEY (ContractorWaterHeaterID)
);

call CreateIndexIfNotExists(null, 'contwh_idx1', 'ru_contractorwaterheater', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'contwh_idx2', 'ru_contractorwaterheater', 'DistributorOrganizationID', null);
