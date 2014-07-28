Use rheem;

CREATE TABLE IF NOT EXISTS ru_contractorac(
	ContractorACID varchar(64) NOT NULL,
	OrganizationID varchar(64) NULL,
	BrandID varchar(64) NULL,
	DistributorOrganizationID varchar(64) NULL,
	DealerNumber varchar(50) NULL,
	Contact varchar(50) NULL,
	HVACLicense varchar(50) NULL,
	Disabled bit NULL,
	ShowOnLocator bit NULL,
	TopTen bit NULL,
	Funding varchar(50) NULL,
	Status varchar(50) NULL,
	ActivationDate datetime NULL,
	TerminationDate datetime NULL,
	TerminationReason varchar(50) NULL,
	LocatorPlacement int NULL,
	DealerThemesID varchar(64) NULL,
	DesignStar bit NULL,
	DesignStarActive bit NULL,
	DesignStarGizmo bit NULL,
	ProtectionPlus bit NULL,
	ProtectionPlusNumber varchar(50) NULL,
	ShowNateLogo bit NULL,
	Cashback bit NULL,
	CashBackSpecial bit NULL,
	CashBackText text NULL,
	DesignStarManagerPersonID varchar(64) NULL,
	ProtectionPlusEquiGuard varchar(50) NULL,
	Mechanical bit NULL,
	Commercial bit NULL,
	NateNumber varchar(50) NULL,
	AirTime500 bit NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	TopOne bit NOT NULL,
    PRIMARY KEY (ContractorACID)
);

call CreateIndexIfNotExists(null, 'contractorac_idx1', 'ru_contractorac', 'OrganizationID', null);
call CreateIndexIfNotExists(null, 'contractorac_idx2', 'ru_contractorac', 'BrandID', null);
call CreateIndexIfNotExists(null, 'contractorac_idx3', 'ru_contractorac', 'DistributorOrganizationID', null);
