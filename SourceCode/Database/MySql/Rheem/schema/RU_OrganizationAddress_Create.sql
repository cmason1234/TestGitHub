Use rheem;

CREATE TABLE IF NOT EXISTS ru_organizationaddress(
	OrganizationAddressID varchar(64) NOT NULL,
	OrganizationID varchar(64) NOT NULL,
	AddressID varchar(64) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (OrganizationAddressID)
);

