Use rheem;

CREATE TABLE IF NOT EXISTS ru_myorganizationparents(
    idMyOrganizations int(11) NOT NULL AUTO_INCREMENT,
	OrganizationID varchar(64) NOT NULL,
    PersonID varchar(64) NOT NULL,
	Primary Key (idMyOrganizations),
	INDEX myorgspar_idx1 (PersonID),
	INDEX myorgspar_idx2 (OrganizationID)
);

