Use rheem;

CREATE TABLE IF NOT EXISTS ru_organizationparent(
	OrganizationParentID varchar(64) NOT NULL,
	OrganizationID varchar(64) NOT NULL,
	ParentOrganizationID varchar(64) NOT NULL,
	Relationship varchar(50) NOT NULL,
	CreateDateTime__Gen datetime NULL,
	UpdateDateTime__Gen datetime NULL,
	PRIMARY KEY (OrganizationParentID)
);

call CreateIndexIfNotExists(NULL, 'orgparent_idx1', 'ru_organizationparent', 'OrganizationID', NULL);
call CreateIndexIfNotExists(NULL, 'orgparent_idx2', 'ru_organizationparent', 'ParentOrganizationID', NULL);

