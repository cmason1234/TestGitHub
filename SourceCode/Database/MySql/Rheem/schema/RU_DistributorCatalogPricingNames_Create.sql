Use rheem;

CREATE TABLE IF NOT EXISTS ru_distributorcatalogpricingnames(
	DistributorCatalogPricingNamesID varchar(64) NOT NULL,
	OrganizationID varchar(64) NOT NULL,
	BrandID varchar(64) NOT NULL,
	PricingName varchar(1000) NOT NULL,
	Remarks varchar(4000) NULL,
	IsActive bit NOT NULL,
	IsPublic bit NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (DistributorCatalogPricingNamesID),
	INDEX idx_dcp_1 (OrganizationID)
);

