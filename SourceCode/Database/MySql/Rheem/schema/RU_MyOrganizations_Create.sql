Use rheem;

CREATE TABLE IF NOT EXISTS ru_myorganizations(
    idMyOrganizations int(11) NOT NULL AUTO_INCREMENT,
	OrganizationID varchar(64) NOT NULL,
    PersonID varchar(64) NOT NULL,
	Primary Key (idMyOrganizations),
	INDEX myorgs_idx1 (PersonID),
	INDEX myorgs_idx2 (OrganizationID)
);

