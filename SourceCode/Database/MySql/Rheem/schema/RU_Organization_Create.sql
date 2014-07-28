Use rheem;

CREATE TABLE IF NOT EXISTS ru_organization(
	OrganizationID varchar(64) NOT NULL,
	OrganizationType char(32) NOT NULL,
	OrganizationName varchar(128) NOT NULL,
	Phone varchar(50) NULL,
	Phone2 varchar(50) NULL,
	Fax varchar(50) NULL,
	LogoDocumentID varchar(64) NULL,
	CreationDate datetime NULL,
	ModifiedDate datetime NULL,
	PrimaryAddressID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
    PRIMARY KEY (OrganizationID)
);

call CreateIndexIfNotExists(null, 'org_idx1', 'ru_organization', 'OrganizationType', null);
call CreateIndexIfNotExists(null, 'org_idx2', 'ru_organization', 'OrganizationName', null);
