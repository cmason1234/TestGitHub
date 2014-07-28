Use rheem;

CREATE TABLE IF NOT EXISTS ru_personorganization(
	PersonOrganizationID varchar(64) NOT NULL,
	PersonID varchar(64) NOT NULL,
	OrganizationID varchar(64) NOT NULL,
	Relationship varchar(50) NULL,
	RelationshipAbbreviation char(10) NULL,
	RelationshipID varchar(64) NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (PersonOrganizationID)
);

call CreateIndexIfNotExists(NULL, 'persorg_idx1', 'ru_personorganization', 'PersonID', NULL);
call CreateIndexIfNotExists(NULL, 'persorg_idx2', 'ru_personorganization', 'OrganizationID', NULL);
